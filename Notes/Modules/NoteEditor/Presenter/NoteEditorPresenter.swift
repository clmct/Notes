//
//  NoteEditorPresenter.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import Foundation

protocol NoteEditorPresenterProtocol {
  
}

final class NoteEditorPresenter: NoteEditorPresenterProtocol {
  
  weak var viewController: NoteEditorViewController?
  
  init(viewController: NoteEditorViewController) {
    self.viewController = viewController
  }
  
}
