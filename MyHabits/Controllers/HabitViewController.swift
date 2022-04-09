//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 27.03.2022.
//

import UIKit

final class HabitViewController: UIViewController {
    
    //MARK: - var
    var habit: Habit?{
        didSet{
            titleTextField.text = habit?.name
            colorPickerView.backgroundColor = habit?.color
            timePickerLabel.text = habit?.dateString
            guard let date = habit?.date else { return }
            timePicker.date = date
        }
    }
    
    var closureForTitle: ((String) -> ())?
    weak var delegate: HabitViewControllerDelegate?
    
    private var actionType: ActionType
    private var notificationCenter = NotificationCenter.default
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
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
        timePicker.date = .now
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
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.short
        return dateFormatter
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
        addTargets()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(titleLabel, titleTextField, colorLabel, colorPickerView,
                                timeLabel, timePickerLabel, timePicker)
        addSubviewsWith(actionType)
        
        scrollView.pin(to: view)
        configureConstraints()
        configureConstraints(actionType)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    //MARK: - func
    private func setTextLabels(){
        titleLabel.text = "НАЗВАНИЕ"
        colorLabel.text = "ЦВЕТ"
        timeLabel.text = "ВРЕМЯ"
        let time = timePicker.date
        timePickerLabel.text = "Каждый день в \(dateFormatter.string(from: time))"
    }
    
    private func addTargets() {
        colorPickerView.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
        timePicker.addTarget(self, action: #selector(changeTimeOnPicker), for: .valueChanged)
    }
    
    private func configureNavigationBar(for actionType: ActionType) {
        let leftButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        let rightButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        self.navigationItem.title = actionType == .create ? "Создать" : "Править"
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
    
    private func configureConstraints(_ actionType: ActionType){
        if actionType == .create {
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
    
    private func deleteAction(with habit: Habit?){
        let store = HabitsStore.shared
        guard let habitForRemove = habit else { return }
        guard let index = store.habits.firstIndex(of: habitForRemove) else { return }
        let message = "Вы хотите удалить привычку \"\(habitForRemove.name)\"?"
        let deleteAction = UIAlertAction(title: NSLocalizedString("Удалить",
                                         comment: "Default action"),
                                         style: .destructive) { [weak self] _ in
            store.habits.remove(at: index)
            self?.delegate?.reload()
            
        }
        let deleteAlert = UIAlertController(title: "Удалить привычку", message: message, preferredStyle: .alert)
        
        deleteAlert.addAction(UIAlertAction(title: NSLocalizedString("Отмена", comment: "Default action"), style: .cancel))
        deleteAlert.addAction(deleteAction)
        present(deleteAlert, animated: true, completion: nil)
    }
    
    //MARK: - @objc func
    @objc private func openColorPicker(){
        let colorPicker =  UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = colorPickerView.backgroundColor ?? .orange
        colorPicker.title = "Выбор цвета"
        colorPicker.supportsAlpha = false
        present(colorPicker, animated: true)
    }
    
    @objc private func changeTimeOnPicker(){
        let time = timePicker.date
        timePickerLabel.text = "Каждый день в \(dateFormatter.string(from: time))"
    }
    
    @objc private func deleteHabit(){
        deleteAction(with: habit)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    @objc private func saveHabit() {
        guard let text = titleTextField.text else { return }
        guard let color = colorPickerView.backgroundColor else { return }
        let store = HabitsStore.shared
        
        if actionType == .create {
            let newHabit = Habit(name: text,
                                 date: timePicker.date,
                                 color: color)
            store.habits.append(newHabit)
        } else {
            guard let habit = habit else { return }
            if store.habits.contains(habit) {
                guard let index = store.habits.firstIndex(of: habit) else { return }
                let editHabit = Habit(name: text,
                                     date: timePicker.date,trackDates: habit.trackDates,
                                     color: color)
                store.habits[index] = editHabit
                closureForTitle?(editHabit.name)
            }
        }
        delegate?.reload()
        dismiss(animated: true)
    }
}

//MARK: - extension
extension HabitViewController:  UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController){
        colorPickerView.backgroundColor = viewController.selectedColor
    }
}

extension HabitViewController {
    
    @objc private func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}
