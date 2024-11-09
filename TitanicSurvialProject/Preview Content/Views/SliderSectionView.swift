//
//  SliderSectionView.swift
//  TitanicSurvialProject
//
//  Created by Faraaz Rehan Junaidi Mohammed on 11/8/24.
//

import SwiftUI

struct SliderSectionView: View {
    
    @Binding var sliderValue: Double
    
    let prompt: String
    
    let sliderTitle: String
    
    let sliderMinValue: Double
    
    let sliderMaxValue: Double
    
    let sliderStep: Double
    
    var body: some View {
        Section(sliderTitle){
            Text(prompt)
                .fontWeight(.semibold)
            
            Slider(value: $sliderValue, in: sliderMinValue...sliderMaxValue, step: sliderStep)
        }
        
    }
}

#Preview {
    Form{
        SliderSectionView(
            sliderValue: .constant(5),
            prompt: "Number of parents/children",
            sliderTitle: "Parents/Children",
            sliderMinValue: 0,
            sliderMaxValue: 20,
            sliderStep: 1
        )
    }
}
