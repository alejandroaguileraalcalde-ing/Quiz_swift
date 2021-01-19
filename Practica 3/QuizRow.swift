//
//  QuizRow.swift
//  Practica1
//
//  Created by Pablo Barba Sabín on 10/10/2020.
//

import SwiftUI

struct QuizRow: View {
    
    var quiz: QuizItem
    @EnvironmentObject var  imageStore: ImageStore
    var body: some View {
        HStack{
            Image(uiImage: imageStore.image(url: quiz.attachment?.url))
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text(quiz.question)
            
            Spacer()
            
            VStack{
                
                
                Image(uiImage: imageStore.image(url: quiz.author?.photo?.url))
                    .resizable()
                    .frame(width: 20, height: 20)
                    .clipShape(Circle())
                
                Spacer()
            }
        }
    }
}
struct QuizRow_Previews: PreviewProvider {
    static var previews: some View {
        let p = 0
    }
}
