//
//  HistoryViewController.swift
//  Runner
//
//  Created by Anton Tuzov on 18.08.2021.
//

import UIKit

class HistoryViewController: BaseViewController {
    
    private static let reuseId = "REUSEID"
    
    // MARK:- UI Elements
    private lazy var topLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Run Logs"
        v.textAlignment = .center
        v.textColor = .darkGray
        v.font = v.font.withSize(32)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        v.dataSource = self
        v.register(HistoryTableViewCell.self, forCellReuseIdentifier: Self.reuseId)
        v.backgroundColor = .clear
        v.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        v.separatorColor = .white
        return v
    }()

    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(topLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        // top label
        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // table view
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK:- Extension
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseId) as? HistoryTableViewCell,
              let run = Run.getAllRuns()?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(run: run)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let run = Run.getAllRuns()?[indexPath.row] else {
            return
        }
        
        let vc = PreviousRunDetailViewController(run: run)
        present(vc, animated: true)
    }
}
