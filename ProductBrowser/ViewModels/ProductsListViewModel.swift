import APIota
import Combine
import Foundation

class ProductsListViewModel: ObservableObject {

    // MARK: - Published properties

    @Published var productsList: [Product] = []
    @Published var apiErrorResponse: (showAlert: Bool, error: Error?) = (false, nil)
    private(set) var allProductsFetched: Bool = false

    // MARK: - Private properties

    private var apiClient: APIotaClient
    private var cancellable: AnyCancellable?
    private var paginationRequest = FetchProductsEndpoint.PaginationRequest()

    // MARK: - Lifecycle

    init(apiClient: APIotaClient = APIClient()) {
        self.apiClient = apiClient
    }

    // MARK: - View model updating

    /// Reload the products list from its beginning
    func reloadProductsList() {

        productsList.removeAll()
        paginationRequest = FetchProductsEndpoint.PaginationRequest()
        allProductsFetched = false
        fetchNextProductsPage()
    }

    /// Fetch the next page of products from the list
    func fetchNextProductsPage() {

        let endpoint = FetchProductsEndpoint(httpBody: paginationRequest)
        cancellable = apiClient.sendRequest(for: endpoint)
            .map({ apiResponse -> [Product] in
                return apiResponse.products
            })
            .catch({ [weak self] error -> AnyPublisher<[Product], Never> in

                guard let self = self else {
                    return Just([]).eraseToAnyPublisher()
                }

                self.apiErrorResponse = (true, error)

                return Just([]).eraseToAnyPublisher()
            }).sink(receiveValue: { [weak self] fetchedProducts in
                guard let self = self else {
                    return
                }
                self.productsList.append(contentsOf: fetchedProducts)
                if fetchedProducts.count < self.paginationRequest.take {
                    self.allProductsFetched = true
                } else {
                    self.paginationRequest = self.paginationRequest.nextPage()
                }
            })
    }
}
