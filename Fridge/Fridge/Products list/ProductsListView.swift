import SwiftUI
import Combine

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductsListViewModel
    @State var showingActionSheet = false
    @State var showingAddNewProductView = false
    @State var showingBarcodeScannerView = false
    var cameraViewModel: CameraViewModel
    let backgroundColor = Color(#colorLiteral(red: 0.9370916486, green: 0.9369438291, blue: 0.9575446248, alpha: 1))

    init(viewModel: ProductsListViewModel) {
        self.viewModel = viewModel
        cameraViewModel = CameraViewModel()
        cameraViewModel.code = Binding(get: { "" },
                                       set: { print($0) })
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: headerView(with: "Ready for eat"),
                        footer: footerView(with: "These products have not yet expired")) {
                    ForEach(viewModel.products) {
                        ProductsListViewItem(product: $0)
                    }.onDelete(perform: {
                        viewModel.products.remove(atOffsets: $0)
                    })
                }
                Section(header: headerView(with: "Expired"),
                        footer: footerView(with: "These products have expired")) {
                    ForEach(viewModel.products) {
                        ProductsListViewItem(product: $0)
                    }.onDelete(perform: {
                        viewModel.products.remove(atOffsets: $0)
                    })
                }
                Section() { }
            }
            .navigationBarTitle("My Fridge")
            .toolbar {
                Button(action: {
                    print("Plus was tapped")
                    showingActionSheet = true
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddNewProductView) {
                    AddProductView(product: Product(name: "Rice", expirationDate: "1 Apr 2021", barcode: nil))
                }
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor(backgroundColor)
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Add new product"), message: Text("Select a new product adding option"), buttons: [
                    .default(Text("Scan barcode")) { showingBarcodeScannerView = true },
                    .default(Text("Add manually")) { showingAddNewProductView = true },
                    .cancel()
                ])
            }
        }
        .sheet(isPresented: $showingBarcodeScannerView) {
            BarcodeScanner(camera: cameraViewModel)
        }
    }

    private func headerView(with text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 28, alignment: .leading)
            .background(backgroundColor)
    }

    private func footerView(with text: String) -> some View {
        Text(text)
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 20.0)
            .listRowBackground(backgroundColor)
    }
}

struct ProductsListViewItem: View {
    let product: Product

    var body: some View {
        HStack {
            Text(product.name).layoutPriority(1)
            Spacer().layoutPriority(1)
            Text(product.expirationDate).layoutPriority(1)

            NavigationLink(destination: ProductDetails(product: product)) { }
        }
    }
}

// MARK: - Previews

struct ProductsListView_Previews: PreviewProvider {

    static var previews: some View {
        let products = [Product(name: "Milk", expirationDate: "2 Apr 2021", barcode: nil),
                        Product(name: "Bread", expirationDate: "2 Apr 2021", barcode: nil)]
        ProductsListView(viewModel: ProductsListView.ProductsListViewModel(products: products))
    }
}

struct ProductsListViewItem_Previews: PreviewProvider {

    static var previews: some View {
        return ProductsListViewItem(product: Product(name: "Cheese", expirationDate: "2 Apr 2021", barcode: nil))
    }
}
