//
//  UIImageView+Extension.swift
//  DemoTask
//
//  Created by MacMini-dev on 24/05/23.
//

import UIKit
import Kingfisher
// MARK: - UIImageview extension
extension UIImageView {
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
