//
//  ContentView.swift
//  LMWNJ_test
//
//  Created by Hannarong Kaewkiriya on 21/1/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.travels) { travel in
            HStack(alignment: .top) {
                AsyncImage(url: travel.imageUrl[0])
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 250)
                    .cornerRadius(5)
                VStack(alignment: .leading) {
                    Text(travel.name)
                        .font(.headline)
                        .padding(.bottom, 2)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(travel.description)
                        .font(.subheadline)
                        .padding(.bottom, 2)
                }
                Spacer()
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(travel.positiveVotesCount)")
                        .font(.caption)
                }
            }
            Divider()
        }
        .refreshable {
            viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}


