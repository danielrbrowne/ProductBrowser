//
//  ProductBrowserTests.swift
//  ProductBrowserTests
//
//  Created by Daniel Browne on 13/04/2021.
//

import XCTest
@testable import ProductBrowser

class ProductBrowserTests: XCTestCase {

    private let validProductsJSON = """
    {
        "posts": [
            {
                "id": "d42c4e87-5789-4840-9978-65e0c333ff8a",
                "createdAt": "2020-08-14T20:17:23.123Z",
                "updatedAt": "2020-08-14T20:17:23.123Z",
                "title": "Juan Soto Washington Nationals Nike Youth 2020 Gold Program Replica Player Jersey - White/Gold",
                "images": [
                    "https://fanatics.frgimages.com/FFImage/thumb.aspx?i=/productimages/_3802000/ff_3802240-4b85edcce601a42d6641_full.jpg"
                ],
                "url": "https://www.fanatics.com/mlb/washington-nationals/juan-soto-washington-nationals-nike-youth-2020-gold-program-replica-player-jersey-white/gold/o-7887+t-58234569+p-8153449092+z-8-1618303961?_ref=p-CLP:m-GRID:i-r4c0:po-12",
                "merchant": "Fanatics"
            },
            {
                "id": "0ca90176-0711-4839-8fc1-27fc02bcd7da",
                "createdAt": "2020-08-14T20:17:23.113Z",
                "updatedAt": "2020-08-14T20:17:23.114Z",
                "title": "La Sélection Nomade",
                "images": [
                    "https://media-live.byredo.com/media/catalog/product/optimized/8/5/8529df057ba542031c76db2227539212ccfb359560579b72c48c9f95905e385f/mob_la-selection-nomade-3x12-ml_1_1.jpg"
                ],
                "url": "https://www.byredo.com/us_en/la-selection-nomade-eau-de-parfum-3x12ml",
                "merchant": ""
            },
            {
                "id": "bf89853f-1990-4a93-af2b-111a872f0626",
                "createdAt": "2020-08-14T20:17:23.099Z",
                "updatedAt": "2020-08-14T20:17:23.099Z",
                "title": "Embr Wave Bracelet",
                "images": [
                    "http://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-3-tiny_grande.png?v=1575515327",
                    "https://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-3-tiny_grande.png?v=1575515327",
                    "http://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-2-tiny_6da8a453-9968-45b5-acb9-ac92bff44033_grande.jpg?v=1575515327",
                    "https://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-2-tiny_6da8a453-9968-45b5-acb9-ac92bff44033_grande.jpg?v=1575515327",
                    "http://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-1_grande.png?v=1575515327",
                    "https://cdn.shopify.com/s/files/1/2403/5811/products/rose-gold-1_grande.png?v=1575515327"
                ],
                "url": "https://embrlabs.com/products/embr-wave",
                "merchant": "Embr Labs"
            },
            {
                "id": "21edda6d-c1ca-4c85-bdd2-278b6d953ca8",
                "createdAt": "2020-08-14T20:17:22.985Z",
                "updatedAt": "2020-08-14T20:17:22.986Z",
                "title": "king do way Insulated Stainless Steel Water Vacuum Bottle Flask Double-Walled with a Brush for Outdoor Sports Hiking Running, 500ml /18 oz",
                "images": [
                    "https://images-na.ssl-images-amazon.com/images/I/61ZSjBoo7TL._AC_SX679_.jpg",
                    "",
                    "https://images-na.ssl-images-amazon.com/images/I/61D920jUggL._AC_SX679_.jpg"
                ],
                "url": "",
                "merchant": "Amazon"
            }
        ]
    }
    """.data(using: .utf8)!

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds

        return decoder
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchProducts() throws {
        let apiResponse =  try decoder.decode(FetchProductsEndpoint.ProductsListAPIResponse.self,
                                              from: validProductsJSON)
        XCTAssertEqual(apiResponse.products.count, 4)

        XCTAssertEqual(apiResponse.products[0].title, "Juan Soto Washington Nationals Nike Youth 2020 Gold Program Replica Player Jersey - White/Gold")
        XCTAssertEqual(apiResponse.products[0].imageUrls.count, 1)
        XCTAssertEqual(apiResponse.products[0].url, URL(string: "https://www.fanatics.com/mlb/washington-nationals/juan-soto-washington-nationals-nike-youth-2020-gold-program-replica-player-jersey-white/gold/o-7887+t-58234569+p-8153449092+z-8-1618303961?_ref=p-CLP:m-GRID:i-r4c0:po-12"))
        XCTAssertEqual(apiResponse.products[0].merchant, "Fanatics")

        XCTAssertEqual(apiResponse.products[1].title, "La Sélection Nomade")
        XCTAssertEqual(apiResponse.products[1].imageUrls.count, 1)
        XCTAssertEqual(apiResponse.products[1].url, URL(string: "https://www.byredo.com/us_en/la-selection-nomade-eau-de-parfum-3x12ml"))
        XCTAssertNil(apiResponse.products[1].merchant)

        XCTAssertEqual(apiResponse.products[2].title, "Embr Wave Bracelet")
        XCTAssertEqual(apiResponse.products[2].imageUrls.count, 3)
        XCTAssertEqual(apiResponse.products[2].url, URL(string: "https://embrlabs.com/products/embr-wave"))
        XCTAssertEqual(apiResponse.products[2].merchant, "Embr Labs")

        XCTAssertEqual(apiResponse.products[3].title, "king do way Insulated Stainless Steel Water Vacuum Bottle Flask Double-Walled with a Brush for Outdoor Sports Hiking Running, 500ml /18 oz")
        XCTAssertEqual(apiResponse.products[3].imageUrls.count, 2)
        XCTAssertNil(apiResponse.products[3].url)
        XCTAssertEqual(apiResponse.products[3].merchant, "Amazon")
    }
}
