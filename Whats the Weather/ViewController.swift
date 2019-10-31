//
//  ViewController.swift
//  Whats the Weather
//
//  Created by Ryan Schefske on 1/30/18.
//  Copyright © 2018 Ryan Schefske. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func getWeather(_ sender: Any) {
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            if let error = error {
                print(error)
            } else {
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                print(message)
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if message == "" {
                
                message = "The weather there couldn't be found. Please try again."
                
            }
            DispatchQueue.main.sync(execute: {
                
                self.outputLabel.text = message
                
            })
        }
        task.resume()
        
    } else {
    outputLabel.text = "The weather there couldn't be found. Please try again."
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

