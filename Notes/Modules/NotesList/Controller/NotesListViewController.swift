//
//  NotesListViewController.swift
//  Notes
//
//  Created by Алмат Кульбаев on 13.03.2021.
//

import UIKit

final class NotesListViewController: UIViewController {
  
  var tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    return tableView
  }()
  
  var presenter: NotesListPresenterProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifire)
  }
  
  func setupLayout() {
    self.view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
  }
  
}


extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifire, for: indexPath) as? NoteCell else {
      return UITableViewCell()
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.showNoteEditor()
  }
  
}
