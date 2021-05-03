import Foundation

extension ProductsListView {

    class ProductsListViewModel: ObservableObject {
        @Published var products = [Product]()

        init(products: [Product]) {
            self.products = products
        }
    }
}
