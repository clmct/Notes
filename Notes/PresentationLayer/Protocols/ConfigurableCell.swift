//
//  ConfigurableCell.swift
//  Notes
//
//  Created by Алмат Кульбаев on 18.03.2021.
//

import Foundation

protocol ConfigurableCellProtocol {
  associatedtype ConversationModel
  func configure(with model: ConversationModel)
}
