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

typealias AttributeCompletion = (AnyObject?) -> ()

final class NoteEditorViewController: UIViewController {

  var presenter: NoteEditorPresenterProtocol?
  var textView: UITextView!
  var layoutManager: NSLayoutManager!
  var textStorage: NSTextStorage!
  var note: NoteModel!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBackground
    self.title = "Note"
    self.setupBackground()
    self.setupTextKitStack()
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

// MARK - NSTextStorageDelegate
extension NoteEditorViewController: NSTextStorageDelegate {
  func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
    // redraw selection
    let beginning: UITextPosition = textView.beginningOfDocument
    let start: UITextPosition = textView.position(from: beginning, offset: textView.selectedRange.location)!
    let end: UITextPosition = textView.position(from: start, offset: textView.selectedRange.length)!
    
    textView.selectedRange = NSMakeRange(0, 0)
    textView.selectedTextRange = textView.textRange(from: start, to: end)
  }
}

private extension NoteEditorViewController {
  func setupTextKitStack() {
    // Создаем NSTextStorage
    textStorage = NSTextStorage()
    textStorage.delegate = self
    
    // Создаем NSLayoutManager и добавляем его в NSTextStorage
    layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)
    
    // Создаем NSTextContainer и добавляем его в NSLayoutManager
    let textContainer = NSTextContainer(size: self.view.bounds.size)
    layoutManager.addTextContainer(textContainer)
    
    // Создаем UITextView c заданным NSTextContainer
    textView = UITextView(frame: self.view.bounds, textContainer: textContainer)
    textView.keyboardDismissMode = .interactive
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(textView)
    NSLayoutConstraint.activate([
      textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    setupDefaultState()
  }
  
  func setupDefaultState() {
    let text = ""
    let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0)])
    textStorage.setAttributedString(attributedString)
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
  
  typealias AttributeCompletion = (AnyObject?) -> ()
  
  func onComplete(_ attribute: String) -> (AttributeCompletion) {
      let range = NSMakeRange(0, textStorage.length)
      
      func fnValue (_ value: AnyObject?) {
          if let attributeValue: AnyObject = value {
            textStorage.addAttribute(NSAttributedString.Key(rawValue: attribute), value: attributeValue, range:range)
          } else {
            textStorage.removeAttribute(NSAttributedString.Key(rawValue: attribute), range: range)
          }
      }
      return fnValue;
  }
  
}
