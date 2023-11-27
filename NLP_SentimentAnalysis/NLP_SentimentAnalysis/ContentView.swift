//
//  ContentView.swift
//  NLP_SentimentAnalysis
//
//  Created by Manish on 23/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewmodel = ContentViewModel()
    
    @State private var inputStr = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(viewmodel.moods) { moodItem in
                ForEach(moodItem.moods) { mood in
                    Text(mood.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(mood.color)
                }
                
                Divider()
            }
            
            Spacer()
            
            HStack {
                TextEditor(text: $inputStr)
                    .frame(height: 50)
                
                Button {
                    viewmodel.addMood(txt: inputStr)
                    inputStr = ""
                } label: {
                    Text("Add")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
