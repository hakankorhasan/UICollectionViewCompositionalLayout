//
//  User.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Hakan Körhasan on 7.08.2023.
//

import UIKit

struct User: Decodable {
    let id: Int
    let name: String
}

extension User: Hashable {
    
}
