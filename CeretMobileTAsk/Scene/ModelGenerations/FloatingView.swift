//
//  FloatingView.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 04/03/2025.
//

import UIKit
class FloatingCompareView: UIView {
    private let countLabel = UILabel()
    private let compareButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        // Configure count label
        countLabel.textColor = .white
        countLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        addSubview(countLabel)

        // Configure compare button
        compareButton.setTitle("Compare Now", for: .normal)
        compareButton.setTitleColor(.white, for: .normal)
        compareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        compareButton.addTarget(self, action: #selector(compareButtonTapped), for: .touchUpInside)
        addSubview(compareButton)

        // Set up constraints
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        compareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            compareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            compareButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func updateCompareCount(_ count: Int) {
        countLabel.text = "\(count) Items"
    }

    @objc private func compareButtonTapped() {
        // Handle compare action
        print("Compare button tapped!")
    }
}
