//
//  GradientView.swift
//  CeretMobileTAsk
//
//  Created by eslam dweeb on 02/03/2025.
//

import UIKit

class GradientView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    private func setupGradient() {
        self.setGradientBackground(firstColor:  UIColor.gradiantOrange.withAlphaComponent(0.6), secondColor: UIColor.gradiantOrange.withAlphaComponent(0), thirdColor: nil, startPoint:   CGPoint(x: 0.5, y: 0.0), endPoint:  CGPoint(x: 0.5, y: 1.0), location: [0.0, 0.6])
    }


}
