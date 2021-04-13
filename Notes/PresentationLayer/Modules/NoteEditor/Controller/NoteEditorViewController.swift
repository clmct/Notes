//
//  NoteEditorViewController.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

extension NoteEditorViewController: NoteEditorViewControllerDelegate {
  func setData(model: NoteModel) {
    self.textView.text = model.text
    self.note = model
  }
}

final class NoteEditorViewController: UIViewController {

  var presenter: NoteEditorPresenterProtocol?
  var textView: UITextView = {
    let textView = UITextView()
    textView.keyboardDismissMode = .interactive
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = .systemFont(ofSize: 20)
    return textView
  }()
  
  var note: NoteModel!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    self.title = "Note"
    self.setupBackground()
    self.setupTextView()
    presenter?.fetchData()
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  override var inputAccessoryView: UIView? {
    let view = InputAccessoryView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
    view.completionButtonKeyboard = { [unowned self] in
      self.textView.resignFirstResponder()
    }
    return view
  }
  
  deinit {
    presenter?.update(with: self.textView.text)
  }

}

private extension NoteEditorViewController {
  
  func setupTextView() {
    view.addSubview(textView)
    NSLayoutConstraint.activate([
      textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  func setupBackground() {
    let background = UIView()
    background.translatesAutoresizingMaskIntoConstraints = false
    background.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    view.addSubview(background)

    NSLayoutConstraint.activate([
      background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      background.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
      background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  
  }
}
