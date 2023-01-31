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
    var sampleTasks: [Task] = [
        .init(dateAdded: Date(timeIntervalSince1970: 1672829809), taskName: "Edit YT Video", taskDescription: "", taskCategory: .general),
        .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "Matched Geometry Effect(Issue)", taskDescription: "", taskCategory: .bug),
        .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "Multi-ScrollView", taskDescription: "", taskCategory: .challenge),
        .init(dateAdded: Date(timeIntervalSince1970: 1672837009), taskName: "Loreal Ipsum", taskDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.", taskCategory: .idea),
        .init(dateAdded: Date(timeIntervalSince1970: 1672714609), taskName: "Complete UI Animation Challenge", taskDescription: "", taskCategory: .challenge),
        .init(dateAdded: Date(timeIntervalSince1970: 1672851409), taskName: "Fix Shadow issue on Mockup's", taskDescription: "", taskCategory: .bug),
        .init(dateAdded: Date(timeIntervalSince1970: 1672901809), taskName: "Add Shadow Effect in Mockview App", taskDescription: "", taskCategory: .idea),
        .init(dateAdded: Date(timeIntervalSince1970: 1672901809), taskName: "Twitter/Instagram Post", taskDescription: "", taskCategory: .general),
        .init(dateAdded: Date(timeIntervalSince1970: 1672923409), taskName: "Lorem Ipsum", taskDescription: "", taskCategory: .modifiers),
    ]
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
        DataStructure.tasks.append(self.sampleTasks[0])
        super.viewDidLoad()
        self.playintro()
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
        Timer.scheduledTimer(withTimeInterval: 2.76, repeats: false) { (timer) in
            self.showLoadingIndicator()
            Timer.scheduledTimer(withTimeInterval: 2.6, repeats: false) { (timer) in
                for layer in self.view.layer.sublayers! {
                    if let playerLayer = layer as? AVPlayerLayer {
                        playerLayer.removeFromSuperlayer()
                    }
                }
                self.hideLoadingIndicator()
                self.moveToLogInScreen()
            }
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

    func moveToAcountScreen(){
        let newPage = ContentView()
        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: newPage)
    }
    func moveToLogInScreen(){
        let newPage = loginPage()
        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: newPage)
    }
}
