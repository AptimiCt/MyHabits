//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 25.03.2022.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    //MARK: - var
    let store = HabitsStore.shared
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: Constants.habitCollectionViewCell)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: Constants.progressCollectionViewCell)
        collectionView.backgroundColor = UIColor(named: Constants.lightGrayColor)
        collectionView.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    //MARK: - init
    init(){
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        self.title = Constants.titleForHabitsVC
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton)), animated: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(UIView())
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.pin(to: view)
    }

    //MARK: - @objc func
    @objc private func addButton(){
        let habitViewController = HabitViewController(.create)
        let navigationHabitViewController = UINavigationController(rootViewController: habitViewController)
        navigationHabitViewController.modalPresentationStyle = .fullScreen
        habitViewController.delegate = self
        present(navigationHabitViewController, animated: true)
    }
}
//MARK: - extension UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 60)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let habit = store.habits[indexPath.row]
            let habitDetailsViewController = HabitDetailsViewController(with: habit)
            habitDetailsViewController.delegate = self
            self.navigationController?.pushViewController(habitDetailsViewController, animated: true)
        }
    }
    
}
//MARK: - extension UICollectionViewDataSource
extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         section == 0 ?  1 : store.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.progressCollectionViewCell, for: indexPath) as! ProgressCollectionViewCell
            cell.store = store
        return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.habitCollectionViewCell, for: indexPath) as! HabitCollectionViewCell
            cell.habit = store.habits[indexPath.item]
            cell.delegate = self
            return cell
        }
    }
}

extension HabitsViewController: HabitCollectionViewCellDelegate {
    func checkBoxButtonTaped() {
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
}

extension HabitsViewController:  HabitViewControllerDelegate {
    func reload() {
        collectionView.reloadData()
    }
}
