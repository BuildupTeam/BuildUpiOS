//
//  Coordinator.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 20/05/2023.
//

import Foundation
import UIKit

class Coordinator {
    class AppBase {
        class func baseNavigationController() -> UINavigationController {
            
            //            let backButton = Asset.icArrowLeft.image
            let backButton = UIImage(named: "") //Asset.icBackNew.image
            
            UINavigationBar.appearance().backIndicatorImage = backButton
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButton
            
            let navigation = UINavigationController()
            navigation.edgesForExtendedLayout = []
            navigation.extendedLayoutIncludesOpaqueBars = false
            navigation.setNavigationBarHidden(false, animated: false)
            
            navigation.view.backgroundColor = .clear
            
            //            navigation.navigationBar.setShadow(
            //                shadowRadius: CGFloat(0.5),
            //                xOffset: 0,
            //                yOffset: 2,
            //                color: .black,
            //                opacity: 0.07,
            //                cornerRadius: CGFloat(3),
            //                masksToBounds: false)
            
            navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigation.navigationBar.shadowImage = UIImage()
            navigation.navigationBar.backgroundColor = .white
            navigation.navigationBar.tintColor = .titlesBlack
            
            let extraHeight: CGFloat = 10
            let bounds = navigation.navigationBar.bounds
            navigation.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + extraHeight)
            
            return navigation
        }
    }
    
    class MainTaps {
        class func createHomeViewController(viewModel: HomeViewModel = HomeViewModel()) -> UIViewController {
            let viewController = HomeViewController(viewModel: viewModel)
            
            let navigation = Coordinator.AppBase.baseNavigationController()
            navigation.setViewControllers([viewController], animated: true)
            return navigation
        }
        
        //        class func createSettingsViewController(viewModel: BaseViewModel = BaseViewModel()) -> UIViewController {
        //            let viewController = SettingsViewController(viewModel: viewModel)
        //
        //            let navigation = Coordinator.AppBase.baseNavigationController()
        //            navigation.setViewControllers([viewController], animated: true)
        //            return navigation
        //        }
        
    }
    
    class Controllers {
        class func createProductDetailsViewController(
            productModel: ProductModel? = nil,
            isShareAction: Bool = false,
            viewModel: ProductDetailsViewModel = ProductDetailsViewModel()) -> ProductDetailsViewController {
                viewModel.productModel = productModel
                let viewController = ProductDetailsViewController(viewModel: viewModel)
                return viewController
            }
        
        class func createProductListViewController(
            homeSectionModel: HomeSectionModel? = nil,
            viewModel: ProductListViewModel = ProductListViewModel()) -> ProductsListViewController {
                viewModel.homeSectionModel = homeSectionModel
                let viewController = ProductsListViewController(viewModel: viewModel)
                return viewController
            }
        class func createProductsGridViewController(
            homeSectionModel: HomeSectionModel? = nil,
            viewModel: ProductListViewModel = ProductListViewModel()) -> ProductsGridViewController {
                viewModel.homeSectionModel = homeSectionModel
                let viewController = ProductsGridViewController(viewModel: viewModel)
                return viewController
            }
        class func createCategoryDetailsListViewController(categoryModel: CategoryModel? = nil,
                                                           viewModel: CategoryDetailsViewModel = CategoryDetailsViewModel()) -> CategoryDetailsListViewController {
            viewModel.categoryModel = categoryModel
            let viewController = CategoryDetailsListViewController(viewModel: viewModel)
            viewController.categoryModel = categoryModel
            return viewController
        }
        
        class func createCategoryDetailsGridViewController(categoryModel: CategoryModel? = nil,
                                                           viewModel: CategoryDetailsViewModel = CategoryDetailsViewModel()) -> CategoryDetailsGridViewController {
            viewModel.categoryModel = categoryModel
            let viewController = CategoryDetailsGridViewController(viewModel: viewModel)
            viewController.categoryModel = categoryModel
            return viewController
        }
        
        class func createCategoryListViewController(homeSectionModel: HomeSectionModel? = nil,
                                                    viewModel: CategoriesViewModel = CategoriesViewModel()) -> CategoriesListViewController {
            viewModel.homeSectionModel = homeSectionModel
            let viewController = CategoriesListViewController(viewModel: viewModel)
            return viewController
        }
    }
}
