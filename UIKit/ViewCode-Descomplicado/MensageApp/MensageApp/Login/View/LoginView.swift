//
//  LoginView.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 04/12/23.
//

import UIKit

protocol LoginViewProtocol: UIViewController {
    func loginTapped()
    func registerTapped()
}

class LoginView: UIView {
    weak var delegate: LoginViewProtocol?
    
    public func delegate(delegate: LoginViewProtocol) {
        self.delegate = delegate;
    }
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        label.text = "Login"
        return label
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "logo")
        img.tintColor = .green
        img.contentMode = .scaleAspectFit
        return img
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
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.lightGray, for: .normal)
        button.clipsToBounds = true // permite arrendondar
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1)
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Não tem conta? Cadastre-se", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set visual elements
    private func setVisualElements() {
        configBackground()
        
        self.addSubview(loginLabel)
        self.addSubview(logoAppImageView)
        self.addSubview(emailTextfield)
        self.addSubview(passwordTextfield)
        self.addSubview(loginButton)
        self.addSubview(registerButton)

        configConstraints()
    }
    
    private func configBackground() {
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            logoAppImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            logoAppImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60),
            logoAppImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),
            logoAppImageView.heightAnchor.constraint(equalToConstant: 200),
            
            emailTextfield.topAnchor.constraint(equalTo: logoAppImageView.bottomAnchor, constant: 30),
            emailTextfield.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextfield.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emailTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 15),
            passwordTextfield.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            passwordTextfield.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            passwordTextfield.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: self.passwordTextfield.bottomAnchor, constant: 15),
            loginButton.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            registerButton.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            registerButton.heightAnchor.constraint(equalTo: emailTextfield.heightAnchor)
        ])
    }
    
    //MARK: - Getters
    public func getEmail() -> String {
        return emailTextfield.text ?? ""
    }
    
    public func getPassword() -> String {
        return passwordTextfield.text ?? ""
    }
    
    // MARK: - Actions
    @objc private func tappedLoginButton () {
        self.delegate?.loginTapped()
    }
    @objc private func tappedRegisterButton () {
        self.delegate?.registerTapped()
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.emailTextfield.delegate = delegate
        self.passwordTextfield.delegate = delegate
    }
    
    public func textFieldValidation() {
        let email = self.emailTextfield.text ?? ""
        let password = self.passwordTextfield.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            self.loginButton.setTitleColor(.lightGray, for: .normal)
            self.loginButton.isEnabled = false
        } else {
            self.loginButton.setTitleColor(.white, for: .normal)
            self.loginButton.isEnabled = true
        }
    }
    
}
