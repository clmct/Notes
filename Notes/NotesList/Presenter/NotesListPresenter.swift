//
//  NotesPresenter.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

final class NotesListPresenter {
  
  weak var viewController: NotesListViewController?
  
  init(viewController: NotesListViewController) {
    self.viewController = viewController
  }
  
}
