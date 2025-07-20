//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        // Do any additional setup after loading the view.
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(searchTextField.text != ""){
            return true
        }else{
            textField.placeholder = "Type Something Here"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = " "
    }
}
// MARK: - WeatherManagerDelegate

extension WeatherViewController: weatherManagerDelegate {
    func didUpdateWeather(_ WeatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            // will give error - updating ui from completion handeler
            // if network is low user think the app froze but so we are using dispatch queue
            
            //(_ WeatherManager: WeatherManager, weather: WeatherModel) also updated in protocol
            self.conditionImageView.image = UIImage(
                systemName: weather.conditionName
            )
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

