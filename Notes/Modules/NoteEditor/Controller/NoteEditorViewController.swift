//
//  NoteEditorViewController.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

final class NoteEditorViewController: UIViewController {
  
  var presenter: NoteEditorPresenterProtocol?
  var textView: UITextView = {
    var textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  override func viewDidLoad() {
    setupLayout()
  }
}

private extension NoteEditorViewController {
  func setupLayout() {
    self.view.addSubview(textView)
    NSLayoutConstraint.activate([
      textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      textView.topAnchor.constraint(equalTo: self.view.topAnchor),
      textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
  }
}
