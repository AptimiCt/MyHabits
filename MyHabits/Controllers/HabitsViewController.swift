//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 25.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - var
    let store = HabitsStore.shared
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collectionView.backgroundColor = UIColor(named: "LightGrayColor")
        collectionView.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    //MARK: - init
    init(){
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        self.title = "Сегодня"
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton)), animated: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
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
        present(navigationHabitViewController, animated: true)
    }
}
//MARK: - extension
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
        cell.configure(with: store.habits[indexPath.item])
        return cell
    }
}

