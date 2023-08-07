//
//  ViewController.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Hakan Körhasan on 7.08.2023.
//

import UIKit

class ViewController: UIViewController {

    let mainView = MainView()
    
    
    //dataSource adında bir UICollectionViewDiffableDataSource örneği oluşturuluyor. Bu, koleksiyon görünümünün veri kaynağını yönetmek için kullanılacak.
    var dataSource: UICollectionViewDiffableDataSource<Section, User>?
    
    
    //Bu fonksiyon, view controller'ın görünümünü mainView ile değiştirir. Bu şekilde, oluşturulan MainView örneği view controller'ın ana görünümü haline gelir.
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        getUsers()
    }
    
    //Bu fonksiyon, koleksiyon görünümünü oluşturur ve yapılandırır. Koleksiyon hücrelerinin görünümü ve içeriği ayarlanır.
    func setupCollectionView() {
        
        //Bu satırda, koleksiyon hücrelerinin kayıt (registration) işlemi yapılır. Her hücre oluşturulduğunda ne yapılacağı tanımlanır. Hücre içeriğine kullanıcının adı atanır.
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, User> {
            cell, indexPath, user in
            
            var content = cell.defaultContentConfiguration()
            content.text = user.name
            cell.contentConfiguration = content
        }
        
        //Bu satırda, dataSource örneği oluşturulur ve koleksiyon görünümüne bağlanır. Koleksiyon hücrelerinin nasıl dequeued ve yapılandırılacağı tanımlanır.
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: mainView.collectionView) { (colletionView, indexPath, user) in
            
            colletionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: user)
        }
    }
    
    func getUsers() {
        NetworkingService.requestUsers  { [weak self] result in
            switch result {
            case .success(let users):
                self?.populate(with: users)
                print(users)
            case .failure(let err):
                print(err)
            }
        }
    }

    //Bu fonksiyon, koleksiyon görünümünü günceller. Yeni bir görünüm snapshot'i oluşturur, kullanıcıları ekler ve bu snapshot'i kullanarak dataSource'ı günceller.
    func populate(with users: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource?.apply(snapshot)
    }

}

extension ViewController {
    enum Section {
        case main
    }
}
