//
//  Practica1App.swift
//  Practica1
//
//  Created by Pablo Barba Sabín on 08/10/2020.
//

import SwiftUI

@main
struct Practica3App: App {
    
    let quizModel: QuizModel = {

       let qm = QuizModel()
        qm.load()
        return qm
    }()
   
    let imageStore = ImageStore()
    
    let scoreModel = ScoreModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(imageStore)
                .environmentObject(scoreModel)
                .environmentObject(quizModel)
        }
    }
}

struct Practica3App_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
