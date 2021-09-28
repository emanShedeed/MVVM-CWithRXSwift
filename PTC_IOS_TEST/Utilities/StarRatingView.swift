//
//  starRatingView.swift
//  e-Mawaeed
//
//  Created by BSS on 6/24/21.
//


import UIKit

protocol StarRatingViewProtocol: AnyObject {
    func didRate(with rating: Int)
}

@IBDesignable
class StarRatingView: UIView {
    
    // MARK: Public Properties
    @IBInspectable public var filledStar: UIImage = UIImage(named: "rate.fill")!
    @IBInspectable public var emptyStar: UIImage = UIImage(named: "rate.empty")!
    @IBInspectable public var spacing: CGFloat = 4.0
    @IBInspectable public var leadingspace: CGFloat = 0.0
    @IBInspectable public var isEditable: Bool = true
    @IBInspectable public var maxRating: Int = 5 {
        didSet {
            configure(with: maxRating)
        }
    }
    @IBInspectable public var rating: Int = 0 {
        didSet {
            updateState()
        }
    }
    public weak var StarRatingViewDelegate: StarRatingViewProtocol?
    
    // MARK: private Properties
    private var ratingButtons: [UIButton] = []
    private var isConfigured: Bool = false
    private var buttonTag: Int = 1
    
    private func configure(with maxRating: Int = 5) {
        guard let ratingStackView = createRatingStackView(with: maxRating) else { return}
        addSubview(ratingStackView)
        NSLayoutConstraint.activate([
            ratingStackView.topAnchor.constraint(equalTo: topAnchor),
            ratingStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingspace),
            ratingStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ratingStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leadingspace)
        ])
        setUpButtons()
    }
    
    private func createRatingStackView(with count: Int) -> UIStackView? {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        for _ in 1...count {
            let button = creatButton()
            stackView.addArrangedSubview(button)
            ratingButtons.append(button)
        }
        return stackView
    }
    
    private func creatButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.text = ""
        guard isEditable == true else { return button }
        button.tag = buttonTag
        buttonTag += 1
        return button
    }
    
    private func setUpButtons() {
        for button in self.ratingButtons {
            button.setImage(filledStar, for: .selected)
            button.setImage(emptyStar, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        }
        updateState()
    }
    
    private func updateState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    @objc func buttonTapped(button: UIButton) {
        let selectRating = button.tag
        guard selectRating != rating else { return }
        rating = selectRating
        updateState()
        // tell user with new rate throug delegate
        StarRatingViewDelegate?.didRate(with: rating)
    }
    
}
