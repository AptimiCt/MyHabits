//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Востриков on 30.03.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private let habitNameLabel: UILabel = {
        let habitNameLabel = UILabel()
        habitNameLabel.toAutoLayout()
        habitNameLabel.numberOfLines = 2
        habitNameLabel.font = .preferredFont(forTextStyle: .headline)
        habitNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        return habitNameLabel
    }()
    private let timeHabitLabel: UILabel = {
        let timeHabitLabel = UILabel()
        timeHabitLabel.toAutoLayout()
        timeHabitLabel.font = .preferredFont(forTextStyle: .caption1)
        timeHabitLabel.font = .systemFont(ofSize: 12, weight: .regular)
        timeHabitLabel.textColor = .systemGray2
        return timeHabitLabel
    }()
    private let countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.toAutoLayout()
        countLabel.font = .preferredFont(forTextStyle: .footnote)
        countLabel.font = .systemFont(ofSize: 13, weight: .regular)
        countLabel.textColor = .systemGray
        return countLabel
    }()
    private let checkBoxView: UIButton = {
        let checkBoxView = UIButton()
        checkBoxView.toAutoLayout()
        checkBoxView.layer.cornerRadius = 19
        checkBoxView.layer.borderWidth = 2
        checkBoxView.backgroundColor = .white
        return checkBoxView
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private func
    private func setup(){
        contentView.addSubviews(habitNameLabel, timeHabitLabel, countLabel, checkBoxView)
        configureConstraints()
    }
    private func configureConstraints(){
        [
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -103),
            habitNameLabel.bottomAnchor.constraint(equalTo: timeHabitLabel.topAnchor, constant: -4),
            
            timeHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeHabitLabel.trailingAnchor.constraint(equalTo: habitNameLabel.trailingAnchor),
            timeHabitLabel.bottomAnchor.constraint(lessThanOrEqualTo: countLabel.topAnchor, constant: -8),
            
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countLabel.trailingAnchor.constraint(equalTo: habitNameLabel.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkBoxView.heightAnchor.constraint(equalToConstant: 38),
            checkBoxView.widthAnchor.constraint(equalTo: checkBoxView.heightAnchor),
            checkBoxView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBoxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26)
        ].forEach { $0.isActive = true }
    }
    //MARK: - func
    func configure(with habit: Habit) {
        let habitColor = habit.color
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habitColor
        
        timeHabitLabel.text = habit.dateString
        countLabel.text = "Счетчик: " + String(habit.trackDates.count)
        
        checkBoxView.layer.borderColor = habitColor.cgColor
        if habit.trackDates.count > 0 {
            checkBoxView.backgroundColor = habitColor
            checkBoxView.setImage(UIImage(systemName: "checkmark"), for: .normal)
            checkBoxView.tintColor = .white
        }
    }
}
