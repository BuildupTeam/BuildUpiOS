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
            let backButton = Asset.navBackButton.image
            
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
            navigation.navigationBar.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "") //.white
            navigation.navigationBar.tintColor = ThemeManager.colorPalette?.titleColor?.toUIColor(hexa: ThemeManager.colorPalette?.titleColor ?? "") //.titlesBlack
            
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
        
        class func createCategoriesViewController(viewModel: CategoriesTabViewModel = CategoriesTabViewModel()) -> UIViewController {
            let viewController = CategoriesTabViewController(viewModel: viewModel)
            
            let navigation = Coordinator.AppBase.baseNavigationController()
            navigation.setViewControllers([viewController], animated: true)
            return navigation
        }
        
        class func createCartViewController(viewModel: CartViewModel = CartViewModel()) -> UIViewController {
            let viewController = CartViewController(viewModel: viewModel)
            
            let navigation = Coordinator.AppBase.baseNavigationController()
            navigation.setViewControllers([viewController], animated: true)
            return navigation
        }
        
        class func createProfileViewController(viewModel: ProfileViewModel = ProfileViewModel()) -> UIViewController {
            let viewController = ProfileViewController(viewModel: viewModel)
            
            let navigation = Coordinator.AppBase.baseNavigationController()
            navigation.setViewControllers([viewController], animated: true)
            return navigation
        }
        
        class func createSettingsViewController(viewModel: SettingsViewModel = SettingsViewModel()) -> UIViewController {
            let viewController = SettingsViewController(viewModel: viewModel)

            let navigation = Coordinator.AppBase.baseNavigationController()
            navigation.setViewControllers([viewController], animated: true)
            return navigation
        }
        
    }
    
    class Controllers {
        class func createProductDetailsViewController(
            productModel: ProductModel? = nil,
            componentModel: ComponentConfigurationModel? = nil,
            isShareAction: Bool = false,
            viewModel: ProductDetailsViewModel = ProductDetailsViewModel()) -> ProductDetailsViewController {
                viewModel.productModel = productModel
                viewModel.componentModel = componentModel
                let viewController = ProductDetailsViewController(viewModel: viewModel)
                return viewController
            }
        
        class func createProductListViewController(
            homeSectionModel: HomeSectionModel? = nil,
            componentModel: ComponentConfigurationModel? = nil,
            viewModel: ProductListViewModel = ProductListViewModel()) -> ProductsListViewController {
                viewModel.homeSectionModel = homeSectionModel
                viewModel.componentModel = componentModel
                let viewController = ProductsListViewController(viewModel: viewModel)
                return viewController
            }
        class func createProductsGridViewController(
            homeSectionModel: HomeSectionModel? = nil,
            componentModel: ComponentConfigurationModel? = nil,
            viewModel: ProductListViewModel = ProductListViewModel()) -> ProductsGridViewController {
                viewModel.homeSectionModel = homeSectionModel
                viewModel.componentModel = componentModel
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
        
        class func createSubdomainViewController(viewModel: SubdomainViewModel = SubdomainViewModel()) -> SubdomainViewController {
            let viewController = SubdomainViewController(viewModel: viewModel)
            return viewController
        }
    }
}
