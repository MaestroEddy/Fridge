import SwiftUI

struct ProductsListView: View {
    @ObservedObject var viewModel: ProductsListViewModel

    let backgroundColor = Color(#colorLiteral(red: 0.9370916486, green: 0.9369438291, blue: 0.9575446248, alpha: 1))

    var body: some View {
        NavigationView {
            List {
                Section(header: headerView(with: "Ready for eat"),
                        footer: footerView(with: "These products have not yet expired")) {
                    ForEach(viewModel.products) {
                        ProductsListViewItem(name: $0.name, date: $0.expirationDate.defaultFormatted())
                    }.onDelete(perform: {
                        viewModel.products.remove(atOffsets: $0)
                    })
                }
                Section(header: headerView(with: "Expired"),
                        footer: footerView(with: "These products have expired")) {
                    ForEach(viewModel.products) {
                        ProductsListViewItem(name: $0.name, date: $0.expirationDate.defaultFormatted())
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
                }) {
                    Image(systemName: "plus")
                }
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor(backgroundColor)
            }
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
    let name: String
    let date: String

    init(name: String, date: String) {
        self.name = name
        self.date = date
    }

    var body: some View {
        HStack {
            Text(name).layoutPriority(1)
            Spacer().layoutPriority(1)
            Text(date).layoutPriority(1)

            NavigationLink(destination: Text("Somewhere")) {
                EmptyView()
            }
        }
    }
}

// MARK: - Previews

struct ProductsListView_Previews: PreviewProvider {

    static var previews: some View {
        let products = [Product(name: "Milk", expirationDate: Date(), barcode: nil),
                        Product(name: "Bread", expirationDate: Date(), barcode: nil)]
        ProductsListView(viewModel: ProductsListView.ProductsListViewModel(products: products))
    }
}

struct ProductsListViewItem_Previews: PreviewProvider {

    static var previews: some View {
        return ProductsListViewItem(name: "name", date: "1.11.2012")
    }
}


