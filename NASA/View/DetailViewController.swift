//
//  DetailViewController.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var leadImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public let item: PublishSubject<ListItem> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    private func setupBinding() {
        
        item.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] listItem in
                guard let strongSelf = self else {
                    return
                }
                
                if let imgUrl = listItem.getImageLink() {
                    strongSelf.leadImage.load(urlStr: imgUrl, placeholder: false)
                }
                
                guard let details = listItem.getDetail() else {
                    return
                }
                strongSelf.titleLabel.text = details.title
                let photographer = details.photographer ?? notFoundText
                let photoDate = details.dateCreated?.toString(format: listDateForamt) ?? notFoundText
                strongSelf.subtitleLabel.text = "\(photographer) | \(photoDate)"
                strongSelf.descriptionLabel.text = details.description ?? notFoundText
            })
            .disposed(by: disposeBag)
    }

}
