//
//  AlertViewController.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 12/13/23.
//

import UIKit

class AlertViewController: UIViewController {
    
    var alertTitle: String? = ""
    var message: String? = ""
    var buttonTitle: String? = ""
    let alertViewContainer = UIView()
    
    let alertTitleLabel: UILabel = {
        let alertTitleLabel = UILabel()
        alertTitleLabel.backgroundColor = .systemBackground
        alertTitleLabel.textColor = .label
        alertTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        alertTitleLabel.textAlignment = .center
        return alertTitleLabel
    }()
    
    let messageTextLabel: UILabel = {
        let messageTextLabel = UILabel()
        messageTextLabel.backgroundColor = .systemBackground
        messageTextLabel.textColor = .label
        messageTextLabel.textAlignment = .center
        messageTextLabel.font = UIFont.preferredFont(forTextStyle: .body)
        messageTextLabel.adjustsFontSizeToFitWidth = true
        messageTextLabel.minimumScaleFactor = 0.75
        messageTextLabel.lineBreakMode = .byWordWrapping
        return messageTextLabel
    }()

    let okButton: UIButton = {
        let okButton = UIButton()
        okButton.backgroundColor = .systemRed
        return okButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        
        alertViewContainer.backgroundColor = .systemBackground
        setupAlertViewContainer()
        
        alertTitleLabel.text = alertTitle
        messageTextLabel.text = message
        okButton.setTitle(buttonTitle  , for: .normal)
  
        okButton.layer.cornerRadius = 8.0
        okButton.layer.borderWidth = 2.0
        okButton.layer.borderColor = UIColor.black.cgColor
        okButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        messageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        alertTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(alertTitleLabel)
        view.addSubview(messageTextLabel)
        view.addSubview(okButton)

        addConstraints()
    }
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAlertViewContainer() {
        alertViewContainer.translatesAutoresizingMaskIntoConstraints = false
        alertViewContainer.layer.cornerRadius = 16.0
        alertViewContainer.layer.borderWidth = 4.0
        alertViewContainer.layer.borderColor = UIColor.black.cgColor
        view.addSubview(alertViewContainer)

        NSLayoutConstraint.activate([
            alertViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertViewContainer.heightAnchor.constraint(equalToConstant: 200),
            alertViewContainer.widthAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: alertViewContainer.safeAreaLayoutGuide.topAnchor, constant: 10),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            alertTitleLabel.leftAnchor.constraint(equalTo: alertViewContainer.leftAnchor, constant: 50),
            alertTitleLabel.rightAnchor.constraint(equalTo: alertViewContainer.rightAnchor, constant: -50),
 
            messageTextLabel.topAnchor.constraint(equalTo: alertTitleLabel.safeAreaLayoutGuide.bottomAnchor),
            messageTextLabel.heightAnchor.constraint(equalToConstant:50),
            messageTextLabel.leftAnchor.constraint(equalTo: alertViewContainer.leftAnchor, constant: 8),
            messageTextLabel.rightAnchor.constraint(equalTo: alertViewContainer.rightAnchor, constant: -8),

            okButton.topAnchor.constraint(equalTo: messageTextLabel.bottomAnchor, constant: 40),
            okButton.leftAnchor.constraint(equalTo: alertViewContainer.leftAnchor, constant: 20),
            okButton.rightAnchor.constraint(equalTo: alertViewContainer.rightAnchor, constant: -20),
            
        ])
    }
}
