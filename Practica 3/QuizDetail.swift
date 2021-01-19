//
//  QuizDetail.swift
//  Practica1
//
//  Created by Pablo Barba Sabín on 10/10/2020.
//

import SwiftUI

struct QuizDetail: View {
    
    
    @State var respuesta: String = ""
    
    @State var muestraAlerta:Bool = false
    
    @State var muestraRespuesta:Bool = false
    
    @EnvironmentObject var scoreModel: ScoreModel
    
    @EnvironmentObject var quizModel: QuizModel
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @Binding var quiz: QuizItem
    @EnvironmentObject var imageStore: ImageStore
    var body: some View {
        //Esto es lo que hace si está en vertical
        if verticalSizeClass != .compact{
        
        VStack{
            
            HStack{
                
                Text(quiz.question)
                    .font(.largeTitle)
                
                
                
                Button(action: {
                    
                    self.quizModel.toggleFavourite(quiz)
                    
                }){
                    Image(quiz.favourite ? "red_heart" : "grey_heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .scaledToFit()
                }
                
            }
            
            Spacer()
            
            
             
            
            TextField("Introduzca su respuesta", text: $respuesta, onEditingChanged: {b in}, onCommit: {
                
                scoreModel.check(respuesta: respuesta, quiz: quiz)
                muestraAlerta = true
            })
            
            .alert(isPresented: $muestraAlerta){
                let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                
                return Alert(title: Text("Resultado"), message: Text(r1 == r2 ? "Correcto ✅": "Mal ❌"), dismissButton: .default(Text("Ok")))
            }
            
            
            Spacer()
            
            Image(uiImage: imageStore.image(url: quiz.attachment?.url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius:20)
                .animation(.easeInOut)
            
            Spacer()
            
            
            
            HStack{
                
                Label("\(scoreModel.acertadas.count)", systemImage: "star.fill")
                
                //Text("  Puntos = \(scoreModel.acertadas.count)")
                //.font(.headline)
                
                Spacer()
                
                Button("Solución  ", action: {
                    
                    scoreModel.check(respuesta: respuesta, quiz: quiz)
                    muestraRespuesta = true
                })
                .alert(isPresented: $muestraRespuesta){
                    let r2 = quiz.answer
                    
                    return Alert(title: Text("Solución"), message: Text("La respuesta correcta es: \(r2)"), dismissButton: .default(Text("Ok")))
                }
                
                
                
                
            }
            
            
            
            
        }
        
        
    }
        else{
            VStack{
                
                HStack{
                
                Text(quiz.question)
                    .font(.largeTitle)
                    
                    Button(action: {
                        
                        self.quizModel.toggleFavourite(quiz)
                        
                    }){
                        Image(quiz.favourite ? "red_heart" : "grey_heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                    }
                    
                }
                
                Spacer()
                
                HStack{
                    
                    VStack{
                        
                        TextField("Introduzca su respuesta", text: $respuesta, onEditingChanged: {b in}, onCommit: {
                            
                            scoreModel.check(respuesta: respuesta, quiz: quiz)
                            muestraAlerta = true
                        })
                        
                        .alert(isPresented: $muestraAlerta){
                            let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                            let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            return Alert(title: Text("Resultado"), message: Text(r1 == r2 ? "Correcto ✅": "Mal ❌"), dismissButton: .default(Text("Ok")))
                        }
                        
                        Spacer()
                        
                        HStack{
                            
                            Label("\(scoreModel.acertadas.count)", systemImage: "star.fill")
                            
                            //Text("  Puntos = \(scoreModel.acertadas.count)")
                            //.font(.headline)
                            
                            Spacer()
                            
                            Button("Solución  ", action: {
                                
                                scoreModel.check(respuesta: respuesta, quiz: quiz)
                                muestraRespuesta = true
                            })
                            .alert(isPresented: $muestraRespuesta){
                                let r2 = quiz.answer
                                
                                return Alert(title: Text("Solución"), message: Text("La respuesta correcta es: \(r2)"), dismissButton: .default(Text("Ok")))
                            }
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    Spacer()
                    
                    Image(uiImage: imageStore.image(url: quiz.attachment?.url))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius:20)
                        .animation(.easeInOut)
                }
            }
        }
        
    }
}

struct QuizDetail_Previews: PreviewProvider {
    static var previews: some View {
        let p = 0
    }
}
