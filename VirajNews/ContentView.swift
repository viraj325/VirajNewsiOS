//
//  ContentView.swift
//  VirajNews
//
//  Created by Viraj Patel on 9/1/20.
//  Copyright © 2020 Viraj Patel. All rights reserved.
//

import SwiftUI
import Foundation
import Combine
import struct Kingfisher.KFImage

struct ContentView: View {
    @ObservedObject var observed = NewsObserver()
    @State var showSheet = false
    @State var title: String = ""
    @State var author: String = ""
    @State var description: String = ""
    @State var timestamp: String = ""
    @State var content: String = ""
    @State var url: String = ""
    @State var urlToImage: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            Text("Viraj News")
                .font(.system(size: 25))
                .bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if(observed.shouldPresentModal){
                ForEach(observed.newsList){i in
                    KFImage(URL(string: i.urlToImage))
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .cornerRadius(20)
                        .overlay(
                            ZStack{
                                Text(i.title)
                                    .foregroundColor(Color.white)
                                    .bold()
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .background(Color.black)
                            .opacity(0.6)
                            .frame(maxWidth: .infinity, maxHeight: .infinity))
                            .cornerRadius(10.0)
                        .padding()
                    .onTapGesture {
                        self.title = i.title
                        self.author = i.author
                        self.description = i.description
                        self.timestamp = i.time
                        self.content = i.content
                        self.url = i.url
                        self.urlToImage = i.urlToImage
                        self.showSheet.toggle()
                    }
                    .sheet(isPresented: self.$showSheet){
                        ViewNewsUI(title: self.title, author: self.author, description: self.description, timestamp: self.timestamp, content: self.content, url: self.url, urlToImage: self.urlToImage)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
