import SwiftUI

struct ProductDetails: View {
    @State var product: Product

    var body: some View {
        List {
            Section(header: Text("")
                        .frame(width: UIScreen.main.bounds.width, height: 28, alignment: .leading)
                        .background(Color(#colorLiteral(red: 0.9370916486, green: 0.9369438291, blue: 0.9575446248, alpha: 1)))) {
                VStack {
                    HStack {
                        Text("Name").layoutPriority(1)
                        Spacer().layoutPriority(1)
                        TextField("Name", text: $product.name)
                            .padding(.trailing, -5.0)
                            .layoutPriority(1)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.vertical, 5.0)
                    Divider()
                    HStack {
                        Text("Expiration Date").layoutPriority(1)
                        Spacer().layoutPriority(1)
                        TextField("3 Apr 2022", text: $product.expirationDate)
                            .padding(.trailing, -5.0)
                            .layoutPriority(1)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(.vertical, 5.0)
                }
            }
        }
        .onAppear() {
            UITableView.appearance().backgroundColor = #colorLiteral(red: 0.9370916486, green: 0.9369438291, blue: 0.9575446248, alpha: 1)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: Product(name: "Icecream", expirationDate: "1 Apr 2021", barcode: nil))
    }
}
