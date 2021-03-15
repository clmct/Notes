//
//  Assembly.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

protocol AssemblyProtocol {
  func createNotesListModule() -> UIViewController
}

final class Assembly: AssemblyProtocol {
  func createNotesListModule() -> UIViewController {
    let viewController = NotesListViewController()
    let presenter = NotesListPresenter(viewController: viewController)
    viewController.presenter = presenter
    return viewController
  }
  
}
