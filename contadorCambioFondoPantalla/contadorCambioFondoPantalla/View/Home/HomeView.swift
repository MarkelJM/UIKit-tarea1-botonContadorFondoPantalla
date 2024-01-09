//
//  HomeView.swift
//  contadorCambioFondoPantalla
//
//  Created by Markel Juaristi Mendarozketa   on 9/1/24.
//

import UIKit

class HomeView: UIView {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Increment", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(numberLabel)
        addSubview(incrementButton)
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            incrementButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 16),
            incrementButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            incrementButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            incrementButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(with number: Int, action: Selector, target: Any) {
        numberLabel.text = "\(number)"
        incrementButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
