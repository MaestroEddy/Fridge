import SwiftUI

@main
struct FridgeApp: App {

    var body: some Scene {
        WindowGroup {
            ProductsListView(viewModel: ProductsListView.ProductsListViewModel(products:
                                                                                [Product(name: "Bread",
                                                                                         expirationDate: "2 Apr 2021",
                                                                                         barcode: nil)])
            )
        }
    }
}
