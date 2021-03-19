//
//  InputAccessoryView.swift
//  Notes
//
//  Created by Алмат Кульбаев on 17.03.2021.
//

import UIKit

class InputAccessoryView: UIView {
  
  var toolbar: UIToolbar!
  var completionButtonKeyboard: (() -> ())?
  var completion: AttributeCompletion?
  
  override func didMoveToWindow() {
    super.didMoveToWindow()
    if let window = self.window {
      self.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: window.safeAreaLayoutGuide.bottomAnchor,
                                   multiplier: 1.0).isActive = true
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
    setButtons()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension InputAccessoryView {
  func setupLayout() {
    toolbar = UIToolbar(frame: frame)
    self.addSubview(toolbar)
    self.autoresizingMask = .flexibleHeight
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      toolbar.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0),
      toolbar.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 0),
      toolbar.topAnchor.constraint(equalTo: self.topAnchor,constant: 2),
      toolbar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: 0),
    ])
  }
  
  func setButtons() {
    let bold = UIBarButtonItem(image: UIImage(systemName: "bold"), style: .plain, target: self, action: #selector(boldAction))
    let italic = UIBarButtonItem(image: UIImage(systemName: "italic"), style: .plain, target: self, action: #selector(italicAction))
    let highlighter = UIBarButtonItem(image: UIImage(systemName: "highlighter"), style: .plain, target: self, action: #selector(highlighterAction))
    let clear = UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(clearAction))
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    toolbar.items = [bold, spacer, italic, spacer, highlighter, spacer, spacer, clear, spacer, doneButton]
    toolbar.sizeToFit()
  }
  
  // Actions
  @objc func boldAction() {
//    textStorage.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: textView.selectedRange )
//    completion
  }
  @objc func italicAction() {
//    textStorage.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 20), range: textView.selectedRange )
  }
  @objc func highlighterAction() {
    
  }
  @objc func clearAction() {
//    textStorage.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 20), range: textView.selectedRange )
  }
  @IBAction func doneAction() {
    self.completionButtonKeyboard!()
//    self.textView.resignFirstResponder()
//    self.view.endEditing(true)
  }
}
