# ProductBrowser

An example of a SwiftUI app that presents a list of products, each of which can be tapped on to see some product details.

## Features

- Product details fetched from an API endpoint, with pagination for loading more results when the user has scrolled to the end of the current product list
- Custom JSON decoding and UI presentation logic to handle dirty product data such as:
  - Empty product `title` strings
  - Empty product `url` strings
  - Empty product `merchant` strings
  - Empty product image `url` strings
  - De-duplication of product images (i.e. That have identical `url` strings which only differ by scheme prefix)
- A basic unit test covering decoding a mock of some valid JSON from the API into relevant model objects

## NOTES

- Uses my own library [APIota](https://github.com/danielrbrowne/APIota) for the API client functionality.

