//
//  CategoriesTabViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 19/09/2023.
//

import UIKit

class CategoriesTabViewController: BaseViewController {

    var viewModel: CategoriesTabViewModel!
    
    init(viewModel: CategoriesTabViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}