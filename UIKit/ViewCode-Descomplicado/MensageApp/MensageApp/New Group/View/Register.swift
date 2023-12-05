//
//  Register.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func tappedBackButton()
    func tappedRegisterButton()
}

class RegisterView: UIView {
    weak var delegate: RegisterViewProtocol?
    
    public func delegate(delegate: RegisterViewProtocol) {
        self.delegate = delegate
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var addUserImage: UIImageView = {
       let img = UIImageView()
       img.translatesAutoresizingMaskIntoConstraints = false
       img.image = UIImage(named: "usuario")
       img.contentMode = .scaleAspectFit
       return img
    }()
    
    lazy var nameTextField: UITextField = {
       let tf = UITextField()
       tf.translatesAutoresizingMaskIntoConstraints = false
       tf.autocorrectionType = .no
       tf.backgroundColor = .white
       tf.borderStyle = .roundedRect
       tf.keyboardType = .emailAddress
       tf.placeholder = "Digite seu nome"
       tf.autocapitalizationType = .none
       tf.font = .systemFont(ofSize: 14)
       tf.textColor = .darkGray
       return tf
    }()
    
    lazy var emailTextfield: UITextField = {
       let tf = UITextField()
       tf.translatesAutoresizingMaskIntoConstraints = false
       tf.autocorrectionType = .no
       tf.backgroundColor = .white
       tf.borderStyle = .roundedRect
       tf.keyboardType = .emailAddress
       tf.placeholder = "Digite seu email"
       tf.autocapitalizationType = .none
       tf.font = .systemFont(ofSize: 14)
       tf.textColor = .darkGray
       return tf
    }()
    
    lazy var passwordTextfield: UITextField = {
       let tf = UITextField()
       tf.translatesAutoresizingMaskIntoConstraints = false
       tf.autocorrectionType = .no
       tf.backgroundColor = .white
       tf.borderStyle = .roundedRect
       tf.keyboardType = .default
       tf.placeholder = "Digite sua senha"
       tf.isSecureTextEntry = true
       tf.font = .systemFont(ofSize: 14)
       tf.textColor = .darkGray
       return tf
    }()
    
    lazy var registerButton: UIButton = {
       let button = UIButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.setTitle("Cadastrar", for: .normal)
       button.setTitleColor(.lightGray, for: .normal)
       button.clipsToBounds = true // permite arrendondar
       button.layer.cornerRadius = 7.5
       button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1)
       button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
       button.isEnabled = false
       return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.nameTextField.delegate = delegate
        self.emailTextfield.delegate = delegate
        self.passwordTextfield.delegate = delegate
    }
    
    // MARK: - Set visual elements
    private func setVisualElements() {
        configBackground()
        
        self.addSubview(backButton)
        self.addSubview(addUserImage)
        self.addSubview(nameTextField)
        self.addSubview(emailTextfield)
        self.addSubview(passwordTextfield)
        self.addSubview(registerButton)
        
        configConstraints()
    }
    
    private func configBackground() {
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            addUserImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            addUserImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            addUserImage.heightAnchor.constraint(equalToConstant: 150),
            
            nameTextField.topAnchor.constraint(equalTo: addUserImage.bottomAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            emailTextfield.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextfield.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextfield.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emailTextfield.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 15),
            passwordTextfield.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextfield.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 45),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
        ])
    }
    
    // MARK: - Getters
    public func getName() -> String {
        return nameTextField.text ?? ""
    }
    
    public func getEmail() -> String {
        return emailTextfield.text ?? ""
    }
    
    public func getPassword() -> String {
        return passwordTextfield.text ?? ""
    }
    
    // MARK: - Actions
    @objc func tappedBackButton() {
        self.delegate?.tappedBackButton()
    }
    
    @objc func tappedRegisterButton() {
        self.delegate?.tappedRegisterButton()
    }
    
    public func textFieldValidation() {
        let name = self.nameTextField.text ?? ""
        let email = self.emailTextfield.text ?? ""
        let password = self.passwordTextfield.text ?? ""
        
        if name.isEmpty || email.isEmpty || password.isEmpty {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        } else {
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        }
    }
}
