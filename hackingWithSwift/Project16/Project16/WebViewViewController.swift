//
//  WebViewViewController.swift
//  Project16
//
//  Created by COBE on 12/06/2021.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate  {
    
    var webView: WKWebView!
    var selectedCapital: String?
    var url: URL?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let capital = selectedCapital {
            switch capital {
            case "London":
                url = URL(string: "https://hr.wikipedia.org/wiki/London")!
            case "Oslo":
                url = URL(string: "https://hr.wikipedia.org/wiki/Oslo")!
            case "Paris":
                url = URL(string: "https://hr.wikipedia.org/wiki/Pariz")!
            case "Washington DC":
                url = URL(string: "https://hr.wikipedia.org/wiki/Washington")!
            case "Rome":
                url = URL(string: "https://hr.wikipedia.org/wiki/Rim")!
            default :
                url = URL(string: "https://hr.wikipedia.org/wiki/London")!
            }
        }
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
