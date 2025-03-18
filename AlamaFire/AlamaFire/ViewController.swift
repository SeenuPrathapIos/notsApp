//
//  ViewController.swift
//  AlamaFire
//
//  Created by mac on 20/05/22.
//

import UIKit
import Alamofire
import SocketIO
import HttpSwift

class ViewController: UIViewController {

    let baseUrl:String = "https://inocyxmobback.osiztech.com/api/v1/"
    
    var email = "seenuprathap2000@gmail.com"
    var password = "osiz@123"
    var confirm_password = "osiz@123"
    var country = GoogleApiKey.key
    var referralcode = GoogleApiKey.iv
    var lightAnimation = false
    
    @IBOutlet weak var myimageView:UIImageView!
    
    // https://inliqdusdnwekixosp.inocyx.com/
    // http://localhost:8927/
    let manager = SocketManager(socketURL: URL(string: "http://172.16.16.128:8927")!, config: [.log(true), .compress,.forceWebsockets(true)])
    
    
    // wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self
   
    
    var dataArray = [String:Any]()
    
   // "email", "password", "confirm_password", "country", "referralcode"
    
    
    let perams: [String:Any] = ["email" : "seenuprathap2000@gmail.com",
                                "password": "osiz@123",
                                "confirm_password":"osiz@123",
                                "country":"India",
                                "referralcode": ""]
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        register(url: baseUrl + "register"){ value,result in
//            if value{print(result)}
//            else{print("failed")}
//        }
        
        
//        login(url: baseUrl + "login") { value, result in
//            print(value)
//            print(result)
//        }
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        var b:[Any] = [1,2,3,34,[4,5,[6,7,[8,9,[10,11,12]]]]]
//        sharedTask.go(b: b)

        let strings = "seenu manoj karthick seenu asvith manoj ram karthick"
//        sharedTask.call(value: strings)
        
        let intArray = [3,100,5,34,105,6,74,4,98,97]
//        sharedTask.secondLargeNumber(intArray: intArray)
        
//        socketConect()
        
        myimageView.image = UIImage(named: "light-off")
        
        serverCreation()
    }
    
   
  
    
    func register(url:String,completion: @escaping (Bool,String) -> Swift.Void){
        
        Alamofire.request(url, method: .post, parameters: self.perams, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            
            print(response)
            
            
            let result = response.result.isSuccess
            
            let data = response.value as? [String:Any]
            if let x = data?["message"]{
            print(x)
            }
            if result{
                completion(true,"succes")
            }
            else{
                completion(false,"faild")
            }
        }
        
        
    }
    
    @IBAction func goTapp(_ sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController" ) as! SecondViewController
        self.present(vc, animated: true)
        
//        if !lightAnimation{
//            lightAnimation = true
//            myimageView.setImage(UIImage(named: "light-on"), animated: true)
//        }else{
//            lightAnimation = false
//            myimageView.setImage(UIImage(named: "light-off"), animated: true)
//        }
//        
//        let socket = manager.defaultSocket
//        
//        socket.emit("hitest",["deviceID": self.getDeviceID()])
//        
//        
//        Alamofire.request("http://localhost:8000/hello/1", method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON{
//            response in
//            
//            print(response)
//        }
    }
    
    let peramsLogin: [String: Any] = ["username": "vignesh@osiztechnologies.in",
                                      "password": "Osiz@123",
                                      "deviceInfo":"iphone 8","ipaddress":"192.2.67.105"]
    
    func login(url:String,completion: @escaping (Bool,Int) -> Swift.Void){
        
        
        
        Alamofire.request(url, method: .post, parameters: peramsLogin, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            
            
         
            
            print(response)
            let result = response.result.isSuccess
            let data = response.value as? [String:Any]
            
            
            let dataArray = data?["data"]as? [String:Any] ?? [String:Any] ()
            
            print("dataArray",dataArray)
//
//            let selfData = data?["email"] ?? "-"
//            print(selfData)
            
//            if let x =  data?["email"]{
//                print(x)
//            }
            
           
            
            if result{
                completion(true, 1)
            }
            else{
                completion(false, 0)
            }

        }
        
    }
    
}


//MARK: - Socket

extension ViewController{
    
    func socketConect(){
        
        let deviceID = self.getDeviceID()
        print(deviceID)
        
    let socket = manager.defaultSocket
        
        socket.off(clientEvent: .connect)
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            print(data,ack)
            
            socket.emit("joinRoom",["deviceID": deviceID])
            
        }
        
        socket.off("hitest")
        socket.on("hitest") { data, act in
            print(data)
            // Create an alert controller
            let alertController = UIAlertController(title: "Alert Title", message: "This is a message in the alert", preferredStyle: .alert)

            // Add an action button to the alert
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                // Handle the action when the button is tapped
            })
            alertController.addAction(okAction)

            // Present the alert controller
            self.present(alertController, animated: true, completion: nil)
        }
        
        let dataToSend = ["deviceID": deviceID]
        socket.connect(withPayload: dataToSend)
    }
    
    func getDeviceID() -> String {
        let device = UIDevice.current
        return device.identifierForVendor!.uuidString
    }

   
    func serverCreation(){
        do{
            let server = Server()
            server.get("/hello/{id}") { request in
                print(request.queryParams["state"])
                return .ok(request.routeParams["id"]!)
            }
            
            try server.run(port: 8000)
        }catch{
           print(error)
        }
    }
    
}


extension UIImageView{
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.2 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            UIView.animate(withDuration: 0.4, animations: {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { _ in
                // Return image view to original size
                UIView.animate(withDuration: 0.4, animations: {
                    self.transform = CGAffineTransform.identity
                })
            })
            self.image = image
        }, completion: nil)
    }
}
