//
//  Settings.swift
//  Multiply
//
//

import SwiftUI

struct Settings: View {
    @ObservedObject var gameSettings: GameSettings
    
    var body: some View {
        Form {
            Section(header: Text("Select a range of numbers")) {
                Stepper(value: $gameSettings.upperRange, in: 2...12, step: 1) {
                    Text("Up to:")
                    Text("\(gameSettings.upperRange)")
                }
            }
            
            Section(header: Text("How many questions to be asked?")) {
                Picker("How many questions to be asked?", selection: $gameSettings.questionsIndex) {
                    let indexCount = gameSettings.questionsRange.count
                    ForEach(0 ..< indexCount) {
                        Text("\(gameSettings.questionsRange[$0])")
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Section {
                if gameSettings.questionsIndex == 3 {
                    Text("Number of questions \(12 * (gameSettings.upperRange - (gameSettings.lowerRange - 1)))")
                    
                } else {
                    Text("Number of questions \((gameSettings.questionsRange[gameSettings.questionsIndex]) )")
                }
            }
        }
        .onAppear() {
        }
    }
    func resetGame() {
        gameSettings.answers.removeAll()
        gameSettings.questions.removeAll()
        gameSettings.tallyOfPotentialQuestions = 0
    }
}


struct Settings_Previews: PreviewProvider {
    
    static var previews: some View {
        Settings(gameSettings: GameSettings())
    }
}
