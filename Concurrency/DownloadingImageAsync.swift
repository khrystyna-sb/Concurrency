//
//  DownloadingImageAsync.swift
//  Concurrency
//
//  Created by Khrystyna Matasova on 19/06/2022.
//

import SwiftUI
import Combine

class DownloadingImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponce(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
            }
        return image
    }

    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponce(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponce)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync() async throws -> UIImage? {
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponce(data: data, response: response)
        } catch {
            throw error
        }
    }
}

class DownloadingImageAsyncViewModel: ObservableObject {
 
    @Published var image: UIImage? = nil
    let loader = DownloadingImageAsyncImageLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() async {
        /*
        loader.downloadWithEscaping { [weak self] image, error in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
         */
        /*
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
    
            } receiveValue: { [weak self] image in
                    self?.image = image
            }
            .store(in: &cancellables)
        */
        
        let image = try? await loader.downloadWithAsync()
        await MainActor.run {
            self.image = image
        }
    }
}

struct DownloadingImageAsync: View {
    
    @StateObject private var viewModel = DownloadingImageAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

struct DownloadingImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageAsync()
    }
}
