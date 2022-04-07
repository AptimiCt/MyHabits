//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 05.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    //MARK: - var
    private let store = HabitsStore.shared
    private let habit: Habit
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return tableView
    }()
    
    //MARK: - init
    init(with habit: Habit){
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = habit.name
        tableView.delegate = self
        tableView.dataSource = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
}
//MARK: - extension
extension HabitDetailsViewController: UITableViewDelegate {
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.dates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)

        let index = store.dates.count - indexPath.row - 1
        let date = store.trackDateString(forIndex: index)
        cell.textLabel?.text = date
        cell.accessoryType = store.habit(habit, isTrackedIn: store.dates[index]) ? .checkmark :  .none
        
        return cell
    }
}
