//: Playground - noun: a place where people can play

import UIKit

let session = URLSession(configuration: .default)
if let url = URL(string: "https://www-media.stanford.edu/wp-content/uploads/2017/03/24182714/about_landing-1.jpg") {
    
    
    let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
        
        DispatchQueue.main.async {
            
            
            
            
            
        }
        
        
        
    })
    
    task.resume()
    
    
}