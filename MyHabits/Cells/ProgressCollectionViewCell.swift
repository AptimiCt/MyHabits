//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Востриков on 30.03.2022.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    var store: HabitsStore?{
        didSet{
            guard let store = store else { return }
            progressBar.progress = store.todayProgress
            percentLabel.text = "\(Int(store.todayProgress * 100))%"
        }
    }
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.toAutoLayout()
        statusLabel.numberOfLines = 1
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        statusLabel.text = "Всё получится!"
        return statusLabel
    }()
    private var percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.toAutoLayout()
        percentLabel.numberOfLines = 1
        percentLabel.font = .preferredFont(forTextStyle: .footnote)
        percentLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        percentLabel.text = "0%"
        return percentLabel
    }()
    private var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .default)
        let progress = Progress(totalUnitCount: 100)
        progressBar.toAutoLayout()
        progressBar.setProgress(0.0, animated: false)
        progressBar.trackTintColor = UIColor(named: "ProgressBackgroundColor")
        return progressBar
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private func
    private func setup(){
        contentView.addSubviews(statusLabel, percentLabel, progressBar)
        configureConstraints()
    }
    private func configureConstraints(){
        [
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -10),
            
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            percentLabel.bottomAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ].forEach { $0.isActive = true }
    }
}
