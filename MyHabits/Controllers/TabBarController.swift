//
//  TabBarController.swift
//  MyHabits
//
//  Created by Александр Востриков on 26.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let habitsVC = HabitsViewController()
        let infoVC = InfoViewController()
        let navigationVC = UINavigationController(rootViewController: habitsVC)
       
        habitsVC.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "TabBarIcon"), tag: 0)
        
        infoVC.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        self.viewControllers = [navigationVC,infoVC]
    }


}
