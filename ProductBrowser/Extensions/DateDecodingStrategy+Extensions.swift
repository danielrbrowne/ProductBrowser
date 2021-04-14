import Foundation

extension Formatter {

    static let iso8601WithFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {

    static let iso8601WithFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601WithFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Expected date string to be ISO8601-formatted (with fractional seconds).")
        }

        return date
    }
}
