//
//  ViewController.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Hakan Körhasan on 7.08.2023.
//

import UIKit

class ViewController: UIViewController {

    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()
    }
    
    func getUsers() {
        NetworkingService.requestUsers { result in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let err):
                print(err)
            }
        }
    }


}

