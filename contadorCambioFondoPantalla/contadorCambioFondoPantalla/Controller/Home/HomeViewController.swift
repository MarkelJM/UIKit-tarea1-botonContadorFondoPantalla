//
//  HomeViewController.swift
//  contadorCambioFondoPantalla
//
//  Created by Markel Juaristi Mendarozketa   on 9/1/24.
//


import UIKit
import Combine

class HomeViewController: UIViewController {
    var appModel = AppModel()
    @Published var currentNumber: Int = 0
    var appView: HomeView! { return self.view as? HomeView }
    private var cancellables: Set<AnyCancellable> = []

    private let backgroundColors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple]

    override func loadView() {
        self.view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        appView.incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)

        $currentNumber
            .sink { [weak self] number in
                self?.appView.numberLabel.text = "\(number)"
                self?.appView.backgroundColor = self?.backgroundColors.randomElement() ?? .white
            }
            .store(in: &cancellables)
    }

    @objc private func incrementButtonTapped() {
        let alertController = UIAlertController(title: "Increment", message: "Enter a number", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let value = Int(alertController.textFields?.first?.text ?? "0") {
                self?.appModel.number += value
                self?.currentNumber = self?.appModel.number ?? 0
            }
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}


