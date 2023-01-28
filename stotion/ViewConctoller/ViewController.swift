//
//  ViewController.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import GoogleSignIn
import AVFoundation
import FirebaseDatabase
import SwiftUI


class ViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    let label = UILabel()
    let passwordTextField = UITextField()
    let showPasswordButton = UIButton(type: .system)
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var SI: UIButton!
    fileprivate var currentNonce: String?
    private var signInWithAppleButton: ASAuthorizationAppleIDButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playintro()
    }
    func setup(){
        let videoURL2 = Bundle.main.url(forResource: "intro-2", withExtension: "mp4")
        let videoPlayer2 = AVPlayer(url: videoURL2!)
        let videoLayer2 = AVPlayerLayer(player: videoPlayer2)
        videoLayer2.frame = self.view.bounds
        videoLayer2.zPosition = -1.0
        self.image.alpha = 0
        videoLayer2.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(videoLayer2)
        videoPlayer2.play()
        Timer.scheduledTimer(withTimeInterval: 4.22, repeats: false) { (timer) in
            self.setupbackground()
        }
        signInWithAppleButton = ASAuthorizationAppleIDButton(type: .default, style: .white)
        super.viewDidLayoutSubviews()
        let buttonWidth = view.frame.size.width - 80
        let buttonHeight: CGFloat = 40
        let buttonX = (view.frame.size.width - buttonWidth) / 2
        let buttonY = view.frame.size.height - buttonHeight - 180
        signInWithAppleButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        signInWithAppleButton.addTarget(self, action: #selector(handleSignInWithApple), for: .touchUpInside)
        view.addSubview(signInWithAppleButton)
        self.username.attributedPlaceholder = NSAttributedString(
            string: "username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        self.password.attributedPlaceholder = NSAttributedString(
            string: "password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        styleButton(button: self.SI)
        styleTextbox(textfield: self.username, factor: 0)
        styleTextbox(textfield: self.password, factor: 1)
        setUpPasswordTextField()
        setUpShowPasswordButton()
        //animateStotion()
    }
    func setupbackground(){
        let videoURL3 = Bundle.main.url(forResource: "intro-3", withExtension: "mp4")
        let videoPlayer3 = AVPlayer(url: videoURL3!)
        let videoLayer3 = AVPlayerLayer(player: videoPlayer3)
        videoLayer3.frame = self.view.bounds
        videoLayer3.zPosition = -1.0
        self.image.alpha = 0
        videoLayer3.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(videoLayer3)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoPlayer3.currentItem, queue: .main) { [weak self] _ in
            videoPlayer3.seek(to: CMTime.zero)
            videoPlayer3.play()
        }
        videoPlayer3.play()
    }
    func styleTextbox(textfield: UITextField, factor: Int) {
        textfield.layer.cornerRadius = 20
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.white.cgColor
        textfield.backgroundColor = UIColor.black
        textfield.textColor = UIColor.white
        textfield.textAlignment = .center
    }

    func styleButton(button: UIButton) {
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.textColor = UIColor.white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = button.frame.height/2
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    private func setUpPasswordTextField() {
        self.password.isSecureTextEntry = true
        //self.password.borderStyle = .roundedRect
        //self.password.autocorrectionType = .no
        //self.password.autocapitalizationType = .none
        self.password.clearButtonMode = .whileEditing
        self.password.rightView = showPasswordButton
        self.password.rightViewMode = .always
      }
      
      private func setUpShowPasswordButton() {
          showPasswordButton.setImage(UIImage(systemName: "eye.slash")?.withTintColor(.white), for: .normal)
          showPasswordButton.addTarget(self, action: #selector(handleShowPassword), for: .touchUpInside)
      }
      
      @objc func handleShowPassword() {
          self.password.isSecureTextEntry.toggle()
        if self.password.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(systemName: "eye")?.withTintColor(.white), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: "eye.slash")?.withTintColor(.white), for: .normal)
        }
      }
    func createAlert(with text: String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        alert.view.tintColor = .black
        let subview = alert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        alertContentView.layer.cornerRadius = 15
        self.present(alert, animated: true, completion: nil)
    }
    func animateStotion() {
        let labelX = (view.frame.size.width - 200) / 2
        let labelY = view.frame.size.height - 50
        label.frame = CGRect(x: labelX, y: labelY, width: 200, height: 50)
        label.center = self.view.center
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.white
        self.view.addSubview(label)
        let str = "stotion"
        var index = 0
        label.text = ""
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (timer) in
        if index == str.count {
            timer.invalidate()
            return
        }
        let char = str[str.index(str.startIndex, offsetBy: index)]
        self.label.text?.append(char)
        index += 1
        UIView.animate(withDuration: 0.3, animations: {
            self.label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.label.transform = CGAffineTransform.identity
            })
        })
        }
    }
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: self.view.center.x, y: self.view.frame.height - activityIndicator.frame.height - 20)
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }

    func hideLoadingIndicator() {
        for subview in self.view.subviews {
            if let activityIndicator = subview as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                break
            }
        }
    }

    func setupFirebase() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    func playintro(){
        let videoURL = Bundle.main.url(forResource: "intro", withExtension: "mp4")
        let videoPlayer = AVPlayer(url: videoURL!)
        let videoLayer = AVPlayerLayer(player: videoPlayer)
        videoLayer.frame = self.view.bounds
        videoLayer.zPosition = 0.0
        videoLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(videoLayer)
        videoPlayer.play()
        self.setupFirebase()
        Timer.scheduledTimer(withTimeInterval: 2.76, repeats: false) { (timer) in
            self.showLoadingIndicator()
            Timer.scheduledTimer(withTimeInterval: 2.6, repeats: false) { (timer) in
                for layer in self.view.layer.sublayers! {
                    if let playerLayer = layer as? AVPlayerLayer {
                        playerLayer.removeFromSuperlayer()
                    }
                }
                self.hideLoadingIndicator()
                self.setup()
            }
        }
    }
    func moveToAcountScreen(){
        let newPage = HomePage()
        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: newPage)
    }
    //----------------------------------SignIn with AppleID--------------------------------------------------------
    @objc func handleSignInWithApple() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
      if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
          let email = appleIDCredential.email
          print("Email: \(email)")
          guard let nonce = currentNonce else {
          fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
          print("Unable to fetch identity token")
          return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
          print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
          return
        }
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if (error != nil) {
            // Error. If error.code == .MissingOrInvalidNonce, make sure
                print(error?.localizedDescription)
            return
          }
            self.moveToAcountScreen()
            print("in--------------------")
          // User is signed in to Firebase with Apple.
        }
      }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      print("Sign in with Apple errored: \(error)")
    }
    //-------------------------------------------------------------------------------------------------------------
    //----------------------------------SignIn or SignUp-----------------------------------------------------------
    
    @IBAction func signin(_ sender: Any) {
        if self.username.text! == "" && self.password.text! == ""{
            self.createAlert(with: "Please fill the username and password fields")
        }
        else{
            let email = self.username.text! + "@gmail.com"
            let password = self.password.text!
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    guard let strongSelf = self else { return }
                    if error != nil{}
                    else{
                        self?.moveToAcountScreen()
                    }
                }
            }
            
        }
    }
}
