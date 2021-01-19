//
//  ContentView.swift
//  Practica1
//
//  Created by Pablo Barba Sabín on 08/10/2020.
//

import SwiftUI

struct ContentView: View {
    
   @EnvironmentObject var quizModel: QuizModel
    
   @EnvironmentObject var scoreModel: ScoreModel
    
    @State var showAll: Bool = true
    
    var body: some View {
        
        NavigationView{
            List{
                
                Toggle(isOn: $showAll){
                    Label("ver todo", systemImage: "list.bullet")
                }
                
                ForEach(quizModel.quizzes.indices, id: \.self) { i in
                    
                    if showAll || !scoreModel.acertado(quizModel.quizzes[i]){
                        
                        NavigationLink(destination: QuizDetail(quiz: $quizModel.quizzes[i])) {
                            QuizRow(quiz: quizModel.quizzes[i])
                            
                        }
                    }
                    
                }
                
            }
            
            .navigationTitle("P3 Quiz")
            .navigationBarItems(trailing: Button(action: {scoreModel.limpiar()}, label: {Image(systemName: "arrow.clockwise")}))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let quizModel: QuizModel = {
        let qm = QuizModel()
        return qm
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(quizModel)
    }
}
