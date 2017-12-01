//
//  ViewController.swift
//  URLSession-Practice
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nasaImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var nasaObject: NASAObject? {
        didSet {
            if let nasaObject = nasaObject {
                self.titleLabel.text = nasaObject.title
                let url = nasaObject.hdUrlString ?? nasaObject.urlString
                loadImage(from: url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    }
    
    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        let selectedDate = datePicker.date
        let longDescription = selectedDate.description
        let ymd = longDescription.components(separatedBy: " ")[0]
        
        loadObject(for: ymd)
    }
    
    func loadObject(for YMD: String) {
        let key = "9ZYwVaMFnyAPYOm4yy8djSZkhMtuT69QGURFd6km"
        
        let urlString = "https://api.nasa.gov/planetary/apod?date=\(YMD)&api_key=\(key)"
        
        //We commented this part out because we replaced it with network helper - with network helper, we can avoid all this
        
//        guard let url = URL(string: urlString) else {
//            return
//        }
        
        
//        //1. Initialize an instance of URLSession - you can give a configuration or make a new instance
//
//        let mySession = URLSession(configuration: .default)
//
//        //2. Define the completion handler of the .dataTask method (after it completes getting data from internet, completion handler is how you would handle the data (or error) it got
//
//            //assign the .dataTask method to a variable
//        let completion: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
//
//            //3. Unwrap the data safely
//            guard let data = data else {
//                return
//            }
//
//            //4. if there is an error, print it
//            if let error = error {
//                print(error)
//                return
//            }
//
//            //5. Use the json data and transform it to a Nasa object
//            do {
//                let onlineNasaObject = try JSONDecoder().decode(NASAObject.self, from: data)
//                //if we want to change any UI elements, we have to make sure it happens in the main queue - else the changes will not show up in the UI
//                self.nasaObject = onlineNasaObject
//            } catch let error {
//                print(error)
//            }
//        }
//
//        let myTask = mySession.dataTask(with: url, completionHandler: completion)
//
//        myTask.resume()
        
        //instead of writing out a completion handler to convert data to a nasa object here - it would make more sense to make another api client model that converts data to a nasa object FOR YOU
            //this means you won't have to write out the code to convert data multiple times in multiple view controllers
            //you could just call the apiclient method, give it a url or string, and then it'll give you the object for you

        NASAObjectAPIClient.manager.getNASAObject(
            from: urlString,
            completionHandler: { (onlineNasaObject) in
                self.nasaObject = onlineNasaObject
        },
            errorHandler: { (error) in
                //how to use alert controller - presents an alert message
                    //1. Initialize an instance of an alertController
                    //2. Pass in arguments for:
                        //a. title (string) - the title of the alert
                        //b. message (string) - the message of the alert
                        //c. preferredStyle (enum) - how the alertController will present
                let alertController = UIAlertController(title: "Error", message: "An error occurred: \(error)", preferredStyle: UIAlertControllerStyle.alert)
                
                //3. Add an action button to the alert controller - we need this to add an "okay" button to the alert view
                    //alert controllers have alert actions (UIAlertAction)
                    //a. instantiate a new instance of an alert action
                //it has three parameters:
                    //1. title (string) - the text you want your alert action to display
                    //2. style (enum) - alert actions have multiple styles you can choose from
                    //3. handler (closure) - a completion handler - we can just put nil
                
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                
                //add the action button to alert controller
                alertController.addAction(alertAction)
                
                //4. Make the current view controller present another view controller modally (overlays the new view controller's view on top without actually seguing)
                    //the completion parameter is a completion handler that takes in an optional closure - this closure basically should consist of code that you want to execute AFTER the present function returns (completes)
                    //this closure is optional, so since we don't need to run anything after it presents, we can just pass in "nil"
                self.present(alertController, animated: true, completion: nil)
        })
        
    }
    
    
    func loadImage(from urlStr: String) {
        spinner.startAnimating()
        spinner.isHidden = false
        //can load any image
        
        //when load images - sometimes you can convert a url to data, and then use the UIImage(data:_) to get an image, like so:
            //Data(contentsOf: URL)
        //but this isn't as good as using dataTask because it gives you more parameters: response and error
        
        //url request vs url
            //url - just for get requests
            //url request - if you want a post request, you might need to - go to url and tell it to make changes to the API, so you need to include additional information in your url request when making an http request
            //for now, url is good enough for what we need
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        //With network helper, we can avoid all of this
        
        //We did the below part first, and then commented it out to use the network helper instead
//        //1. Initialize instance of URLSession with default configuration
//        let mySession = URLSession(configuration: .default)
//
//        //2. Call the dataTask method on your instanct of URLSession
//        let myTask = mySession.dataTask(with: url) { (data, response, error) in
//
//            //3. Pass in a closure for the completion handler - what you want to happen after the network request is complete
//            guard let data = data else {
//                self.spinner.stopAnimating()
//                self.spinner.isHidden = true
//                return
//            }
//
//            if let error = error {
//                print(error)
//                self.spinner.stopAnimating()
//                self.spinner.isHidden = true
//                return
//            }
//
//            guard let onlineImage = UIImage(data: data) else {
//                self.spinner.stopAnimating()
//                self.spinner.isHidden = true
//                return
//            }
//
//            //UI CHANGES MUST BE MADE IN THE MAIN QUEUE!!
//            //4. Make UI changes with the data obtained in the MAIN QUEUE!!
//            DispatchQueue.main.async {
//                self.nasaImageView.image = onlineImage
//                self.spinner.stopAnimating()
//                self.spinner.isHidden = true
//            }
//
//        }
//
//        //5. Start the task (the steps above only defined the task, not start it) - ben said resume is a bad name lol, it really just means start the task
//        myTask.resume()
        
        let completion: (Data) -> Void = { (data) in
            
            self.nasaImageView.image = UIImage(data: data)
            self.nasaImageView.setNeedsLayout()
            self.spinner.isHidden = true
        }
        
        let error: (Error) -> Void = { (error) in
            self.nasaImageView.image = nil
            self.spinner.isHidden = true
            print(error)
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: error)

    }
    
    
    
}

