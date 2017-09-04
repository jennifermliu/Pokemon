//
//  ViewController.swift
//  Pokemon
//
//  Created by Jennifer Liu on 9/3/17.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    var listPokemon = [Pokemons]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadPokemons()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.8, longitude: -122.4, zoom: 13)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        self.mapView.delegate = self
        
        
        //get user location
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Tap at-> \(coordinate.latitude), longitude: \(coordinate.longitude)")
    }

    var myLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        myLocation = manager.location!.coordinate
        print("myLocation:\(myLocation)")
        
        self.mapView.clear()
        
        let markerMe = GMSMarker()
        
        markerMe.position = CLLocationCoordinate2D(latitude: myLocation.latitude, longitude: myLocation.longitude)
        markerMe.title = "Me"
        markerMe.snippet = " here is my location"
        markerMe.icon = UIImage(named:"Mario")
        markerMe.map = self.mapView
        
        //show Pokemons
        var index = 0
        for Pokemons in listPokemon{
            
            if Pokemons.isCatch == false {
                let markerMe = GMSMarker()
                markerMe.position = CLLocationCoordinate2D(latitude: Pokemons.latitude!, longitude:Pokemons.longitude!)
                markerMe.title = Pokemons.name!
                markerMe.snippet = "\(Pokemons.destination!), power \(Pokemons.power!)"
                markerMe.icon = UIImage(named:Pokemons.image!)
                markerMe.map = self.mapView
                
                if(Double(myLocation.latitude).roundTo(places: 4) == Double(Pokemons.latitude!).roundTo(places: 4) &&  Double(myLocation.longitude).roundTo(places: 4) == Double(Pokemons.longitude!).roundTo(places: 4)){
                    listPokemon[index].isCatch = true
                    alertDialog(pokemonPower: Pokemons.power!)
                }
            }
            index = index + 1
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 15)
        self.mapView.camera = camera
        
    }
    
    var playerPower = 0.0
    func loadPokemons(){
        self.listPokemon.append(Pokemons(latitude: 37.7889994893035, longitude: -122.401846647263, image: "Charmander", name: "Charmander", destination: "Charmander", power: 55))
        self.listPokemon.append(Pokemons(latitude: 37.7849568502667, longitude: -122.410494089127, image: "Squirtle", name: "Squirtle", destination: "Squirtle", power: 35))
        self.listPokemon.append(Pokemons(latitude: 37.7816621152613, longitude: -122.41225361824, image: "Bulbasaur", name: "Bulbasaur", destination: "Bulbasaur", power: 65))
    }
    
    func alertDialog(pokemonPower: Double){
        playerPower = playerPower + pokemonPower
        let alert = UIAlertController(title: "Catched new Pokemon", message: "Your new power is \(playerPower)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in print("+ one")}))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension Double{
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



