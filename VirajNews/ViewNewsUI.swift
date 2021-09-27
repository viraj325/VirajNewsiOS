//
//  ViewNewsUI.swift
//  VirajNews
//
//  Created by Viraj Patel on 9/4/20.
//  Copyright © 2020 Viraj Patel. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ViewNewsUI: View {
    @Environment(\.presentationMode) var presentation
    
    var title: String = ""
    var author: String = ""
    var description: String = ""
    var timestamp: String = ""
    var content: String = ""
    var url: String = ""
    var urlToImage: String = ""
    
    init(title: String, author: String, description: String, timestamp: String, content: String, url: String, urlToImage: String){
        self.title = title
        self.author = author
        self.description = description
        self.timestamp = timestamp
        self.content = content
        self.url = url
        self.urlToImage = urlToImage
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack{
                Text(title)
                    .font(.title)
                    .bold()
                    .lineLimit(nil)
                    .padding()
                
                KFImage(URL(string: urlToImage))
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .cornerRadius(20)
                    .padding()
                
                Text(description)
                    .font(.callout)
                    .lineLimit(nil)
                    .padding()
                
                Text(content)
                    .foregroundColor(Color.gray)
                    .lineLimit(nil)
                    .padding()
                
                Text(url)
                    .font(.caption)
                    .textContentType(.URL)
                    .lineLimit(nil)
                    .foregroundColor(Color.blue)
                    .padding()
                    .onTapGesture {
                        let urlvar = URL.init(string: self.url)
                        guard let stackOverflowURL = urlvar, UIApplication.shared.canOpenURL(stackOverflowURL) else { return }
                        UIApplication.shared.open(stackOverflowURL)
                    }
                
                Text(timestamp)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .lineLimit(nil)
                    .padding()
            }
        }
    }
}

struct ViewNewsUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewNewsUI(title: "", author: "", description: "", timestamp: "", content: "", url: "", urlToImage: "")
    }
}
