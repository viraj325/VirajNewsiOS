//
//  NewsObserver.swift
//  VirajNews
//
//  Created by Viraj Patel on 9/1/20.
//  Copyright © 2020 Viraj Patel. All rights reserved.
//
import Combine
import Alamofire
import Foundation
import SwiftyJSON

class NewsObserver: ObservableObject{
    @Published var newsList = [NewsModel]()
    var didChange = PassthroughSubject<Void, Never>()
    @Published var savedTopicList = [String]()

    var shouldPresentModal = false {
        didSet {
            didChange.send(())
        }
    }
    
    init() {
        getNews()
        loadList()
    }
    
    private func getNews(){
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=eda78c52fd7a4440984c6671328d2307"
        AF.request(url).responseJSON { response in
            print(response)
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let results = json["articles"].arrayValue
                    for result in results {
                        let author = result["author"].stringValue
                        let title = result["title"].stringValue
                        let description = result["description"].stringValue
                        let url = result["url"].stringValue
                        let urlToImage = result["urlToImage"].stringValue
                        let publishedAt = result["publishedAt"].stringValue
                        let content = result["content"].stringValue
                        
                        self.newsList.append(NewsModel(source: "", author: author, title: title, description: description, url: url, urlToImage: urlToImage, time: publishedAt, content: content))
                    }
                    self.shouldPresentModal.toggle()
                    break
                case .failure(let error):
                    print(error)
                    //self.getGoogleNews()
                    break
                }
        }
    }
    
    private func addTopic(topic: String){
        savedTopicList.append(topic)
        saveList()
    }
    
    private func removeTopic(topic: String){
        if let index = savedTopicList.firstIndex(of: topic) {
            savedTopicList.remove(at: index)
        }
        saveList()
    }
    
    private func saveList(){
        let defaults = UserDefaults.standard
        defaults.set(savedTopicList, forKey: "Topics")
    }
    
    private func loadList(){
        let defaults = UserDefaults.standard
        savedTopicList = defaults.stringArray(forKey: "Topics") ?? [String]()
    }
}

struct NewsModel: Identifiable{
    var id = UUID()
    var source: String
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var time: String
    var content: String
    
    init(source: String, author: String, title: String, description: String, url: String, urlToImage: String, time: String, content: String){
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.time = time
        self.content = content
    }
}
