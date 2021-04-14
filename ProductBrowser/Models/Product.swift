import Foundation

/// A representation of product data received from the API.
struct Product: Decodable, Identifiable {
    let id: UUID
    let createdAt: Date
    let updatedAt: Date
    let title: String?
    let imageUrls: [URL]
    let url: URL?
    let merchant: String?

    // MARK: - Custom Decodable conformance

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case updatedAt
        case title
        case imageUrls = "images"
        case url
        case merchant
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(UUID.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)

        // Convert an empty title string to `String?` (i.e. `nil`)
        let titleString = try container.decode(String.self, forKey: .title)
        self.title = !titleString.isEmpty ? titleString : nil

        // Decode URL strings to an array of `URL`
        // (Ignoring duplicate image URLs that only differ by scheme prefix,
        // and favouring https URLs)
        let uniqueImageUrls = Set(try container.decode([String].self,
                                                       forKey: .imageUrls)
                                    .map { $0.components(separatedBy: "://").last! })
            .compactMap { !$0.isEmpty ? URL(string: "https://\($0)") : nil }
        self.imageUrls = uniqueImageUrls
        
        self.url = try? container.decode(URL.self, forKey: .url)

        // Convert an empty merchant string to `String?` (i.e. `nil`)
        let merchantString = try container.decode(String.self, forKey: .merchant)
        self.merchant = !merchantString.isEmpty ? merchantString : nil
    }
}
