//
//  Protocol.swift
//  InClass10
//
//  Created by Carlos Rosario on 8/4/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import Foundation

protocol refreshPhotosDelegate: class {
    func refresh(row: Int)
}