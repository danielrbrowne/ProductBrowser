import SwiftUI

/// Asynchronously loads an remote image from a `URL`, presenting it in a view.
///
/// While the image is being fetched, a placeholder loading image is presented.
/// If the image fails to load, then a placeholder failure image is presented instead.
///
/// Adapted from: https://www.hackingwithswift.com/forums/swiftui/loading-images/3292
struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: URL) {
            fetchImage(from: url)
        }

        func fetchImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
            .foregroundColor(.gray)
    }

    init(url: URL,
         loading: Image = Image(systemName: "photo"),
         failure: Image = Image(systemName: "multiply.circle")) {

        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
