//
//  ViewController.swift
//  weatherBeat
//
//  Created by Sebastian Drew on 2/6/15.
//  Copyright (c) 2015 los. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationsBtn: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var locationTitle: UINavigationItem!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var brickTamland = SWForecaster(yourKey: "632ac135d40bf56fca33fccf26f0a289")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        locationsBtn.layer.cornerRadius = 7
        loadingIndicator.startAnimating()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateWeatherUI:", name: "weatherHasUpdated", object: nil)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "translucentHeader"), forBarMetrics: UIBarMetrics.Default)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Open Sans", size: 21)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        //Gesture Recognizer for loader
        let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        weatherIcon.addGestureRecognizer(singleTap)
        
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        // Spin Loading Indicator
        loadingIndicator.startAnimating()
        brickTamland.locationManager.startUpdatingLocation()
        println("Working")
        
    }
    
    func updateWeatherUI(notification: NSNotification) {
        currentTemperature.text = brickTamland.temperatureString
        currentWeather.text = brickTamland.weatherString
        locationTitle.title = brickTamland.weatherLocation
        weatherIcon.image = UIImage(named: brickTamland.weatherIcon)
        loadingIndicator.stopAnimating()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as SavedLocationsTableViewController
        nextViewController.tempLocation = locationTitle.title
    }

}

