//
//  SegmentSectionView.swift
//  TitanicSurvialProject
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/8/24.
//

import SwiftUI

struct SegmentSectionView: View {
    
    @Binding var selectedSegment: String
    
    let options: [String]
    
    let sectionTitle: String
    
    let prompt: String
    
    var body: some View {
        Section(sectionTitle){
            Text(prompt)
                .fontWeight(.semibold)
            
            Picker(prompt, selection: $selectedSegment){
                ForEach(options, id: \.self){
                    currentSelected in
                        Text(currentSelected).tag(currentSelected)
                }
            }
        }.pickerStyle(.segmented)
    }
}

#Preview {
    Form {
        SegmentSectionView(
            selectedSegment: .constant("Second Class"),
            options: TitanicSurvivalModel.passengerClassOptions,
            sectionTitle: "Passenger Class",
            prompt: "What is your passenger class?"
        )
        
        SegmentSectionView(
            selectedSegment: .constant("Port"),
            options: TitanicSurvivalModel.portOptions,
            sectionTitle: "Port",
            prompt: "What port did you emabrk from?"
        )

    }
}
