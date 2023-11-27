//
//  HomeViewController+TableView.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 02/08/2023.
//

import Foundation
import UIKit

enum HomeDesign: String {
    case productVerticalList1 = "product-vertical-list-1"
    case productVerticalList2 = "product-vertical-list-2"
    case productVerticalList3 = "product-vertical-list-3"
    
    case productVerticalGrid1 = "product-vertical-grid-1"
    case productVerticalGrid2 = "product-vertical-grid-2"
    case productVerticalGrid3 = "product-vertical-grid-3"
    case productVerticalGrid4 = "product-vertical-grid-4"
    case productVerticalGrid5 = "product-vertical-grid-5"
    case productHorizontalList1 = "product-horizontal-list-1"
    
    case categoriesHorizontalList1 = "categories-horizontal-list-1"
    case categoriesHorizontalList2 = "categories-horizontal-list-2"
    case categoriesHorizontalList3 = "categories-horizontal-list-3"
    
    case categoriesVerticalGrid1 = "categories-vertical-grid-1"
    case categoriesVerticalGrid2 = "categories-vertical-grid-2"
    case categoriesVerticalGrid3 = "categories-vertical-grid-3"
    
    case banner1 = "banner-1"
    case banner2 = "banner-2"
    case banner3 = "banner-3"
}

// MARK: Register TableView Cells
extension HomeViewController {
    func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: ProductVerticalList1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalList2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalList3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalList3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalGrid1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalGrid1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalGrid2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalGrid2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalGrid3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalGrid3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalGrid4TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalGrid4TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductVerticalGrid5TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductVerticalGrid5TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductHorizontalList1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductHorizontalList1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ProductsHeaderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ProductsHeaderTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CategoriesHorizontalList1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CategoriesHorizontalList1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CategoriesHorizontalList2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CategoriesHorizontalList2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CategoriesHorizontalList3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CategoriesHorizontalList3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CategoriesVerticalGrid1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CategoriesVerticalGrid1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CategoriesVerticalGrid2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CategoriesVerticalGrid2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: CategoriesVerticalGrid3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CategoriesVerticalGrid3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: BannerType1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: BannerType1TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: BannerType2TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: BannerType2TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: BannerType3TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: BannerType3TableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: HomeHeaderTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: HomeHeaderTableViewCell.identifier)
        
        self.tableView.register(
            UINib(nibName: ShimmerProductVerticalListTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerProductVerticalListTableViewCell.identifier)
        self.tableView.register(
            UINib(nibName: ShimmerBannerType1TableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ShimmerBannerType1TableViewCell.identifier)
        
    }
}

// MARK: Dynamic Components
extension HomeViewController {
    
