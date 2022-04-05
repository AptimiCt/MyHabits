//
//  HabitDetailsViewControllerCell.swift
//  MyHabits
//
//  Created by Александр Востриков on 05.04.2022.
//

import UIKit

class HabitDetailsViewControllerCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    
//    let dateLabel: UILabel = {
//        let dateLabel = UILabel()
//        dateLabel.toAutoLayout()
//        dateLabel.font = .preferredFont(forTextStyle: .body)
//        dateLabel.font = .systemFont(ofSize: 17, weight: .regular)
//        return dateLabel
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}
