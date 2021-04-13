//
//  CoreAssembly.swift
//  Notes
//
//  Created by Almat Kulbaev on 19.03.2021.
//

import Foundation

protocol CoreAssemblyProtocol {
  var coreDataStack: CoreDatasStackProtocol { get }
}

final class CoreAssembly: CoreAssemblyProtocol {
  lazy var coreDataStack: CoreDatasStackProtocol = CoreDataStack()
}
