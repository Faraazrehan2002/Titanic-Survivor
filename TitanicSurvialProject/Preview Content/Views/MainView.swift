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
            SliderSectionView(
                sliderValue: $tm.age,
                prompt: "Age: \(tm.age.formatted())",
                sliderTitle: "Age",
                sliderMinValue: 0,
                sliderMaxValue: 120,
                sliderStep: 0.5
            )
            
            // Siblings/Spouses
            SliderSectionView(
                sliderValue: $tm.siblingsSpouses,
                prompt: "Number of siblings/spouses: \(tm.siblingsSpouses.formatted())",
                sliderTitle: "Siblings/Spouses",
                sliderMinValue: 0,
                sliderMaxValue: 10,
                sliderStep: 1
            )
            
            // Parents/Children
            SliderSectionView(
                sliderValue: $tm.parentsChildren,
                prompt: "Number of parents/children: \(tm.parentsChildren.formatted())",
                sliderTitle: "Parents/Children",
                sliderMinValue: 0,
                sliderMaxValue: 20,
                sliderStep: 1
            )
            
            // Fare
            SliderSectionView(
                sliderValue: $tm.fare,
                prompt: "Ticket Price: £\(tm.fare.formatted())",
                sliderTitle: "Fare",
                sliderMinValue: 0,
                sliderMaxValue: 600,
                sliderStep: 0.1
            )
            
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
