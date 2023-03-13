//
//  UIViewController+loading.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {

    func startLoading(message: String? = nil) {
        NVActivityIndicatorView.DEFAULT_COLOR = .appBondiBlue
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = .black.withAlphaComponent(0.2)
        NVActivityIndicatorView.DEFAULT_TEXT_COLOR = .appMainText
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = .systemFont(ofSize: 14)
        startAnimating(message: message, type: NVActivityIndicatorType.ballScaleMultiple)
    }

    func setLoadingMessage(message: String) {
        NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
    }

    func stopLoading() {
        stopAnimating()
    }

}
