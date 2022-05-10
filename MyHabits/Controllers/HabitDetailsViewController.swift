//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 05.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    //MARK: - var delegate
    weak var delegate: HabitViewControllerDelegate?
    //MARK: - var
    private let store = HabitsStore.shared
    private let habit: Habit
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return tableView
    }()
    private lazy var editButton: UIBarButtonItem = UIBarButtonItem(title: "Править",
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(edit))
    
    //MARK: - init
    init(with habit: Habit){
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = habit.name
        navigationItem.rightBarButtonItem = editButton
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
    //MARK: - @objc func
    @objc func edit(){
        let habitViewController = HabitViewController(.edit)
        habitViewController.habit = habit
        let navigationHabitViewController = UINavigationController(rootViewController: habitViewController)
        navigationHabitViewController.modalPresentationStyle = .fullScreen
        
        habitViewController.closureForTitle = { [weak self] text in
            self?.navigationItem.title = text
        }
        habitViewController.closureForClose = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        habitViewController.delegate = delegate
        
        present(navigationHabitViewController, animated: true)
    }
}

//MARK: - extension

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
