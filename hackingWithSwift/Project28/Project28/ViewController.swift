//
//  ViewController.swift
//  Project28
//
//  Created by COBE on 22/06/2021.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {

    @IBOutlet var secret: UITextView!
    var biometricsUnavailable = false
    
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @objc func adjustForKeyboard(notification: Notification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        }
        else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }

    @IBAction func authenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ [weak self] success, authentificationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    }
                    else {
                        let ac = UIAlertController(title: "Authentification failed", message: "You could not be verified, try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
                
            }
        }
        else {
            biometricsUnavailable = true
            let ac = UIAlertController(title: "Choose your password", message: nil, preferredStyle: .alert)
            ac.addTextField()
            let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
                let answer = ac.textFields![0]
                self.password = answer.text ?? ""
            }
            print("Password: \(password)")
            ac.addAction(submitAction)
            present(ac, animated: true)
            unlockSecretMessage()
        }
    }
    
    func unlockSecretMessage() {
        secret.isHidden =  false
        title = "Secret stuff!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveSecretMessage))
        if !biometricsUnavailable {
            secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
        }
        else {
            password = KeychainWrapper.standard.string(forKey: "Password") ?? ""
        }
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        if !biometricsUnavailable {
            KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
            secret.resignFirstResponder()
            secret.isHidden = true
            title = "Nothing to see here"
        }
        else {
            KeychainWrapper.standard.set(password, forKey: "Password")
            secret.resignFirstResponder()
            secret.isHidden = true
            title = "Nothing to see here"
        }
        navigationItem.rightBarButtonItem = nil
    }
}

