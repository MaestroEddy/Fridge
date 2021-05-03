import SwiftUI

@main
struct FridgeApp: App {

    var body: some Scene {
        WindowGroup {
            ProductsListView(viewModel: ProductsListView.ProductsListViewModel(products:
                                                                                [Product(name: "Bread",
                                                                                         expirationDate: Date(),
                                                                                         barcode: nil)]))
        }
    }
}
