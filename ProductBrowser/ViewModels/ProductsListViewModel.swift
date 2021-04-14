import APIota
import Combine
import Foundation

class ProductsListViewModel: ObservableObject {

    // MARK: - Published properties

    @Published var productsList: [Product] = []
    @Published var apiErrorResponse: (showAlert: Bool, error: Error?) = (false, nil)

    // MARK: - Private properties

    private var apiClient: APIotaClient
    private var cancellable: AnyCancellable?

    // MARK: - Lifecycle

    init(apiClient: APIotaClient = APIClient()) {
        self.apiClient = apiClient
    }

    // MARK: - View model updating

    func updateProductsList() {

        // First remove existing product items
        productsList.removeAll()

        let endpoint = FetchProductsEndpoint()
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
            })
            .assign(to: \.productsList, on: self)
    }
}
