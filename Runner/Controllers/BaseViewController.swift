//
//  BaseViewController.swift
//  Runner
//
//  Created by Anton Tuzov on 19.08.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var backgroundLayer: GradientView = {
        let v = GradientView(colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(backgroundLayer)
    }
    
    private func setupConstraints() {
         // background layer
        NSLayoutConstraint.activate([
            backgroundLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundLayer.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
