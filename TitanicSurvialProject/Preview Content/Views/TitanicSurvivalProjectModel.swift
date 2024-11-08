//
//  TitanicSurvivalProjectModel.swift
//  TitanicSurvialProject
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/8/24.
//

import Foundation

struct TitanicSurvivalProjectModel: Identifiable{
    
    let id = UUID()
    
    var passengerClass: String
    var sex: String
    var age: Double
    var siblingsSpouses: Double
    var parentsChildren: Double
    var fare: Double
    var port: String
    
    static let passengerClassOptions: [String] = ["First Class", "Second Class", "Third Class"]
    static let portOptions = ["Cherbourg", "Queenstown", "Southampton"]
    static let sexOptions = ["Male", "Female"]
    
    var pClass: Int64{
        switch passengerClass{
            case "FirstClass": return 1
            case "SecondClass": return 2
            case "ThirdClass": return 3
            default: return 0
        }
    }
    
    
    
}
