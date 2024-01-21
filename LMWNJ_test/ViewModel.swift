//
//  ViewModel.swift
//  LMWNJ_test
//
//  Created by Hannarong Kaewkiriya on 21/1/2567 BE.
//

import Foundation

struct Travel: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let imageUrl: [URL]
    let description: String
    let positiveVotesCount: Int
}

struct Root: Decodable {
    let photos: [Travel]
}

class ViewModel: ObservableObject {
    @Published var travels: [Travel] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.500px.com/v1/photos?feature=popular&page=1") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Root.self, from: data)
                DispatchQueue.main.async {
                    self?.travels = response.photos
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

