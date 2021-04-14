import Foundation
import SwiftUI

struct ProductDetailsView: View {
    var selectedProduct: Product?

    var body: some View {
        Group {
            if let product = selectedProduct {
                VStack(spacing: 20.0) {
                    if let productTitle = product.title {
                        Text(productTitle)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 20.0)
                            .padding(.trailing, 20.0)
                    }
                    if !product.imageUrls.isEmpty {
                        TabView {
                            ForEach(product.imageUrls, id: \.self) {
                                RemoteImage(url: $0)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150)
                                    .padding(.leading, 20.0)
                                    .padding(.trailing, 20.0)
                            }
                        }.tabViewStyle(PageTabViewStyle())
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 250)
                        .onAppear {
                            setupTabViewPageControlAppearance()
                        }
                    }
                    if let productUrl = product.url {
                        if let productMerchant = product.merchant {
                            Link("View at \(productMerchant)",
                                 destination: productUrl)
                        } else {
                            Link("View at Merchant Website",
                                 destination: productUrl)
                        }
                    }
                }
            } else {
                Text("Product details will appear here…")
                    .foregroundColor(.gray)
            }
        }.navigationBarTitle(Text("Product"))
    }

    /// Configures custom tint colors for instances of `UIPageControl`
    private func setupTabViewPageControlAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
