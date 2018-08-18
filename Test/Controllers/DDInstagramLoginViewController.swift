//
//  DDInstagramLoginViewController.swift
//  CoreDataTest
//
//  Created by Duba on 04.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DDInstagramLoginDelegate : class {
    func getInstagramAccessToken(_ accessToken: String)
}

class DDInstagramLoginViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    deinit {
        print("Instagram GoodBye\n\n\n\n\n\n\n\n\n\n")
    }
    var accessToken = ""
    weak var delegate : DDInstagramLoginDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        let string = "https://api.instagram.com/oauth/authorize/?client_id=b71c42c1e6844edeb681035094afd0b9&redirect_uri=https://study.com&response_type=token&scope=public_content"
       
        guard let url = URL(string: string) else {
            return
        }
       
        let urlReques = URLRequest(url: url)

        self.webView.loadRequest(urlReques)
 
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Action
    
    @IBAction func cancelBarButton(_ sender: Any) {
         self.dismiss(animated: true, completion:nil)
    }
    
    
    
    //MARK: - UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix("https://study.com") {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            accessToken = String(requestURLString[range.upperBound...])
            if accessToken != "" {
                print(accessToken)
              
                
                self.delegate?.getInstagramAccessToken(self.accessToken)
                self.dismiss(animated: true, completion:nil)
                  
  
                return false
                
            }

            
        }
        return true
    }
    
    
     
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
