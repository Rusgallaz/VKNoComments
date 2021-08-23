//
//  AuthService.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 23.08.2021.
//

import Foundation
import VK_ios_sdk


protocol AuthService {
    var delegate: AuthServiceDelegate? { get set }
    func auth()
}

protocol AuthServiceDelegate: AnyObject {
    func presentAuthView(_ controller: UIViewController)
    func signInSuccess()
    func signInFailed()
}

class AuthServiceImpl: NSObject, AuthService {
        
    weak var delegate: AuthServiceDelegate?
    
    private let appId = "7933654"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func auth() {
        let permissions = ["offline"]
        VKSdk.wakeUpSession(permissions) { [delegate] state, error in
            switch state {
            case .initialized:
                VKSdk.authorize(permissions)
            case .authorized:
                delegate?.signInSuccess()
            default:
                delegate?.signInFailed()
            }
        }
    }
    
}

// MARK: VKSdkDelegate
extension AuthServiceImpl: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let _ = result.token {
            delegate?.signInSuccess()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
}

// MARK: VKSdkUIDelegate
extension AuthServiceImpl: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.presentAuthView(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
