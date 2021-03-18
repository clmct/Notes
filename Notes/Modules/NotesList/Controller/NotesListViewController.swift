//
//  NotesListViewController.swift
//  Notes
//
//  Created by Алмат Кульбаев on 13.03.2021.
//

import UIKit
import CoreData

final class NotesListViewController: UIViewController {
  
  var tableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  lazy var fetchedResultsController: NSFetchedResultsController<NoteModel> = {
    let fetchRequest = NSFetchRequest<NoteModel>()
    let entity = NoteModel.entity()
    fetchRequest.entity = entity
    
    let sort1 = NSSortDescriptor(key: "date", ascending: false)
    fetchRequest.sortDescriptors = [sort1]
    
    let fetchedResultsController = NSFetchedResultsController(
              fetchRequest: fetchRequest,
      managedObjectContext: self.presenter!.getContext(),
        sectionNameKeyPath: nil,
      cacheName: nil)
    
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()
  
  var presenter: NotesListPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Notes"
    setupLayout()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifire)
    setupButton()
    performFetch()
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    self.tableView.deselectSelectedRow(animated: true)
  }
  
  func performFetch() {
    do {
      try
      fetchedResultsController.performFetch()
        tableView.reloadData()
    } catch {
      fatalError()
    }
  }
  
  func setupButton() {
    let createNote = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(createNoteAction))
    self.navigationItem.rightBarButtonItem = createNote
  }
  
  
  @objc func createNoteAction() {
    presenter?.showAddNote()
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


extension NotesListViewController: NSFetchedResultsControllerDelegate {
  
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    print("\(#function)")
    self.tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    print("\(#function)")
    self.tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChange anObject: Any,
                  at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType,
                  newIndexPath: IndexPath?) {
    
    switch type {
    case .insert:
      guard let newIndexPath = newIndexPath else { return }
      tableView.insertRows(at: [newIndexPath], with: .automatic)
    case .move:
      guard let newIndexPath = newIndexPath, let indexPath = indexPath else { return }
      tableView.deleteRows(at: [indexPath], with: .automatic)
      tableView.insertRows(at: [newIndexPath], with: .automatic)
    case .update:
      guard let indexPath = indexPath else { return }
      if let cell = tableView.cellForRow(at: indexPath) as? NoteCell {
        guard let note = controller.object(at: indexPath) as? NoteModel else { return }
        cell.configure(with: note)
      }
      tableView.reloadRows(at: [indexPath], with: .automatic)
    case .delete:
      guard let indexPath = indexPath else { return }
      tableView.deleteRows(at: [indexPath], with: .automatic)
    default:
      print("switch type is defuailt")
    }
  }
}


extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let note = fetchedResultsController.object(at: indexPath)
      presenter?.getContext().delete(note)
      do {
        try presenter?.getContext().save()
      } catch {
      }
    }
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    fetchedResultsController.fetchedObjects?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifire, for: indexPath) as? NoteCell else {
      return UITableViewCell()
    }
    let note = fetchedResultsController.object(at: indexPath)
    cell.configure(with: note)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let identifire = fetchedResultsController.object(at: indexPath).identifire else { return }
      presenter?.showNoteEditor(identifire: identifire)
  }
}
