import APIota
import Foundation

/// An endpoint for fetching product information, as a list of products.
///
/// Results returned from this endpoint are paginated
/// (i.e. Each new page of results is appended to the decoded product list
/// until no more products can be fetched from the API).
struct FetchProductsEndpoint: APIotaCodableEndpoint {

    /// Represents the API response for this endpoint.
    struct ProductsListAPIResponse: Decodable {
        let products: [Product]

        enum CodingKeys: String, CodingKey {
            case products = "posts"
        }
    }

    /// Represents a request for a page of results from this endpoint.
    struct PaginationRequest: Encodable {
        let skip: Int
        let take: Int

        init(skip: Int = 0, take: Int = 10) {
            self.skip = skip
            self.take = take
        }

        /// Move to the next page of results.
        /// - Returns: A new `PaginationRequest` representing the next page of results.
        func nextPage() -> Self {
            return PaginationRequest(skip: self.skip + self.take, take: self.take)
        }
    }

    // MARK: - APIotaCodableEndpoint conformance

    typealias SuccessResponse = ProductsListAPIResponse
    typealias ErrorResponse = Data
    typealias Body = PaginationRequest

    let encoder: JSONEncoder = JSONEncoder()

    let headers: HTTPHeaders? = {
        return HTTPHeaders(dictionaryLiteral: (HTTPHeader.contentType, HTTPMediaType.json.toString()))
    }()

    let httpBody: PaginationRequest?

    let httpMethod: HTTPMethod = .POST

    var path: String {
        return "/products/offset"
    }

    let queryItems: [URLQueryItem]? = nil
}
