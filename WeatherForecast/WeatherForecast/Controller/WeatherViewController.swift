//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Marlon Junior🦈⚓️ on 02/11/21.
//

import UIKit

class WeatherViewController : UIViewController {

    @IBOutlet weak var temperarureCBurtton: UIButton!
    @IBOutlet weak var temperatureFButton: UIButton!
    @IBOutlet weak var temperatureKButton: UIButton!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var grausMetric: UILabel!
    @IBOutlet weak var metricLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    var celsiusValue : String?
    var fareheintValue : String?
    var kelvinValue : String?
    var weatherManager = WeatherManager();
    
override func viewDidLoad() {
        super.viewDidLoad()
    weatherManager.delegate = self
    searchTextField.delegate = self
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
        weatherManager.fetchWeather(cityName:city)
        }
        searchTextField.text = ""
    }
    
}

//MARK: -  WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate{
    
    func didUpdateWeather(_ WeatherManager: WeatherManager , weather : WeatherModel){
        DispatchQueue.main.async {
            self.weatherImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.celsiusValue = weather.temperatureString
            self.fareheintValue = String(format: "%.1f",(weather.temperature * (9/5)) + 32)
            self.kelvinValue = String(format: "%.1f",weather.temperature + 273.15)
            self.temperatureMetric()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - Metrics Optinos
extension WeatherViewController {
    @IBAction func metricPresed(_ sender: UIButton) {
        temperarureCBurtton.isSelected = false
        temperatureFButton.isSelected = false
        temperatureKButton.isSelected = false
        sender.isSelected = true
        temperatureMetric()
    }

    
    func temperatureMetric(){
        if temperarureCBurtton.isSelected{
            print()
            self.temperatureLabel.text = celsiusValue
            grausMetric.text = "º"
            metricLabel.text = "C"
        }
        if temperatureFButton.isSelected{
            self.temperatureLabel.text = fareheintValue
            grausMetric.text = "º"
            metricLabel.text = "F"
        }
        if temperatureKButton.isSelected{
            self.temperatureLabel.text = kelvinValue
            grausMetric.text = ""
            metricLabel.text = "K"
        }
    }
    
    
}
