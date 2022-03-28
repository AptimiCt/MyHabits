//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 27.03.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    //MARK: - var
    private var actionType: ActionType
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.toAutoLayout()
        titleLabel.font = .preferredFont(forTextStyle: .footnote)
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        return titleLabel
    }()
    private let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.toAutoLayout()
        titleTextField.font = .preferredFont(forTextStyle: .body)
        titleTextField.font = .systemFont(ofSize: 17, weight: .regular)
        titleTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        return titleTextField
    }()
    private lazy var colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.toAutoLayout()
        colorLabel.font = .preferredFont(forTextStyle: .footnote)
        colorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        return colorLabel
    }()
    
    private let colorPickerView: UIButton = {
        let colorPickerView = UIButton()
        colorPickerView.toAutoLayout()
        colorPickerView.backgroundColor = .orange
        
        return colorPickerView
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.toAutoLayout()
        timeLabel.font = .preferredFont(forTextStyle: .footnote)
        timeLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        return timeLabel
    }()
    private lazy var timePickerLabel: UILabel = {
        let timePickerLabel = UILabel()
        timePickerLabel.toAutoLayout()
        timePickerLabel.font = .preferredFont(forTextStyle: .body)
        timePickerLabel.font = .systemFont(ofSize: 17, weight: .regular)
        return timePickerLabel
    }()
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.toAutoLayout()
        timePicker.datePickerMode = .time
        timePicker.contentMode = .scaleToFill
        timePicker.preferredDatePickerStyle = .wheels
        return timePicker
    }()
    private let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.toAutoLayout()
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.setTitleColor(UIColor(red: 0.5, green: 0, blue: 0, alpha: 1), for: .highlighted)
        return deleteButton
    }()
    
    //MARK: - init
    init(_ actionType: ActionType) {
        self.actionType = actionType
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        colorPickerView.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar(for: actionType)
        
        setTextLabels()
        colorPickerView.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(titleLabel, titleTextField, colorLabel, colorPickerView,
                                timeLabel, timePickerLabel, timePicker)
        addSubviewsWith(actionType)
        scrollView.pin(to: view)
        configureConstraints()
        configureConstraints(actionType)
    }
    
    //MARK: - func
    private func setTextLabels(){
        titleLabel.text = "НАЗВАНИЕ"
        colorLabel.text = "ЦВЕТ"
        timeLabel.text = "ВРЕМЯ"
        timePickerLabel.text = "Каждый день в 11:00 PM"
    }
    private func configureNavigationBar(for actionType: ActionType) {
        let leftButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        let rightButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(save))
        self.navigationItem.title = actionType == .create ? "Создать" : "Редактировать"
        self.navigationItem.leftBarButtonItem = leftButtonItem
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    private func configureConstraints(){
        [
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -100),
            titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor, constant: -7),
            
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -65),
            titleTextField.bottomAnchor.constraint(equalTo: colorLabel.topAnchor, constant: -15),
            
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -100),
            colorLabel.bottomAnchor.constraint(equalTo: colorPickerView.topAnchor, constant: -7),
            
            colorPickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorPickerView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -100),
            colorPickerView.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -15),
            colorPickerView.widthAnchor.constraint(equalToConstant: 30),
            colorPickerView.heightAnchor.constraint(equalTo: colorPickerView.widthAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -100),
            timeLabel.bottomAnchor.constraint(equalTo: timePickerLabel.topAnchor, constant: -7),
            
            timePickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timePickerLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -100),
            timePickerLabel.bottomAnchor.constraint(equalTo: timePicker.topAnchor, constant: -15),
            
            timePicker.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            timePicker.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor,constant: -100),
            timePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ].forEach { $0.isActive = true }
    }
    private func configureConstraints(_ param: ActionType){
        if param == .create {
            [
                timePicker.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -18)
            ].forEach { $0.isActive = true }
        } else {
            [
                deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
                deleteButton.topAnchor.constraint(greaterThanOrEqualTo: timePicker.bottomAnchor, constant: 16),
                deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -100),
                deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
            ].forEach { $0.isActive = true }
        }
    }
    private func addSubviewsWith(_ actionType: ActionType){
        if actionType != .create{
            contentView.addSubview(deleteButton)
            deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        }
    }
    
    //MARK: - @objc func
    @objc private func openColorPicker(){
        let colorPicker =  UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = colorPickerView.backgroundColor ?? .orange
        colorPicker.title = "Выбор цвета"
        present(colorPicker, animated: true)
    }
    
    @objc private func deleteHabit(){
        print(#function)
    }
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    @objc private func save() {
        print("save")
    }
}

//MARK: - extension
extension HabitViewController:  UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController){
        colorPickerView.backgroundColor = viewController.selectedColor
    }
}
