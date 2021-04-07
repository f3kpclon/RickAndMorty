//
//  RMCharactersVC.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 29-03-21.
//

import UIKit

class RMCharactersVC: UIViewController {
    
    var characters          : [Character] = []
    var collectionView      : UICollectionView!
    var dataSource          : UICollectionViewDiffableDataSource<Constants.Section,Character>!
    var filteredCharacters  : [Character] = []
    var hasMoreCharacters   = true
    var isSearching         = false
    var isLoading           = false
    var page                = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configCollectionView()
        configSearchController()
        getCharacters(page: page)
        configDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
//MARK: CONFIG ViewController
private extension RMCharactersVC {
    
    func configViewController()  {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func getCharacters(page : Int)  {
        view.customActivityIndicator()
        isLoading = true
        NetworkManager.shared.getAllCharacters (page: page){ [weak self] result in
            guard let self = self else {return}
            self.removeActivity()
            switch result {
            case .success(let characters):
                if characters.count < 20 {self.hasMoreCharacters = false}
                self.characters.append(contentsOf: characters)
                
                self.updateDataSource(on: self.characters)
            case .failure(let error):
            print(error)
            }
            self.isLoading = false
        }
    }
    
    func removeActivity()  {
        DispatchQueue.main.async {
            self.view.removeActivityIndicator()
        }
    }
    
    
}
//MARK:Config CollectionView
extension RMCharactersVC {
    
    func configCollectionView()  {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharCell.self, forCellWithReuseIdentifier: CharCell.reuseID)
    }
    
    func configDataSource()  {
        dataSource = UICollectionViewDiffableDataSource<Constants.Section, Character>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharCell.reuseID, for: indexPath) as! CharCell
            cell.setCharacters(characters: character)
            return cell
        })
    }
    
    func updateDataSource(on characters: [Character])  {
        var snapshot = NSDiffableDataSourceSnapshot<Constants.Section,Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}

//MARK: UICollectionView Delegate
extension RMCharactersVC: UICollectionViewDelegate {
//    func when the scroll ends load more characters
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreCharacters,!isLoading else {return}
            page += 1
            getCharacters(page: page)
        }
        
    }
}

//MARK: functions to use de searchBar
extension RMCharactersVC: UISearchBarDelegate, UISearchResultsUpdating {
//    func para busqueda
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text?.lowercased(), !filter.isEmpty else {
            filteredCharacters.removeAll()
            updateDataSource(on: characters)
            return
            
        }
        isSearching = true
        filteredCharacters = characters.filter { character -> Bool in
            return character.name.lowercased().contains(filter)
        }
//        guard filteredCharacters.count != 0 else {
//            
//        }
        updateDataSource(on: filteredCharacters)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateDataSource(on: characters)
    }
}
