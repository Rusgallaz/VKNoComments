//
//  ViewController.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 23.08.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AuthService.shared.delegate = self
    }
    
    @IBAction func authPressed(_ sender: UIButton) {
        AuthService.shared.auth()
    }
}


// MARK: AuthServiceDelegate

extension AuthViewController: AuthServiceDelegate {
    func presentAuthView(_ controller: UIViewController) {
        present(controller, animated: true)
    }

    func signInSuccess() {
        let feedViewController = UIStoryboard(name: "Feed", bundle: nil).instantiateInitialViewController() as! FeedViewController
        let navigationController = UINavigationController(rootViewController: feedViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    func signInFailed() {

    }
}

