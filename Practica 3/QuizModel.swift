//
//  QuizModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 28/09/2020.
//

import Foundation


struct QuizItem: Codable {
    let id: Int
    let question: String
    let answer: String
    let author: Author?
    let attachment: Attachment?
    var favourite: Bool
    
    struct Author: Codable {
        let isAdmin: Bool?
        let username: String?
        let profileName:String?
        let photo: Attachment?
    }
    
    struct Attachment: Codable {
        let filename: String?
        let mime: String?
        let url: URL?
    }
}


class QuizModel: ObservableObject {
       
    
    
    @Published  var quizzes = [QuizItem]()
    let session = URLSession.shared
    let urlBase = "https://core.dit.upm.es"
    let Token = "7f0191c8e78dea8f4156"
    
    func toggleFavourite(_ quizzItem: QuizItem){
        
        guard let index = quizzes.firstIndex(where:{$0.id == quizzItem.id})else{
            print("Fallo 5")
            return
        }
        
        let surl = "\(urlBase)/api/users/tokenOwner/favourites/\(quizzItem.id)?token=\(Token)"
        
        guard let url = URL(string: surl) else{
            print("Fallo 6 creando URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = quizzItem.favourite ? "DELETE" : "PUT"
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        let t = session.uploadTask(with: request, from: Data()){(data, res, error) in
            
            if error != nil{
                print("Fallo 20")
                return
            }
            
            if (res as! HTTPURLResponse).statusCode != 200 {
                print("Fallo 30")
                return
            }
            
            DispatchQueue.main.async {
                
                self.quizzes[index].favourite.toggle()
            }
            
        }
        
        
            t.resume()

    }
    
     func load() {
        
        let s = "\(urlBase)/api/quizzes/random10wa?token=\(Token)"
        guard let url = URL(string: s) else{
            print("Fallo creando URL")
            return
        }
        
        let t = session.dataTask(with: url){ (data, res, error) in
            
            if error != nil {
                print("Fallo 2")
                return
            }
            
            if (res as! HTTPURLResponse).statusCode != 200 {
                print("Fallo 3")
                return
            }
            
            let decoder = JSONDecoder()
            
            // let str = String(data: data, encoding: String.Encoding.utf8)
            // print("Quizzes ==>", str!)
            
            if let quizzes = try? decoder.decode([QuizItem].self, from: data!){
                DispatchQueue.main.async {
                    self.quizzes=quizzes
                }
                
            }
        }
        t.resume()
        
     }
     
    
}
