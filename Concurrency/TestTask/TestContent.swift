//
//  TestContent.swift
//  Concurrency
//
//  Created by Khrystyna Matasova on 07/07/2022.
//

import SwiftUI

struct TestContent: View {
    
    @StateObject private var viewModel = TestContentViewModel()
    
    var body: some View {
        VStack (spacing: 10) {
            Button {
                Task(priority: .high) {
                    await viewModel.fetchPerson()
                }
            }
            label: {
                Text("Download")
            }
            if let people = viewModel.people {
                ForEach(people.indices) { index in
                    if let firstName = people[index].first_name {
                        Text(firstName)
                    }
                    if let lastname = people[index].last_name {
                        Text(lastname)
                    }
                    if let age = people[index].age {
                        Text("\(age)")
                    }
                }
            }
        }
    }
}

struct TestContent_Previews: PreviewProvider {
    static var previews: some View {
        TestContent()
    }
}
