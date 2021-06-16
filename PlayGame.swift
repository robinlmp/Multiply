//
//  PlayGame.swift
//  Multiply
//
//

import SwiftUI

struct PlayGame: View {
    @ObservedObject var gameSettings: GameSettings
    
    @State private var questionsAsked = 1
    @State private var randomButton = 0

    
    var body: some View {
        VStack {
            Spacer()
            Text("What is \(gameSettings.question)")
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                .padding(40)
                .background(Color.pink)
                .clipShape(Capsule())
            Spacer()
            
            
            HStack {
                Button {
                    buttonLogic(buttonNumber: 0)
                } label: {
                    Text(buttonLabel(buttonNumber: 0))
                        .font(.title)
                        .bold()
                        .animation(.easeOut)
                        .frame(width: 120, height: 120)
                        .background(Color.blue)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding()
                }
                
                
                Button {
                    buttonLogic(buttonNumber: 1)
                } label: {
                    Text(buttonLabel(buttonNumber: 1))
                        .font(.title)
                        .bold()
                        .animation(.easeOut)
                        .frame(width: 120, height: 120)
                        .background(Color.red)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            
            HStack {
                Button {
                    buttonLogic(buttonNumber: 2)
                } label: {
                    Text(buttonLabel(buttonNumber: 2))
                        .font(.title)
                        .bold()
                        .animation(.easeOut)
                        .frame(width: 120, height: 120)
                        .background(Color.green)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button {
                    buttonLogic(buttonNumber: 3)
                } label: {
                    Text(buttonLabel(buttonNumber: 3))
                        .font(.title)
                        .bold()
                        .animation(.easeOut)
                        .frame(width: 120, height: 120)
                        .background(Color.yellow)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            Spacer()
            Text("score is \(gameSettings.score)")
                .bold()
            Spacer()
        }
        .onAppear() {
            print("totalQuestions on appear \(gameSettings.totalQuestions)")
            playSetUp()
        }
        
    }
    
    func playSetUp() {
        let randomNum = Int.random(in: 0 ..< (gameSettings.tallyOfPotentialQuestions))
        gameSettings.tallyOfPotentialQuestions -= 1
        gameSettings.answer = gameSettings.answers[randomNum]
        gameSettings.answers.remove(at: randomNum)
        gameSettings.question = gameSettings.questions[randomNum]
        gameSettings.questions.remove(at: randomNum)


        
        randomButton = Int.random(in: 0...3)
    }
    
    func buttonLogic(buttonNumber: Int) {
        if questionsAsked < gameSettings.totalQuestions && randomButton == buttonNumber {
            gameSettings.score += 1
        } else if questionsAsked < gameSettings.totalQuestions && randomButton != buttonNumber {
            gameSettings.score -= 1
        } else if questionsAsked == gameSettings.totalQuestions && randomButton == buttonNumber {
            gameSettings.score += 1
            gameSettings.playGame.toggle()
        } else {
            gameSettings.score -= 1
            gameSettings.playGame.toggle()
        }
        questionsAsked += 1
        playSetUp()
        
    }
    
    func buttonLabel(buttonNumber: Int) -> String {
        if questionsAsked <= gameSettings.totalQuestions && randomButton == buttonNumber  {
            return ("\(gameSettings.answer)")
        } else if questionsAsked <= gameSettings.totalQuestions && randomButton != buttonNumber {
            print("\(gameSettings.answer)")
            var rand = Int.random(in: 1 ... ((gameSettings.answer + 1) * 2 - 1))
            if rand == gameSettings.answer {
                rand += 1
                return ("\(rand)")
            }
            return ("\(rand)")
        } else {
            return ("")
        }
    }
    
    
    
}


struct PlayGame_Previews: PreviewProvider {
    
    static var previews: some View {
        PlayGame(gameSettings: GameSettings())
    }
}
