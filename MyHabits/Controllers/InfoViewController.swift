//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Александр Востриков on 26.03.2022.
//

import UIKit

final class InfoViewController: UIViewController {
    
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
        self.title = Constants.titleForInfoVC
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
        titleLabel.text = Constants.titleLabelForInfoVC
        textLabel.text = Constants.textLabelForInfoVC
        footNoteLabel.text = Constants.footNoteLabelText
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
