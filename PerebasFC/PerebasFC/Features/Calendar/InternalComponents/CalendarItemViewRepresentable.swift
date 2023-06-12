//
//  CalendarItemViewRepresentable.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 11/06/23.
//

import HorizonCalendar
import UIKit

struct DayLabel: CalendarItemViewRepresentable {

  struct InvariantViewProperties: Hashable {
    let font: UIFont
    let textColor: UIColor
    let backgroundColor: UIColor
  }

  struct Content: Equatable {
    let day: Day
  }

  static func makeView(
    withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> UILabel
  {
    let label = UILabel()

    label.backgroundColor = invariantViewProperties.backgroundColor
    label.font = invariantViewProperties.font
    label.textColor = invariantViewProperties.textColor

    label.textAlignment = .center
    label.clipsToBounds = true
    label.layer.cornerRadius = 12
    
    return label
  }

  static func setContent(_ content: Content, on view: UILabel) {  
    view.text = "\(content.day.day)"
  }

}
