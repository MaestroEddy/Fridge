import SwiftUI

struct ProductDetails: View {
    var viewModel: ProductDetails.ViewModel

    var body: some View {
        List {
            Section(header: Text("")
                        .frame(width: UIScreen.main.bounds.width, height: C.sectionHeight, alignment: .leading)
                        .background(Color.tableBackground)) {
                VStack {
                    HStack {
                        Text(LocalizedStringKey("Product.Name")).layoutPriority(1)
                        Spacer().layoutPriority(1)
                        TextField(LocalizedStringKey("Product.Name"), text: Binding<String>(
                                    get: { viewModel.product.name },
                                    set: { viewModel.product.name = $0 }))
                        .padding(.trailing, -C.padding)
                        .layoutPriority(1)
                        .multilineTextAlignment(.trailing)
                    }
                    .padding(.vertical, C.padding)
                    Divider()
                    HStack {
                        Text(LocalizedStringKey("Product.ExpirationDate")).layoutPriority(1)
                        Spacer().layoutPriority(1)
                        TextField(Date().defaultFormatted(),
                                  text: Binding<String>(
                                    get: { viewModel.product.expirationDateString },
                                    set: { viewModel.product.expirationDateString = $0 }))
                            .padding(.trailing, -C.padding)
                            .layoutPriority(1)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.vertical, C.padding)
                }
            }
        }
        .onAppear() {
            UITableView.appearance().backgroundColor = UIColor(Color.tableBackground)
        }
        .onDisappear() {
            viewModel.storeProducts()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - Constants

extension ProductDetails {

    struct C {
        static let sectionHeight: CGFloat = 28
        static let padding: CGFloat = 5
    }
}


// MARK: - Preview

struct ProductDetails_Previews: PreviewProvider {

    static var previews: some View {
        ProductDetails(viewModel: ProductDetails.ViewModel(product: Product()))
    }
}
