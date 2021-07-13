//
//  ListViewController.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var viewModel = NasaSearchViewModel()
    
    public let listItems: PublishSubject<[ListItem]> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    // MARK: - View's Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.tableFooterView = UIView()
        setupBindings()
        viewModel.requestData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.selectedItem.onNext(viewModel.selectedItemData)
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        
        // Binding loading to VC
        viewModel
            .loading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // Observing errors to show
        viewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (error) in
                var msgText = ""
                switch error {
                    case .internetError(let message):
                        msgText = message
                    case .serverMessage(let message):
                        msgText = message
                }
                
                let alertMsg = UIAlertController(title: errorTitle, message: msgText, preferredStyle: .alert)
                let retryAction = UIAlertAction(title: retryText, style: .default) { _ in
                    self.viewModel.requestData()
                }
                alertMsg.addAction(retryAction)
                self.present(alertMsg, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        // Binding listItems to viewModel listItems
        viewModel
            .listItems
            .observe(on: MainScheduler.instance)
            .bind(to: self.listItems)
            .disposed(by: disposeBag)
        
        // Binding list items to tableview
        listItems
            .bind(to: listTableView.rx.items(cellIdentifier: listItemCellId, cellType: ListItemTableViewCell.self)) { (row, item, cell) in
                cell.cellData = item
        }.disposed(by: disposeBag)
        
        listTableView.rx.willDisplayCell
            .subscribe(onNext: ( { (cell, indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
        // Binding tableview selection
        listTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.listTableView.cellForRow(at: indexPath) as! ListItemTableViewCell
                self?.viewModel.selectedItemData = cell.cellData
            }).disposed(by: disposeBag)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Binding selected item to detail view
        if segue.identifier == showDetailSegueId {
            let detailVC = segue.destination as! DetailViewController
            viewModel
                .selectedItem
                .observe(on: MainScheduler.instance)
                .bind(to: detailVC.item)
                .disposed(by: disposeBag)
        }
    }
    
}
