//
//  UIImage+Extensions.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator. All rights reserved.
//

import UIKit
import SDWebImage

let imageUrl = "https://image.tmdb.org/t/p/w500/"

extension UIImageView {
    
    func downloadImageWithBaseUrl(url: String?, needBaseUrl: Bool, placeholderImage: UIImage? = nil, errorImage: UIImage? = nil, backgroundColor: UIColor = .white, finishDownloadBackgroundColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        sd_cancelCurrentImageLoad()
        if placeholderImage != nil {
            image = placeholderImage
        }
        var fullUrl: String?
        if needBaseUrl {
            fullUrl = imageUrl + (url ?? "")
        } else {
            fullUrl = url ?? ""
        }
        
        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: fullUrl) {
            if finishDownloadBackgroundColor != nil {
                self.backgroundColor = finishDownloadBackgroundColor!
            }
            image = cachedImage
        } else {
            downloadImage(url: URL(string: fullUrl ?? ""), backgroundColor: backgroundColor, finishDownloadBackgroundColor: finishDownloadBackgroundColor) { [weak self]  downloadedImage in
            guard let self = self else { return }
                self.image = downloadedImage
            }
        }
    }
    
    func downloadImage(url: URL?, errorImage: UIImage? = nil, backgroundColor: UIColor = .white, finishDownloadBackgroundColor: UIColor? = nil, completion: @escaping (_ downloadedImage: UIImage?) -> Void) {
        self.backgroundColor = backgroundColor
        sd_setImage(with: url, placeholderImage: nil, options: [.avoidAutoSetImage]) { [weak self] (image, error, cache, url) in
            guard let self = self else { return }
            if image != nil {
                if finishDownloadBackgroundColor != nil {
                    self.backgroundColor = finishDownloadBackgroundColor!
                }
                completion(image)
                self.image = image
            } else if error != nil {
                self.image = errorImage
            }
        }
    }
    
}
