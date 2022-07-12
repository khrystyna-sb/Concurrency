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
                ForEach(people, id: \.self) { person in
                    Text(person.first_name)
                    Text(person.last_name)
                    Text("\(person.age)")
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
