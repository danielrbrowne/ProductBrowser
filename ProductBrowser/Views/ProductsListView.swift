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
                }
            }
        }.onAppear {
            // Initial update of list view
            // (i.e. don't refresh every time the user returns to the list)
            if self.viewModel.productsList.isEmpty {
                self.viewModel.updateProductsList()
            }
        }
    }
}
