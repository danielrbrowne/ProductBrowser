import Foundation
import SwiftUI

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductsListViewModel

    var body: some View {
        List {
            ForEach(viewModel.productsList) { product in
                NavigationLink(
                    destination: ProductDetailsView(selectedProduct: product)
                ) {
                    Text(product.title ?? "A Product")
                }.onAppear {
                    // If the last product in the list has appeared on screen,
                    // attempt fetching the next products page from the API
                    if product.id == viewModel.productsList.last?.id {
                        self.viewModel.fetchNextProductsPageIfAvailable()
                    }
                }
            }
        }.onAppear {
            // Initial update of list view
            // (i.e. don't refresh every time the user returns to the list)
            if self.viewModel.productsList.isEmpty {
                self.viewModel.reloadProductsList()
            }
        }
    }
}
