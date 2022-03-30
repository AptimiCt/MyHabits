//
//  TabBarController.swift
//  MyHabits
//
//  Created by Александр Востриков on 26.03.2022.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let habitsVC = HabitsViewController()
        let infoVC = InfoViewController()
        let navigationHabitsVC = UINavigationController(rootViewController: habitsVC)
        navigationHabitsVC.navigationBar.prefersLargeTitles = true
        habitsVC.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "TabBarIcon"), tag: 0)
        let navigationInfoVC = UINavigationController(rootViewController: infoVC)
        infoVC.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        self.viewControllers = [navigationHabitsVC,navigationInfoVC]
        self.selectedViewController = navigationHabitsVC
    }
}
