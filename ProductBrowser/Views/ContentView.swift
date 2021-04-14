import SwiftUI

struct ContentView: View {
    // View-model is observed for changes to its state via SwiftUI
    @ObservedObject private var viewModel: ProductsListViewModel = ProductsListViewModel()

    var body: some View {
        NavigationView {
            ProductsListView(viewModel: viewModel)
                .navigationBarTitle(Text("Products List"))
                .navigationBarItems(
                    trailing: Button(
                        action: {
                            self.viewModel.updateProductsList()
                        }
                    ) {
                        Text("Refresh")
                    }
            )
            ProductDetailsView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
            .alert(isPresented: $viewModel.apiErrorResponse.showAlert) {
                Alert(title: Text("Error"),
                      message: Text(viewModel.apiErrorResponse.error?.localizedDescription ?? "An error has occured. Please try again later."))
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
