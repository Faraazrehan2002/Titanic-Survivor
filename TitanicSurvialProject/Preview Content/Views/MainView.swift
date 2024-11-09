//
//  ContentView.swift
//  TitanicSurvialProject
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/7/24.
//

import SwiftUI
import CoreML

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
    
    @State private var survival: Bool? = nil
    
    @State private var survivalRate: Double = -1
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                
                if showAlert{
                    Button(action: {
                        withAnimation{
                            showAlert.toggle()
                        }
                    }, label: {
                        if let survival{
                            VStack{
                                Text(survival ? "Survived": "Did not survive")
                                
                                Text("Probability of Survival: \(survivalRate.formatted())")
                            }
                        }
                    })
                }
                
            }
            .navigationBarTitle("Titanic Survival Predictor", displayMode: .inline)
        }
        .toolbar{
            ToolbarItem(placement: .bottomBar){
                Button(action: estimateSurvival, label: {
                    Text("Estimate Survival").bold()
                        .foregroundColor(.blue)
                        .opacity(showAlert ? 0 : 1)
                })
            }
        }
        
    }
    
    func estimateSurvival(){
        do{
            let config = MLModelConfiguration()
            let model = try TitanicSurvivalProjectModel_1(configuration: config)
            let prediction = try model.prediction(
                Pclass: tm.pClass,
                Sex: tm.sex,
                Age: tm.age,
                SibSp: Int64(tm.siblingsSpouses),
                Parch: Int64(tm.parentsChildren),
                Fare: tm.fare,
                Embarked: String(tm.port.first ?? "S")
                
            )
            
            survivalRate = prediction.Survived
            survival = prediction.Survived > 0.5
        }catch{
            survival = nil
        }
        showAlert = true
    }
}

#Preview {
    MainView()
}
