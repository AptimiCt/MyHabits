//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 25.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    init(){
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        self.title = "Сегодня"
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton)), animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func addButton(){
        let habitViewController = HabitViewController(.edit)
        let navigationHabitViewController = UINavigationController(rootViewController: habitViewController)
        navigationHabitViewController.modalPresentationStyle = .fullScreen
        present(navigationHabitViewController, animated: true)
    }
}

