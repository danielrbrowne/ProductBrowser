import APIota
import Foundation

/// An API client for the Products API.
struct APIClient: APIotaClient {
    let session = URLSession.shared

    /// The API returns ISO-8601 dates containing fractional seconds.
    ///
    /// The native `.iso8601` date decoding strategy does not handle
    /// fractional seconds, so a custom strategy is used. See `DateDecodingStrategy+Extensions.swift`.
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
