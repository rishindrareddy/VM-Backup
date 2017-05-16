//
//  NewLoginViewController.swift
//  FirstStep
//
//  Created by Student on 5/15/17.
//  Copyright © 2017 rishindra. All rights reserved.
//

import UIKit

class NewLoginViewController: UIViewController {

    //MARK: PROPERTIES
    
    @IBOutlet weak var EmailUITextField: UITextField!
    @IBOutlet weak var PasswordUITextField: UITextField!
    
    //MARK: ACTIONS
    @IBOutlet weak var LoginUIButton: UIButton!
    @IBOutlet weak var SignupUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //CLICK EVENT ON LOGIN
    
    @IBAction func LoginClick(_ sender: UIButton) {
        print("\n CREDENTIALS:\n EMAIL : \(EmailUITextField.text)!,,, PASSWORD:\(PasswordUITextField.text)! \n")
        
        sendRequest(params: ["e":(EmailUITextField.text)!,"p":(PasswordUITextField.text)!])
    }
    
    
    
    
    //HTTP REQUEST FUNCTION
    //for authenticating user credientials
    
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
    print("\nERROR DESC:\n",error.debugDescription)
    }
        print("\n RESPONSE DESC:\n",response?.description as Any)
                print("\n DATA DESC:\n",data?.description as Any)
                        print("\n DATA DESC:\n",data?.base64EncodedString() as Any)
    
        let responseData = String(data: data!, encoding: String.Encoding.utf8)
        print("\n RESPONSE DATA:\n",responseData as Any)
        
    if let httpResponse = response as? HTTPURLResponse{
    print("\n \n STATUS CODE: \n status code for get request on login is \(httpResponse.statusCode)")
    
    }
        
    
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
