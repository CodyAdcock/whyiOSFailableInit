//
//  PostController.swift
//  whyiOS
//
//  Created by Cody on 9/5/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
class PostController {
    
    var posts: [Post] = []
    let baseURL = URL(string: "https://whydidyouchooseios.firebaseio.com/reasons")
    
    func fetchPosts(completion: @escaping (_ success: Bool) -> Void){
        guard let url = baseURL else {fatalError("Bad baseURL on fetch")}
        let builtUrl = url.appendingPathExtension("json")
        var request = URLRequest(url: builtUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("🤮 Error Fetching with data task: \(error) \(error.localizedDescription)")
                completion(false); return
            }
            do{
                let jsonDecoder = JSONDecoder()
                guard let data = data else {completion(false); return}
                let postsDictionary = try jsonDecoder.decode([String : Post].self, from: data)
                let posts = postsDictionary.compactMap({$0.value})
                self.posts = posts
                completion(true)
            }catch let error{
                print("🤮Error Decoding Post: \(error) \(error.localizedDescription)")
                completion(false); return
            }
            }.resume()
    }
    
    func putPost(name: String, reason: String, completion: @escaping (_ success: Bool) -> Void){
        let post = Post(name: name, reason: reason)
        guard let url = baseURL else {fatalError("bad baseURL")}
        let builtURL = url.appendingPathComponent(post.uuid).appendingPathExtension("json")
        var request = URLRequest(url: builtURL)
        
        let jsonEncoder = JSONEncoder()
        do{
            let data = try jsonEncoder.encode(post)
            request.httpMethod = "PUT"
            request.httpBody = data
        }catch let error {
            print("🤮 Error putting with data task: \(error) \(error.localizedDescription)")
            completion(false); return
        }
        
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("🤮 Error Fetching with data task: \(error) \(error.localizedDescription)")
                completion(false); return
            }
            //for me
            guard let data = data,
                let responseString = String(data: data, encoding: .utf8) else {completion(false); return}
            print(responseString)
            
            //connect the local array to the instances in the cloud or wherever
            self.posts.append(post)
            completion(true)
        }.resume()
    }
}
