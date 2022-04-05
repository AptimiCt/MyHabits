//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 05.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let store = HabitsStore.shared
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HabitDetailsViewControllerCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return tableView
    }()
    
    init(with title: String){
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath) as! HabitDetailsViewControllerCell
        
        let dateF = store.trackDateString(forIndex: indexPath.row)
        
        let habitL = store.habits[indexPath.row]
        
        cell.textLabel?.text = dateF
        //cell.detailTextLabel?.text = habitL.name
        
        
        //print("dateF:\(dateF) - date:\(date)")
        
        let h = store.habits[indexPath.row]
        
        for hs in h.trackDates {
            print("date:\(hs) - \(h.date)")
        }
        print("\(store.habit(store.habits[indexPath.row], isTrackedIn: habitL.date))")
        if store.habit(store.habits[indexPath.row], isTrackedIn: habitL.date) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
}
