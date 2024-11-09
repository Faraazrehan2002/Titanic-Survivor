//
//  ContentView.swift
//  TitanicSurvialProject
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/7/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var tm: TitanicSurvivalProjectModel = .init(
        passengerClass: "Second Class",
        sex: "Male",
        age: 22,
        siblingsSpouses: 5,
        parentsChildren: 2,
        fare: 50,
        port: "Southampton"
    )
    
    var body: some View {
        Form {
            // Passenger Class
            SegmentSectionView(
                selectedSegment: $tm.passengerClass,
                options: TitanicSurvivalProjectModel.passengerClassOptions,
                sectionTitle: "Passenger Class",
                prompt: "What is your passenger class?"
            )
            
            // Sex
            SegmentSectionView(
                selectedSegment: $tm.sex,
                options: TitanicSurvivalProjectModel.sexOptions,
                sectionTitle: "Sex",
                prompt: "What is your sex?"
            )
            
            // Age
            Section("Age"){
                Text("What is your age?")
            }
            
            // Siblings/Spouses
            Section("Siblings/Spouses"){
                Text("Number of siblings/spouses")
            }
            
            // Parents/Children
            Section("Parents/Children"){
                Text("Number of parents/children")
            }
            
            // Fare
            Section("Fare"){
                Text("Ticket Price")
            }
            
            // Port
            SegmentSectionView(
                selectedSegment: $tm.port,
                options: TitanicSurvivalProjectModel.portOptions,
                sectionTitle: "Port",
                prompt: "What port did you emabrk from?"
            )
        }
        
    }
}

#Preview {
    MainView()
}
