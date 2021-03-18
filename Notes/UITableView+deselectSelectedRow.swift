//
//  UITableView + deselectSelectedRow.swift
//  Notes
//
//  Created by Алмат Кульбаев on 18.03.2021.
//

import UIKit

extension UITableView {
  func deselectSelectedRow(animated: Bool)
  {
    if let indexPathForSelectedRow = self.indexPathForSelectedRow {
      self.deselectRow(at: indexPathForSelectedRow, animated: animated)
    }
  }
}
