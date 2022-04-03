//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 26.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - var
    private let contentView = UIView()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.toAutoLayout()
        textLabel.numberOfLines = 0
        textLabel.font = .preferredFont(forTextStyle: .body)
        textLabel.font = .systemFont(ofSize: 17, weight: .regular)
        return textLabel
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.toAutoLayout()
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        return titleLabel
    }()
    private lazy var footNoteLabel: UILabel = {
        let footNoteLabel = UILabel()
        footNoteLabel.toAutoLayout()
        footNoteLabel.font = .preferredFont(forTextStyle: .body)
        footNoteLabel.font = .systemFont(ofSize: 17, weight: .regular)
        return footNoteLabel
    }()
    
    //MARK: - init
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Информация"
        setTextLabel()
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.toAutoLayout()
        contentView.addSubviews(titleLabel, footNoteLabel, textLabel)
        scrollView.pin(to: view)
        configureConstraints()
    }
    
    //MARK: - func
    private func setTextLabel() {
        titleLabel.text = "Привычка за 21 день"
        textLabel.text =
        """
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        
        1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
        
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.
        
        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
        
        4. Поздравить себя с прохождением первого серьезного порога в 21 день.
        За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
        
        5. Держать планку 40 дней.
        Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        
        6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
        """
        footNoteLabel.text = "Источник: psychbook.ru"
    }
    private func configureConstraints(){
        [
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -16),
            
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: footNoteLabel.topAnchor, constant: -16),
            
            footNoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            footNoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            footNoteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ].forEach { $0.isActive = true }
    }
}
