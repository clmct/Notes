//
//  ServiceAssemblyProtocol.swift
//  Notes
//
//  Created by Almat Kulbaev on 19.03.2021.
//

import Foundation

protocol ServiceAssemblyProtocol {
  var coreDataService: CoreDataServiceProtocol { get set }
}

final class ServiceAssembly: ServiceAssemblyProtocol {
  
  private var coreAssembly: CoreAssemblyProtocol
  
  init(coreAssembly: CoreAssemblyProtocol) {
    self.coreAssembly = coreAssembly
  }
  
  lazy var coreDataService: CoreDataServiceProtocol = {
    let coreDataStack = coreAssembly.coreDataStack
    return CoreDataService(coreDatasStack: coreDataStack)
  }()
  
}
