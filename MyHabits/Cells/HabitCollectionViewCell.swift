//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Востриков on 30.03.2022.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit? {
        didSet{
            guard let habit = habit else { return }
            let habitColor = habit.color
            habitNameLabel.text = habit.name
            habitNameLabel.textColor = habitColor

            timeHabitLabel.text = habit.dateString
            countLabel.text = "Счетчик: " + String(habit.trackDates.count)

            checkBoxButton.layer.borderColor = habitColor.cgColor
            if habit.trackDates.count > 0 {
                checkBoxButton.backgroundColor = habitColor
                checkBoxButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                checkBoxButton.tintColor = .white
            }
        }
    }
    
//    var indexPath: IndexPath?
    
//    weak var delegate: HabitCollectionViewCellDelegate?
    
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
    let checkBoxButton: UIButton = {
        let checkBoxButton = UIButton()
        checkBoxButton.toAutoLayout()
        checkBoxButton.layer.cornerRadius = 19
        checkBoxButton.layer.borderWidth = 2
        checkBoxButton.backgroundColor = .white
        
        return checkBoxButton
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        setup()
        checkBoxButton.addTarget(self, action: #selector(checkBoxTaped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private func
    private func setup(){
        contentView.addSubviews(habitNameLabel, timeHabitLabel, countLabel, checkBoxButton)
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
            
            checkBoxButton.heightAnchor.constraint(equalToConstant: 38),
            checkBoxButton.widthAnchor.constraint(equalTo: checkBoxButton.heightAnchor),
            checkBoxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBoxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26)
        ].forEach { $0.isActive = true }
    }
    
    //MARK: - @objc func
    @objc func checkBoxTaped(){
        guard let habit = habit else { return }
        let store = HabitsStore.shared
        if  !habit.isAlreadyTakenToday {
            store.track(habit)
            checkBoxButton.backgroundColor = habit.color
            checkBoxButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            checkBoxButton.tintColor = .white
            countLabel.text = "Счетчик: " + String(habit.trackDates.count)
        }
    }
}
