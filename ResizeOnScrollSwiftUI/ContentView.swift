//
//  ContentView.swift
//  ResizeOnScrollSwiftUI
//
//  Created by Max Valek on 4/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Home View

struct Home: View {
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                
                Text("Album Songs")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            // since top edge is ignored
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color.white.shadow(color: Color.black.opacity(0.18), radius: 5, x: 0, y: 5))
            // set top title z index to 0
            .zIndex(0)
            
            GeometryReader { mainView in
                
                ScrollView {
                    
                    VStack(spacing: 15) {
                        
                        ForEach(albums, id: \.album_name) { album in
                            // album view
                            
                            GeometryReader { item in
                                
                                AlbumView(album: album)
                                    .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY))
                                
                            }
                            // default frame height
                            // each card height is 100
                            .frame(height: 100)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)
                }
                // set scrollview z index to 1
                .zIndex(1)
            }
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.top)
    }
    
    // simple calculation for scaling effect
    
    func scaleValue(mainFrame: CGFloat, minY: CGFloat) -> CGFloat {
        
        // reducing top padding for vstack
        
        let scale = (minY - 25) / mainFrame
        
//        print(scale)
        
        // return scaling value to album view if its less than 1
        if scale > 1 {
            
            return 1
            
        } else {
            
            return scale
            
        }
    }
}


// MARK: - Album View/Row

struct AlbumView: View {
    
    var album: Album
    
    var body: some View {
        
        HStack {
            
            Image(album.album_cover)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text(album.album_name)
                    .fontWeight(.bold)
                
                Text(album.album_author)
            }
            .padding(.leading, 10)
            
            Spacer(minLength: 0)
        }
        .background(Color.white.shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 4))
        .cornerRadius(15)
    }
}


// MARK: - Sample data

struct Album {
    var album_name: String
    var album_author: String
    var album_cover: String
}

var albums = [
    Album(album_name: "name1", album_author: "artist", album_cover: "p1"),
    Album(album_name: "name2", album_author: "artist", album_cover: "p2"),
    Album(album_name: "name3", album_author: "artist", album_cover: "p3"),
    Album(album_name: "name4", album_author: "artist", album_cover: "p4"),
    Album(album_name: "name5", album_author: "artist", album_cover: "p5"),
    Album(album_name: "name6", album_author: "artist", album_cover: "p6"),
    Album(album_name: "name7", album_author: "artist", album_cover: "p7"),
    Album(album_name: "name8", album_author: "artist", album_cover: "p8"),
    Album(album_name: "name9", album_author: "artist", album_cover: "p9"),
    Album(album_name: "name10", album_author: "artist", album_cover: "p10"),
    Album(album_name: "name11", album_author: "artist", album_cover: "p11"),
    Album(album_name: "name12", album_author: "artist", album_cover: "p12"),
    Album(album_name: "name13", album_author: "artist", album_cover: "p13"),
    Album(album_name: "name14", album_author: "artist", album_cover: "p14")
]
