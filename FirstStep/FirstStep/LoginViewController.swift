//
//  LoginViewController.swift
//  FirstStep
//
//  Created by Rishi on 5/7/17.
//  Copyright © 2017 rishindra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    //MARK: Actions
    @IBOutlet weak var SubmitUIButton: UIButton!
    @IBOutlet weak var SignupUIButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SubmitUIButton(_ sender: UIButton){
        
        sendRequest(params: ["e": EmailTextField.text!, "p": PasswordTextField.text!])
        
            }
    
    
    
    
    func sendRequest(params: [String:String]) {
        
        let urlLink = NSURLComponents(string: "http://ec2-34-223-223-204.us-west-2.compute.amazonaws.com:8090/login")!
        
        var param = [URLQueryItem]()
        
        for (key,value) in params {
            param.append(URLQueryItem(name: key, value: value))
        }
        
        param = param.filter{!$0.name.isEmpty}
        
        if !param.isEmpty {
            urlLink.queryItems = param
        }
        
        var urlRequest = URLRequest(url: urlLink.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let send = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if(error != nil){
                print(error.debugDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                print("status code for get request on login is \(httpResponse.statusCode))")
                
            }
            print(response)
            
        })
        send.resume()
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
