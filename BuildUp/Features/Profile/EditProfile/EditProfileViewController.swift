//
//  EditProfileViewController.swift
//  BuildUp
//
//  Created by Mohammed Khaled on 06/12/2023.
//

import UIKit
import CountryPickerView

class EditProfileViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var updateProfileButton: UIButton!

    var editProfileModel = EditProfileModel()
    var imageData: Data?
    var profileImage: UIImage?
    var imagePicker = UIImagePickerController()
    
    var viewModel: EditProfileViewModel!
    var countryPickerView = CountryPickerView()

    override  var prefersBottomBarHidden: Bool? { return true }

    init(viewModel: EditProfileViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardObservers()
        setupResponses()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = L10n.Profile.Update.updateProfile
    }
    
    private func fillEditProfileModel() {
        if let customer = CachingService.getUser()?.customer {
            let userName = customer.fullName
            let phone = customer.phone
            let email = customer.email
            let phoneCode = "+\(customer.countryCode ?? "")"
            let countryFlag = countryPickerView.getCountryByPhoneCode(phoneCode)?.flag
            
            editProfileModel.avatar = customer.userImage
            editProfileModel.fullName = userName
            editProfileModel.phone = phone
            editProfileModel.email = email
            editProfileModel.countryCode = phoneCode
            editProfileModel.countryFlag = countryFlag
        }
    }
    
    private func setupView() {
        fillEditProfileModel()
        registerTableViewCells()
        setupCountryPickerView()
        
        containerView.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        self.view.backgroundColor = ThemeManager.colorPalette?.getMainBG().toUIColor(hexa: ThemeManager.colorPalette?.getMainBG() ?? "")
        
        updateProfileButton.backgroundColor = .dimmedButtonGray
        //ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
        updateProfileButton.titleLabel?.font = .appFont(ofSize: 15, weight: .semiBold)
        updateProfileButton.setTitle(L10n.Profile.Update.updateProfile, for: .normal)
        updateProfileButton.setTitleColor(ThemeManager.colorPalette?.buttonTextColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonTextColor1 ?? ""), for: .normal)
        
        ThemeManager.setCornerRadious(element: updateProfileButton, radius: 8)
    }
    
    private func updateUpdateProfileButtonAppearence() {
        if self.editProfileModel.fullName != nil &&
            !(self.editProfileModel.fullName?.isEmpty ?? false) &&
            self.editProfileModel.phone != nil &&
            !(self.editProfileModel.phone?.isEmpty ?? false) &&
            self.editProfileModel.email != nil &&
            self.editProfileModel.avatar != nil &&
            !(self.editProfileModel.email?.isEmpty ?? false) {
            updateProfileButton.backgroundColor = ThemeManager.colorPalette?.buttonColor1?.toUIColor(hexa: ThemeManager.colorPalette?.buttonColor1 ?? "")
            updateProfileButton.isUserInteractionEnabled = true
        } else {
            updateProfileButton.backgroundColor = .dimmedButtonGray
            updateProfileButton.isUserInteractionEnabled = false
        }
    }

    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 40, right: 0)
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
    
    private func setupCountryPickerView() {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
//        
//        countryPickerView.setCountryByCode("SA")
//        
//        self.editProfileModel.countryFlag = countryPickerView.getCountryByCode("SA")?.flag
//        self.editProfileModel.countryCode = countryPickerView.selectedCountry.phoneCode
    }
    
    @IBAction func updateProfileAction(_ sender: UIButton) {
        self.showLoading()
        viewModel.updateProfile(model: self.editProfileModel)
    }
}

// MARK: - Country PickerView Delegate
extension EditProfileViewController: CountryPickerViewDelegate, CountryPickerViewDataSource {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.editProfileModel.countryCode = country.phoneCode
        self.editProfileModel.countryFlag = country.flag
        
        self.tableView.reloadData()
    }
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        if let egypt = countryPickerView.countries.first(where: { ($0.code == "EG") }),
           let usa = countryPickerView.countries.first(where: { ($0.code == "SA") }) {
                return [egypt, usa]
            }
        return []
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return ""
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func localeForCountryNameInList(in countryPickerView: CountryPickerView) -> Locale {
        return Locale(identifier: LocalizationManager.currentLanguage().iosLanguageCode)
    }
}

// MARK: - Cell Delegates
extension EditProfileViewController: RegisterCellDelegate {
    func countryCodeButtonClicked() {
        countryPickerView.showCountriesList(from: self)
    }
    
    func nameChanged(name: String) {
        self.editProfileModel.fullName = name
        updateUpdateProfileButtonAppearence()
    }
    
    func emailChanged(email: String) {
        self.editProfileModel.email = email
        updateUpdateProfileButtonAppearence()
    }
    
    func phoneChanged(phone: String) {
        self.editProfileModel.phone = phone
        updateUpdateProfileButtonAppearence()
    }
    
    func countryCodeChanged(countryCode: String) {
        self.editProfileModel.countryCode = countryCode
        updateUpdateProfileButtonAppearence()
    }
    
    func passwordChanged(password: String) {
    }
    
    func confirmedPasswordChanged(confirmedPassword: String) {
    }
}

// MARK: - TableView Delegates
extension EditProfileViewController: UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate {
    func addPhotoAlertView() {
        let chooseTitle = L10n.Profile.Update.chooseImage
        let cameraTitle = L10n.Profile.Update.camera
        let galleryTitle = L10n.Profile.Update.gellary
        let cancelTitle = L10n.Profile.Update.cancel
        
        let alert = UIAlertController(title: chooseTitle, message: nil, preferredStyle: .actionSheet)
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 18, weight: .medium)]
        let titleString = NSAttributedString(string: cameraTitle, attributes: titleAttributes)
        
        alert.setValue(titleString, forKey: "attributedTitle")
        
        let cameraAction = UIAlertAction(title: cameraTitle, style: UIAlertAction.Style.default) { UIAlertAction in
            self.openCamera()
        }
        
        let gallaryAction = UIAlertAction(title: galleryTitle, style: UIAlertAction.Style.default) { UIAlertAction in
            self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel) { UIAlertAction in
            
        }
        
        // Add the actions
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
//        if (CachingService.getUser()?.user?.avatar) != nil {
//            alert.addAction(deleteAction)
//        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func openGallary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            self.editProfileModel.profileImage = pickedImage
            self.tableView .reloadData()
            if let imageData = pickedImage.jpegData(compressionQuality: 0.5) {
                self.editProfileModel.avatarData = imageData
                self.editProfileModel.avatar = MainImageModel(path: "")
                self.showLoading()
                self.viewModel.uploadProfilePicture(imageData)
            }
            self.updateUpdateProfileButtonAppearence()
            self.tableView.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
//    func deleteImage() {
//        if let imageId = CachingService.getUser()?.user?.avatar {
//            self.viewModel.deleteProfilePicture(id: imageId)
//        }
//    }
}


// MARK: - Responses
extension EditProfileViewController {
    func setupResponses() {
        setupUploadProfilePictureResponse()
        updateProfileResponse()
    }
    
    private func updateProfileResponse() {
        viewModel.onUpdateProfile = { [weak self] () in
            guard let `self` = self else { return }
            self.hideLoading()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupUploadProfilePictureResponse() {
        viewModel.onUploadProfilePicture = { [weak self] (response) in
            guard let `self` = self else { return }
            self.editProfileModel.avatarId = response.data?.id
            self.hideLoading()
            self.tableView.reloadData()
        }
    }
}
