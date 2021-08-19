//
//  HistoryTableViewCell.swift
//  Runner
//
//  Created by Anton Tuzov on 19.08.2021.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
    
    
    // MARK:- external props
    var totalMiles: Double = 0.0 {
        didSet {
            totalMilesLabel.text = String(format: "%0.2f", totalMiles)
            layoutIfNeeded()
        }
    }
    
    var totalTime: String = "00:02:12" {
        didSet {
            totalTimeLabel.text = totalTime
            layoutIfNeeded()
        }
    }
    
    var entryDate: String = "04/01/2021" {
        didSet {
            entryDateLabel.text = entryDate
            layoutIfNeeded()
        }
    }
    
    // MARK:- UI elements
    private lazy var totalMilesLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "0.0"
        v.textColor = .white
        v.font = UIFont.boldSystemFont(ofSize: 24)
        return v
    }()
    
    private lazy var totalTimeLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "0.0"
        v.textColor = .white
        v.font = v.font.withSize(18)
        return v
    }()
    
    private lazy var entryDateLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "0.0"
        v.textColor = .white
        v.font = v.font.withSize(18)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = UIColor.black.withAlphaComponent(0.1)
        contentView.addSubview(totalMilesLabel)
        contentView.addSubview(totalTimeLabel)
        contentView.addSubview(entryDateLabel)
    }
    
    private func setupConstraints() {
        // total miles label
        NSLayoutConstraint.activate([
            totalMilesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            totalMilesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        // total time label
        NSLayoutConstraint.activate([
            totalTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            totalTimeLabel.topAnchor.constraint(equalTo: totalMilesLabel.bottomAnchor, constant: 8),
            totalTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        // entry date label
        NSLayoutConstraint.activate([
            entryDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            entryDateLabel.centerYAnchor.constraint(equalTo: totalMilesLabel.centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func configure(run: Run) {
        totalMiles = run.distance.meterToMiles()
        totalTime = run.duration.formatTimeString()
        entryDate = run.date.getDateString()
    }
}
