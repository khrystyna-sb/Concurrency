//
//  TaskBootbamp.swift
//  Concurrency
//
//  Created by Khrystyna Matasova on 08/07/2022.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            self.image = image
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            self.image2 = image
        } catch  {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootbamp: View {
    
    @StateObject private var viewModel = TaskBootcampViewModel()
    //    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        //        .onDisappear(perform: {
        //we can can cancel the Task if user closed the window by
        //            fetchImageTask?.cancel()
        //        })
        //        .onAppear {
        //            fetchImageTask = Task {
        //                await viewModel.fetchImage()
        //            }
        //            Task {
        //                print(Thread.current)
        //                print(Task.currentPriority)
        //                await viewModel.fetchImage2()
        //            }
        //            Task(priority: .high) {
        //                print("high : \(Thread.current) : \(Task.currentPriority)")
        //            }
        //            Task(priority: .userInitiated) {
        //                print("userInitiated : \(Thread.current) : \(Task.currentPriority)")
        //            }
        //            Task(priority: .medium) {
        //                print("medium : \(Thread.current) : \(Task.currentPriority)")
        //            }
        //            Task(priority: .utility) {
        //                print("utility : \(Thread.current) : \(Task.currentPriority)")
        //            }
        //            Task(priority: .low) {
        //                print("LOW : \(Thread.current) : \(Task.currentPriority)")
        //            }
        //            Task(priority: .background) {
        //                print("background : \(Thread.current) : \(Task.currentPriority)")
        //            }
    }
}


struct TaskBootbamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootbamp()
    }
}
