//
//  ContentView.swift
//  swiftUI-coreData
//
//  Created by Luiz Araujo on 05/12/21.
//

import SwiftUI

struct ContentView: View {
    ///
    let coreDM: CoreDataManager
    @State private var movieTile = ""
    // NOT A GOOD IDEA TO USE STATE TO POLULATE DATA FROM
    //THIRD PARTY CALL
    @State private var movies: [Movie] = [Movie]()
    @State private var needRefresh: Bool = false
    
    func polulateMovies() {
        movies = coreDM.getAllMovies()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Title", text: $movieTile)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    coreDM.saveMovie(title: movieTile)
                    polulateMovies()
                }
                
                List {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(destination: {
                            MovieDetail(movie: movie, coreDM: coreDM, needRefresh: $needRefresh)
                        }, label: {
                            Text(movie.title ?? "")
                        })
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            // delete it using COre Data Manager
                            coreDM.DeleteMovie(movie: movie)
                            polulateMovies()
                        }
                    }
                }
                .listStyle(.plain)
                .accentColor(needRefresh ? .white : .black)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Movies")
            
            .onAppear {
                polulateMovies()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
