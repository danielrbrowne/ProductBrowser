import APIota
import Foundation

struct APIClient: APIotaClient {
    let session = URLSession.shared

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds

        return decoder
    }

    var baseUrlComponents: URLComponents {

        var urlComponents = URLComponents()
        urlComponents.host = "localhost"
        urlComponents.port = 3000
        urlComponents.scheme = "http"

        return urlComponents
    }
}
