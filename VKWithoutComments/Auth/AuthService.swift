//
//  AuthService.swift
//  VKWithoutComments
//
//  Created by Ruslan Gallyamov on 23.08.2021.
//

import Foundation
import VK_ios_sdk


protocol AuthServiceProtocol: AnyObject {
    var delegate: AuthServiceDelegate? { get set }
    var accessToken: String? { get }
    var userId: String? { get }
    func auth()
}

protocol AuthServiceDelegate: AnyObject {
    func presentAuthView(_ controller: UIViewController)
    func signInSuccess()
    func signInFailed()
}

class AuthService: NSObject, AuthServiceProtocol {
    
    static let shared: AuthServiceProtocol = AuthService()
    
    weak var delegate: AuthServiceDelegate?
    var accessToken: String? {
        return VKSdk.accessToken().accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken().userId
    }
    
    private let appId = "7933654"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func auth() {
        let permissions = ["wall", "friends"]
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
extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if let _ = result.token {
            delegate?.signInSuccess()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
}

// MARK: VKSdkUIDelegate
extension AuthService: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.presentAuthView(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
