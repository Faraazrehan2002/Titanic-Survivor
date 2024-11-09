//
//  ContentView.swift
//  TitanicSurvialProject
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/7/24.
//

//
//  ContentView.swift
//  TitanicSurvialProject
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/7/24.
//

import SwiftUI
import CoreML

struct MainView: View {
    
    @State private var tm: TitanicSurvivalModel = .init(
        passengerClass: "Second Class",
        sex: "Male",
        age: 22,
        siblingsSpouses: 5,
        parentsChildren: 2,
        fare: 50,
        port: "Southampton"
    )
    
    @State var survival: Bool? = nil
    
    @State private var survivalRate: Double = -1
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    // Passenger Class
                    SegmentSectionView(
                        selectedSegment: $tm.passengerClass,
                        options: TitanicSurvivalModel.passengerClassOptions,
                        sectionTitle: "Passenger Class",
                        prompt: "What is your passenger class?"
                    )
                    
                    // Sex
                    SegmentSectionView(
                        selectedSegment: $tm.sex,
                        options: TitanicSurvivalModel.sexOptions,
                        sectionTitle: "Sex",
                        prompt: "What is your sex?"
                    )
                    
                    // Age
                    SliderSectionView(
                        sliderValue: $tm.age,
                        sliderTitle: "Age",
                        prompt: "Age: \(tm.age.formatted())",
                        sliderMinValue: 0,
                        sliderMaxValue: 120,
                        sliderStep: 0.5
                    )
                    
                    // Siblings/Spouses
                    SliderSectionView(
                        sliderValue: $tm.siblingsSpouses,
                        sliderTitle: "Siblings/Spouses",
                        prompt: "Number of siblings/spouses: \(tm.siblingsSpouses.formatted())",
                        sliderMinValue: 0,
                        sliderMaxValue: 10,
                        sliderStep: 1
                    )
                    
                    // Parents/Children
                    SliderSectionView(
                        sliderValue: $tm.parentsChildren,
                        sliderTitle: "Parents/Children",
                        prompt: "Number of parents/children: \(tm.parentsChildren.formatted())",
                        sliderMinValue: 0,
                        sliderMaxValue: 20,
                        sliderStep: 1
                    )
                    
                    // Fare
                    SliderSectionView(
                        sliderValue: $tm.fare,
                        sliderTitle: "Fare",
                        prompt: "Ticket Price: £\(tm.fare.formatted())",
                        sliderMinValue: 0,
                        sliderMaxValue: 600,
                        sliderStep: 0.1
                    )
                    
                    // Port
                    SegmentSectionView(
                        selectedSegment: $tm.port,
                        options: TitanicSurvivalModel.portOptions,
                        sectionTitle: "Port",
                        prompt: "What port did you emabrk from?"
                    )
                }
                .scrollIndicators(.hidden)
                .blur(radius: showAlert ? 5: 0)
                .disabled(showAlert)
                
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
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            
                            
                        }
                    })
                }
                
            }
            
        }
        .navigationBarTitle("Titanic Survival Predictor")
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
            print(prediction)
            survivalRate = prediction.Survived
            survival = prediction.Survived > 0.5
        }catch{
            survival = nil
            print("Error: \(error.localizedDescription)")
        }
        showAlert = true
    }
}

#Preview {
    MainView()
}
