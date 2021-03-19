//
//  NoteCell.swift
//  Notes
//
//  Created by Алмат Кульбаев on 15.03.2021.
//

import UIKit

final class NoteCell: UITableViewCell, ConfigurableCellProtocol {
  func configure(with model: ConversationModel) {
    
//    let textComponents = model.text?.components(separatedBy: "\n")
//    let titleComponent: String = textComponents?[0] ?? ""
//    let descriptionComponent: String = textComponents?.count =>2 ?  "  " :  textComponents?[1]
    
    self.titleLabel.text = model.text
    self.descriptionLabel.text = model.identifire
    
    if let date = model.date {
      
      let today = Date.init()
      let formatterToday = DateFormatter()
      formatterToday.dateFormat = "MM.dd.yyyy"
      let todayString = formatterToday.string(from: today)
      
      
      let formatter = DateFormatter()
      formatter.dateFormat = "MM.dd.yyyy HH:mm"
      let dateString = formatter.string(from: date)
      
      let dateComponents =  dateString.split(separator: " ")
      
      if todayString == dateComponents[0] {
        self.dateLabel.text = String(dateComponents[1])
      } else {
        self.dateLabel.text = String(dateComponents[0])
      }
      
    }
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
  
  lazy var dateLabel: UILabel = {
    let date = UILabel()
    date.translatesAutoresizingMaskIntoConstraints = false
    date.numberOfLines = 1
    date.font = .systemFont(ofSize: 16)
    date.textColor = .lightGray
    return date
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
    contentView.addSubview(dateLabel)
  }
  
  func setupLayout() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
    ])
    
    NSLayoutConstraint.activate([
      dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
    
    NSLayoutConstraint.activate([
      descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 5),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
    
  }
}
