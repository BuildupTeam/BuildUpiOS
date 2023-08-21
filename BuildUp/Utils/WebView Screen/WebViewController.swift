//
//  flyers
//
//  Created by Mahmoud Nasser on 26/09/2022.
//

import UIKit
import WebKit
import SafariServices

// swiftlint:disable all
class WebViewController: BaseViewController {

    @IBOutlet private weak var headerView: SettingsHeaderView!
    @IBOutlet private weak var webContainerview: UIView!
    var webview: WKWebView = WKWebView()
    var webViewUrl: String?
    var pageTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeCookies()
        initialize()
        loadWebPage()
        setPageTitle()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func initialize() {
        setupWebView()
        headerView.delegate = self
        headerView.setProgressValue(progress: 0.0, animated: false)
    }
    
    func setPageTitle() {
        headerView.title = pageTitle ?? ""
        headerView.backgroundColor = .primaryColor
    }
    
    func setupWebView() {
//        self.webview = WKWebView()
        self.webview.configuration.suppressesIncrementalRendering = true
        self.webview.navigationDelegate = self
        self.webContainerview.addSubview(self.webview)
        self.constrainView(view: self.webview, toView: self.webContainerview)
       
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        webview.isOpaque = false
        webview.backgroundColor = UIColor.clear
        webview.scrollView.backgroundColor = UIColor.clear
    }
    
    // swiftlint:disable block_based_kvo
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        // Display Progress Bar While Loading Pages
        if keyPath == "estimatedProgress" {
            let estimatedProgress = Float(webview.estimatedProgress)
            self.headerView.setProgressValue(progress: estimatedProgress)
        }
    }
    
    deinit {
        print(#keyPath(WKWebView.estimatedProgress))
        webview.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    func constrainView(view: UIView, toView contentView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func loadWebPage() {
        removeCookies()
        
        if let urlString = webViewUrl {
            if let url = urlString.url {
                let urlRequest = URLRequest(url: url)
                webview.load(urlRequest)
            }
        }
    }
    func dismissViewController() {
        if (presentingViewController != nil) {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func removeCookies() {
        let cookieJar = HTTPCookieStorage.shared

        for cookie in cookieJar.cookies ?? [] {
            cookieJar.deleteCookie(cookie)
        }
    }
}

extension WebViewController: SettingsHeaderViewDelegate {
    func backButtonTapped() {
        dismissViewController()
    }
}

extension WebViewController {
    
//    class func instantiate(url: String, title: String) -> WebViewController {
//        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
//        if let viewController = storyboard.instantiateViewController(
//            withIdentifier: SabqWebViewViewController.identifier) as? SabqWebViewViewController {
//            viewController.webViewUrl = url
//            viewController.pageTitle = title
//            return viewController
//        }
//        return SabqWebViewViewController()
//    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        print(navigationAction.request.url)

        guard let url = URLComponents(string: navigationAction.request.url?.absoluteString ?? "") else { return }
        let success = url.queryItems?.first(where: { $0.name == "success" })?.value
        
        if let success = success {
            if success == "true" {
//                self.showSuccessMessage(message: L10n.PaymentMethods.Callback.success)
                self.dismissViewController()
            } else if success == "false" {
//                self.showError(message: L10n.PaymentMethods.Callback.failure)
                self.dismissViewController()
            }
        }
        print(success)
        
        if (navigationAction.targetFrame == nil || navigationAction.navigationType == .linkActivated) {
            if let url = navigationAction.request.url {
                if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                    // Can open with SFSafariViewController
                    let vc = SFSafariViewController(url: url)
                    present(vc, animated: true)
                } else {
                    // Scheme is not supported or no scheme is given, use openURL
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
        
//        if let response = navigationAction.response as? HTTPURLResponse {
//            print(response)
//        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        print(navigation)
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, error: Error?) in
            print(html)
        })
        
        headerView.setProgressValue(progress: 1)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        headerView.setProgressValue(progress: 1)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        headerView.setProgressValue(progress: 1)
    }
    
//    func webView(
//        _ webView: WKWebView,
//        decidePolicyFor navigationResponse: WKNavigationResponse,
//        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//
//            if let response = navigationResponse.response as? HTTPURLResponse {
//                print(response)
//            }
//            decisionHandler(.allow)
//        }
}
