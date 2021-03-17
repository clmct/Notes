//
//  NoteCell.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

final class NoteCell: UITableViewCell, ConfigurableCellProtocol {
  func configure(with model: ConversationModel) {
    self.titleLabel.text = model.text
    self.descriptionLabel.text = model.identifire
  }
  
  typealias ConversationModel = NoteModel
  
  static var identifire = "NoteCell"
  
  lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.translatesAutoresizingMaskIntoConstraints = false
    title.text = "Как я писал приложение заметки для поступления в ЦФТ"
    title.numberOfLines = 1
    title.font = .boldSystemFont(ofSize: 18)
    return title
  }()
  
  lazy var descriptionLabel: UILabel = {
    let description = UILabel()
    description.translatesAutoresizingMaskIntoConstraints = false
    description.text = "Я выбрал архитектуру MVP. Core Data. iOS 13+"
    description.numberOfLines = 1
    description.font = .systemFont(ofSize: 16)
    description.textColor = .lightGray
    
    return description
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubviews()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addSubviews() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
  }
  
  func setupLayout() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
    ])
    
    NSLayoutConstraint.activate([
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
    
  }
}
