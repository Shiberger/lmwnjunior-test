//
//  ContentView.swift
//  LMWNJ_test
//
//  Created by Hannarong Kaewkiriya on 21/1/2567 BE.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View{
        
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .background(Color.gray)
                    .cornerRadius(3)
        }
        else{
            Image("")
                .frame(width: 120, height: 60)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
    }
    
    private func fetchData(){
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, _,
            _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.travels){ travel in
                    HStack {
                        URLImage(urlString: travel.description)
                                            
                            Text("\(travel.name)")
                                    .bold()
                        
                            }
                            .padding(10)
                }
            }
            .navigationTitle("Travels")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    ContentView()
}


