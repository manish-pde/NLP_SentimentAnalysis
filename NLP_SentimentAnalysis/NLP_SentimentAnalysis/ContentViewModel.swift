//
//  ContentViewModel.swift
//  NLP_SentimentAnalysis
//
//  Created by Manish on 23/11/23.
//

import SwiftUI
import NaturalLanguage


struct MoodGroup: Identifiable {
    let id = UUID()
    let moods: [Mood]
}

struct Mood: Identifiable {
    let id = UUID()
    
    let text: String
    let sentiment: String
    
    var color: Color {
        let intVal = Decimal(string: sentiment) ?? 0
        
        if intVal <= 0.3 && intVal >= -0.3 {
            return .gray
        } else if intVal > 0.3 {
            return .green
        } else {
            return .red
        }
        
    }
}

class ContentViewModel: ObservableObject {
    
    @Published private(set) var moods = [MoodGroup]()
    
    func addMood(txt: String) {
        
        var newMoods = [Mood]()
        
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = txt
        
        tagger.enumerateTags(in: txt.startIndex..<txt.endIndex, unit: .paragraph,
                             scheme: .sentimentScore, options: []) { sentiment, range in
            
            if let sentimentScore = sentiment {
                print(txt[range])
                print(sentimentScore.rawValue)
                print("\n")
                
                newMoods.append(
                    Mood(
                        text: txt[range].description.trimmingCharacters(in: .whitespacesAndNewlines),
                        sentiment: sentimentScore.rawValue)
                )
            }
            
            return true
        }
        
        moods.append(MoodGroup(moods: newMoods))
        
    }
    
}
