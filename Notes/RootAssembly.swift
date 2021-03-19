//
//  RootAssembly.swift
//  Notes
//
//  Created by Almat Kulbaev on 19.03.2021.
//

import Foundation

protocol RootAssemblyProtocol {
  var presentationAssembly: PresentationAssemblyProtocol { get }
}

final class RootAssembly: RootAssemblyProtocol {
  lazy var presentationAssembly: PresentationAssemblyProtocol = PresentationAssembly(serviceAssembly: self.serviceAssembly)
  private lazy var serviceAssembly: ServiceAssemblyProtocol = ServiceAssembly(coreAssembly: self.coreAssembly)
  private lazy var coreAssembly: CoreAssemblyProtocol = CoreAssembly()
}
