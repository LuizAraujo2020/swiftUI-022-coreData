//
//  MovieDetail.swift
//  swiftUI-coreData
//
//  Created by Luiz Araujo on 05/12/21.
//

import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    let coreDM: CoreDataManager
    @State private var movieName: String = ""
    @Binding var needRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(.roundedBorder)
            Button("Update") {
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDM.updateMovie()
                    needRefresh.toggle()
                }
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie()
        let coreDM =  CoreDataManager()
        MovieDetail(movie: movie, coreDM: coreDM, needRefresh: .constant(false))
    }
}
