//
//  NetworkManager.swift
//  Concurrency
//
//  Created by Khrystyna Matasova on 07/07/2022.
//

import Foundation

class TestContentViewModel: ObservableObject {
    
    @Published var people: [Person]? = nil
    
    func fetchPerson() async {
        do {
            guard let url = URL(string: "https://gist.githubusercontent.com/reinder42/932d7671859959f6363b4d9b4e18bb91/raw/306631d79a5166bb0d86b12ac7d8cc42fecb996e/users.json") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let people = try decoder.decode([Person].self, from: data)
            await MainActor.run(body: {
                self.people = people
            })
        } catch {
            print(error)
        }
    }
}
