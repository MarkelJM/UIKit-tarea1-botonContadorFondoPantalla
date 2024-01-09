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
    @Published var currentNumber: Double = 0.0
    var appView: HomeView! { return self.view as? HomeView }
    private var cancellables: Set<AnyCancellable> = []

    private let backgroundColors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple, .cyan, .magenta, .brown]
    
    override func loadView() {
        self.view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        appView.incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside) //#selector es una manera de referenciar un método que se llamará en respuesta a un evento

        $currentNumber
            .sink { [weak self] number in
                self?.appView.numberLabel.text = "\(number)"
                self?.appView.backgroundColor = self?.backgroundColors.randomElement() ?? .white
            }
            .store(in: &cancellables)
    }
    /*
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
     */
    @objc private func incrementButtonTapped() {
        let alertController = UIAlertController(title: "Increment", message: "Enter a number", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.keyboardType = .decimalPad  // Cambiado a decimalPad para permitir decimales
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let text = alertController.textFields?.first?.text, let value = Double(text) {
                // Convertir y sumar como Double, luego convertir a Int para currentNumber
                self?.appModel.number += Double(value)
                self?.currentNumber = self?.appModel.number ?? 0


            } else {
                print("Error with chosen number, try agai")
                let errorAlert = UIAlertController(title: "Error", message: "Invalid number entered. Please enter a valid number.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(errorAlert, animated: true)
            }
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }

}