    func getNumberOfRowsForSection(section: Int) -> Int {
        guard let design = viewModel.homeData.homeSections[section].component?.design else {
            return  0
        }
        if isLoadingShimmer {
            return 1
        } else {
            let homeSectionModel = viewModel.homeData.homeSections[section]

            switch design {
            case HomeDesign.productVerticalList1.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productVerticalList2.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productVerticalList3.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productVerticalGrid1.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productVerticalGrid2.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productVerticalGrid3.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productVerticalGrid4.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productVerticalGrid5.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.productHorizontalList1.rawValue:
                return (homeSectionModel.products?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.categoriesHorizontalList1.rawValue:
                return (homeSectionModel.categories?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.categoriesHorizontalList2.rawValue:
                return (homeSectionModel.categories?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.categoriesHorizontalList3.rawValue:
                return (homeSectionModel.categories?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.categoriesVerticalGrid1.rawValue:
                return (homeSectionModel.categories?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.categoriesVerticalGrid2.rawValue:
                return (homeSectionModel.categories?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.categoriesVerticalGrid3.rawValue:
                return (homeSectionModel.categories?.isEmpty ?? true) ? 0 : 1
            case HomeDesign.banner1.rawValue:
                return 1
            case HomeDesign.banner2.rawValue:
                return 1
            case HomeDesign.banner3.rawValue:
                return 1
            default:
                return 0
            }
        }
    }
    
    func getCellForSection(section: Int, indexPath: IndexPath) -> UITableViewCell {
        guard let design = viewModel.homeData.homeSections[section].component?.design else {
            return  UITableViewCell()
        }
        
        let homeSectionModel = viewModel.homeData.homeSections[section]
        if isLoadingShimmer {
            switch design {
            case HomeDesign.productVerticalList1.rawValue,
                HomeDesign.productVerticalList2.rawValue,
                HomeDesign.productVerticalList3.rawValue:
                return getShimmerCell(indexPath: indexPath)
            case HomeDesign.productVerticalGrid1.rawValue,
                HomeDesign.productVerticalGrid2.rawValue,
                HomeDesign.productVerticalGrid3.rawValue,
                HomeDesign.productVerticalGrid4.rawValue,
                HomeDesign.productVerticalGrid5.rawValue:
                return getProductVerticalGrid1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesHorizontalList1.rawValue:
                return getCategoriesHorizontalList1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesHorizontalList2.rawValue:
                return getCategoriesHorizontalList2TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesHorizontalList3.rawValue:
                return getCategoriesHorizontalList1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesVerticalGrid1.rawValue,
                HomeDesign.categoriesVerticalGrid2.rawValue,
                HomeDesign.categoriesVerticalGrid3.rawValue:
                return UITableViewCell()
            case HomeDesign.productHorizontalList1.rawValue:
                return UITableViewCell()
            case HomeDesign.banner1.rawValue,
                HomeDesign.banner2.rawValue,
                HomeDesign.banner3.rawValue:
                return getBannerType1ShimmerCell(indexPath: indexPath)
            default:
                return UITableViewCell()
            }
        } else {
            switch design {
            case HomeDesign.productVerticalList1.rawValue:
                return getProductVerticalList1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productVerticalList2.rawValue:
                return getProductVerticalList2TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productVerticalList3.rawValue:
                return getProductVerticalList3TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productVerticalGrid1.rawValue:
                return getProductVerticalGrid1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productVerticalGrid2.rawValue:
                return getProductVerticalGrid2TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productVerticalGrid3.rawValue:
                return getProductVerticalGrid3TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productVerticalGrid4.rawValue:
                return getProductVerticalGrid4TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productVerticalGrid5.rawValue:
                return getProductVerticalGrid5TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.productHorizontalList1.rawValue:
                return getProductHorizontalList1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesHorizontalList1.rawValue:
                return getCategoriesHorizontalList1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesHorizontalList2.rawValue:
                return getCategoriesHorizontalList2TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesHorizontalList3.rawValue:
                return getCategoriesHorizontalList3TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesVerticalGrid1.rawValue:
                return getCategoriesVerticalGrid1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesVerticalGrid2.rawValue:
                return getCategoriesVerticalGrid2TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.categoriesVerticalGrid3.rawValue:
                return getCategoriesVerticalGrid3TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.banner1.rawValue:
                return getBanner2TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.banner2.rawValue:
                return getBanner1TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            case HomeDesign.banner3.rawValue:
                return getBanner3TableViewCell(indexPath: indexPath, homeSectionModel: homeSectionModel)
            default:
                return UITableViewCell()
            }
        }
    }
}

// MARK: Get Home Cells
extension HomeViewController {
    private func getSectionHeaderCell(homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeHeaderTableViewCell.identifier) as? HomeHeaderTableViewCell
            else { return UITableViewCell() }
        
        cell.homeSectionModel = homeSectionModel
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalList1TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList1TableViewCell.identifier,
            for: indexPath) as? ProductVerticalList1TableViewCell
        else { return UITableViewCell() }
        
        cell.addTocartDelegate = self
        cell.delegate = self
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalList2TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList2TableViewCell.identifier,
            for: indexPath) as? ProductVerticalList2TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalList3TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalList3TableViewCell.identifier,
            for: indexPath) as? ProductVerticalList3TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalGrid1TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalGrid1TableViewCell.identifier,
            for: indexPath) as? ProductVerticalGrid1TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalGrid2TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalGrid2TableViewCell.identifier,
            for: indexPath) as? ProductVerticalGrid2TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalGrid3TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalGrid3TableViewCell.identifier,
            for: indexPath) as? ProductVerticalGrid3TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalGrid4TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalGrid4TableViewCell.identifier,
            for: indexPath) as? ProductVerticalGrid4TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductVerticalGrid5TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductVerticalGrid5TableViewCell.identifier,
            for: indexPath) as? ProductVerticalGrid5TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getProductHorizontalList1TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductHorizontalList1TableViewCell.identifier,
            for: indexPath) as? ProductHorizontalList1TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCategoriesHorizontalList1TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesHorizontalList1TableViewCell.identifier,
            for: indexPath) as? CategoriesHorizontalList1TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCategoriesHorizontalList2TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesHorizontalList2TableViewCell.identifier,
            for: indexPath) as? CategoriesHorizontalList2TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCategoriesHorizontalList3TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesHorizontalList3TableViewCell.identifier,
            for: indexPath) as? CategoriesHorizontalList3TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCategoriesVerticalGrid1TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesVerticalGrid1TableViewCell.identifier,
            for: indexPath) as? CategoriesVerticalGrid1TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCategoriesVerticalGrid2TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesVerticalGrid2TableViewCell.identifier,
            for: indexPath) as? CategoriesVerticalGrid2TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getCategoriesVerticalGrid3TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesVerticalGrid3TableViewCell.identifier,
            for: indexPath) as? CategoriesVerticalGrid3TableViewCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        cell.isLoadingShimmer = self.isLoadingShimmer
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getBanner1TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BannerType1TableViewCell.identifier,
            for: indexPath) as? BannerType1TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getBanner2TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BannerType2TableViewCell.identifier,
            for: indexPath) as? BannerType2TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
    
    private func getBanner3TableViewCell(indexPath: IndexPath, homeSectionModel: HomeSectionModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BannerType3TableViewCell.identifier,
            for: indexPath) as? BannerType3TableViewCell
        else { return UITableViewCell() }
        
