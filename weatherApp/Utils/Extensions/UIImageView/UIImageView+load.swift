//
//  UIImageView+load.swift
//  weatherApp
//
//  Created by Khaled Bohout on 13/03/2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    func load(with url: String, placeHolder: UIImage? = nil) {
        guard let url = URL(string: url) else { return }
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: url,
                         placeholderImage: placeHolder,
                         options: .continueInBackground,
                         completed: nil)
    }
}
