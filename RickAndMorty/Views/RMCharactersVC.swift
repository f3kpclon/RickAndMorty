//
//  RMCharactersVC.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 29-03-21.
//

import UIKit

class RMCharactersVC: RMLoadingDataVC {
    
    var characters      : [Character] = []
    var collectionView  : UICollectionView!
    var dataSource      : UICollectionViewDiffableDataSource<Constants.Section,Character>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configCollectionView()
        getCharacters()
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
    
    func getCharacters()  {
        NetworkManager.shared.getAllCharacters { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let characters):
                self.characters.append(contentsOf: characters)
                
                self.updateDataSource(on: self.characters)
                print(characters)
            case .failure(let error):
            print(error)
            }
            
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

extension RMCharactersVC: UICollectionViewDelegate {
    
}
