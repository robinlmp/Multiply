//
//  ContentView.swift
//  Multiply
//
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var lowerRange = 2
    @Published var upperRange = 10
    @Published var questionsIndex = 1
    @Published var questionsRange = ["5", "10", "20", "All"]
    @Published var totalQuestions: Int = 10
    @Published var questionsAsked: Int = 0
    @Published var questions = [String]()
    @Published var question = String()
    @Published var answers = [Int]()
    @Published var answer = Int()
    @Published var tallyOfPotentialQuestions = 0
    @Published var score = 0
    @Published var playGame = false
}

struct ContentView: View {
    @StateObject var gameSettings = GameSettings()
    
    
    var body: some View {
        NavigationView {
            VStack{
                if gameSettings.playGame == true {
                    PlayGame(gameSettings: gameSettings)
                } else {
                    Settings(gameSettings: gameSettings)
                    Spacer()
                    Text("You scored \(gameSettings.score)")
                        .font(.largeTitle)
                        .opacity(gameSettings.score > 1 ? 1.0 : 0.0)
                    Text("Play again?")
                        .font(.title)
                        .opacity(gameSettings.score > 1 ? 1.0 : 0.0)
                    Spacer()
                }
                Spacer()
                Button {

                    
                    if gameSettings.playGame == false {
                        resetGame()
                        calculateQuestions()
                        print("questions\(gameSettings.questions)")
                        print("answers\(gameSettings.answers)")
                        print("tallyOfPotentialQuestions\(gameSettings.tallyOfPotentialQuestions)")
                        
                        if gameSettings.questionsIndex < 3 {
                            gameSettings.totalQuestions = Int(gameSettings.questionsRange[gameSettings.questionsIndex]) ?? 10
                        } else {
                            gameSettings.totalQuestions = (gameSettings.upperRange * 12) - 12
                        }
                        
                    }
                    gameSettings.playGame.toggle()
                    
                } label: {
                    if gameSettings.playGame == true {
                        Text("Return to the settings")
                            .bold()
                            .frame(minWidth: 250)
                            .padding(20)
                            .background(Color.secondary)
                            .clipShape(Capsule())
                            .foregroundColor(.primary)
                            
                    } else {
                        Text("PLAY!")
                            .bold()
                            .frame(minWidth: 250)
                            .padding(20)
                            .background(Color.secondary)
                            .clipShape(Capsule())
                            .foregroundColor(.primary)
                            
                    }
                    
                }
            }
            .navigationTitle("Multiply")
        }
    }
    
    func resetGame() {
        gameSettings.answers.removeAll()
        gameSettings.questions.removeAll()
        gameSettings.tallyOfPotentialQuestions = 0
        gameSettings.score = 0

    }
    
    func calculateQuestions() {
        for x in gameSettings.lowerRange ... gameSettings.upperRange {
            for y in 1 ... 12 {
                gameSettings.answers.append(x * y)
                gameSettings.questions.append("\(x) x \(y)")
                gameSettings.tallyOfPotentialQuestions += 1
            }
        }
        
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
