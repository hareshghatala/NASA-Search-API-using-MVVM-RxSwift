//
//  ListItemTableViewCell.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    public var cellData: ListItem! {
        didSet {
            if let imgUrl = cellData.getImageLink() {
                thumbImage.load(urlStr: imgUrl, placeholder: false)
            }
        
            guard let details = cellData.getDetail() else {
                return
            }
            titleLabel.text = details.title
            let photographer = details.photographer ?? notFoundText
            let photoDate = details.dateCreated?.toString(format: listDateForamt) ?? notFoundText
            subtitleLabel.text = "\(photographer) | \(photoDate)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImage.image = UIImage()
    }
}
