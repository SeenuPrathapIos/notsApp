//
//  SecondViewController.swift
//  AlamaFire
//
//  Created by mac on 20/05/22.
//

import UIKit
import Alamofire
import GCDWebServer

class SecondViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var myscrollView:UIScrollView!
    
    var link:String = "https://reqres.in/api/users/2"
    
//    var emptyArray = [String:Any]()
    
    var myModel:LoginModel?
    let webServer = GCDWebServer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        example(url: link) { value, result in
//            print(value)
//            print(result)
//        }
        myscrollView.delegate = self
       
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
       
        
        initWebServer()
      
        
    }
    
    
    
    
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let indicatorView = scrollView.subviews.first(where: { $0.bounds.size.width <= 10 }) {
            indicatorView.backgroundColor = UIColor.purple
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        longestCommonPrefix(["flower","flow","flight"])
    }

    func longestCommonPrefix(_ strs: [String]) -> String {
        for i in 0..<strs.count{
            var name = strs[i]
            for j in 0..<strs[i].count{
//                print("i",i)
                    // print(name[j])
            }
        }
          
        return ""
        }
    
    @IBAction func backTapp(_ sender:UIButton){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismiss (animated: true) {
                if let navigationController = self.navigationController {
                       let openViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
                       navigationController.pushViewController(openViewController, animated: true)
                   }else {
                       print("Navigation controller is nil.")
                   }
            }
        }
    }
    
    func example(url:String,completion: @escaping (Bool,String) -> Swift.Void){
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            
            print(response)
            
            
           let result = response.result.isSuccess

           let data = response.value
            self.parse(jsonData: data as! NSDictionary)

            if result{
                print(self.myModel?.data.firstName)
                completion(true,"succes")
            }
            else{
                completion(false,"faild")
            }
        }
        
        
    }
    
    func parse(jsonData: NSDictionary) {
        do {
            let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: jsonData)
            let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: dataExample) as! [String : Any]
            let decodedData = try JSONDecoder().decode(LoginModel.self, from: dataExample)

            self.myModel = decodedData
        } catch {
            print("decode error")
        }
    }
    
    func initWebServer() {
        
        
        
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: {request in
            return GCDWebServerDataResponse(html:"<html><body><p>Hello World</p></body></html>")
            
        })
        
        
        webServer.addHandler(forMethod: "GET", path: "/alagu", request: GCDWebServerRequest.self) { request in
            print(request)
                    return GCDWebServerDataResponse(text: "how are u")
                }
            
        webServer.start(withPort: 8080, bonjourName: "GCD Web Server")
        
        print("Visit \(webServer.serverURL) in your web browser")
        

    }
   
}



extension UIViewController:UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
                navigationController?.popViewController(animated: true)
            }
            return false
        }
    
    
}