//        cell.delegate = self
        cell.homeSectionModel = homeSectionModel
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Shimmer
extension HomeViewController {
    private func getShimmerCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerProductVerticalListTableViewCell.identifier,
            for: indexPath) as? ShimmerProductVerticalListTableViewCell
        else { return UITableViewCell() }
        
        cell.isExclusiveTouch = true
        cell.selectionStyle = .none
        return cell
    }
    
    private func getBannerType1ShimmerCell(indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShimmerBannerType1TableViewCell.identifier,
            for: indexPath) as? ShimmerBannerType1TableViewCell
        else { return UITableViewCell() }
        
        cell.isExclusiveTouch = true
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        if viewModel.homeData.isAllDynamicDataValid {
//            return viewModel.homeData.homeSections.count
//        } else {
//            return 0
//        }
        
        print("viewModel.homeData.homeSections.count = \(viewModel.homeData.homeSections.count)")
        return viewModel.homeData.homeSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfRowsForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return getCellForSection(section: indexPath.section, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let design = viewModel.homeData.homeSections[indexPath.section].component?.design else {
            return UITableView.automaticDimension
        }
        let homeSectionModel = viewModel.homeData.homeSections[indexPath.section]
        
        if isLoadingShimmer {
            return 125
        }
        switch design {
        case HomeDesign.productVerticalList1.rawValue,
            HomeDesign.productVerticalList2.rawValue:
            return CGFloat((homeSectionModel.products?.count ?? 0) * 122)
        case HomeDesign.productVerticalList3.rawValue:
            return CGFloat((homeSectionModel.products?.count ?? 0) * 136)
        default:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let design = viewModel.homeData.homeSections[indexPath.section].component?.design else {
            return
        }
        let homeSectionModel = viewModel.homeData.homeSections[indexPath.section]
        
        switch design {
        case HomeDesign.productVerticalList1.rawValue,
            HomeDesign.productVerticalList2.rawValue,
            HomeDesign.productVerticalList3.rawValue:
            let detailsVC = Coordinator.Controllers.createProductDetailsViewController(componentModel: homeSectionModel.component)
            detailsVC.productModel = homeSectionModel.products?[indexPath.row]
            self.navigationController?.pushViewController(detailsVC, animated: true)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isLoadingShimmer {
            return nil
        }
        let homeSectionModel = viewModel.homeData.homeSections[section]
        return getSectionHeaderCell(homeSectionModel: homeSectionModel)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let component = viewModel.homeData.homeSections[section].component else {
            return 0
        }
        
        let homeSectionModel = viewModel.homeData.homeSections[section]
        if (homeSectionModel.products?.isEmpty ?? false) || homeSectionModel.categories?.isEmpty ?? false {
            return 0
        }
        
        if isLoadingShimmer {
            return 0
        } else {
            if component.displayTitle ?? false && !(component.title?.isEmptyString ?? false ) && component.design != HomeDesign.banner1.rawValue  {
                let title = component.title
                let textHeight = title?.height(withConstrainedWidth: (self.view.frame.size.width - 120), font: UIFont.appFont(ofSize: 16, weight: .bold)) ?? 0
                
                return textHeight + 40
            }
        }
        return 0
    }
}
