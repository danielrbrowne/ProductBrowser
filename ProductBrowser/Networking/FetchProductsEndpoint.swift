import APIota
import Foundation

struct FetchProductsEndpoint: APIotaCodableEndpoint {

    struct ProductsListAPIResponse: Decodable {
        let products: [Product]

        enum CodingKeys: String, CodingKey {
            case products = "posts"
        }
    }

    // MARK: - APIotaCodableEndpoint conformance

    typealias SuccessResponse = ProductsListAPIResponse
    typealias ErrorResponse = Data
    typealias Body = String

    let encoder: JSONEncoder = JSONEncoder()

    let headers: HTTPHeaders? = nil

    let httpBody: String? = nil

    let httpMethod: HTTPMethod = .POST

    var path: String {
        return "/products"
    }

    let queryItems: [URLQueryItem]? = nil
}
