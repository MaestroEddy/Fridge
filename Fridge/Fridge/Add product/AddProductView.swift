import SwiftUI

struct AddProductView: View {
    @State var product: Product
    @State var showCancelActionSheet = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ProductDetails(product: product)
                .navigationTitle("Add product")
                .navigationBarItems(leading: Button("Cancel") {
                    print("Cancel Pressed")
                    showCancelActionSheet = true
                }, trailing: Button("Add") {
                    print("Add Pressed")
                })
                .actionSheet(isPresented: $showCancelActionSheet) {
                    ActionSheet(title: Text("Cancel adding?"),
                                message: Text("Are you sure you want to cancel adding new product?"),
                                buttons: [
                                    .default(Text("Keep editing")),
                                    .default(Text("Cancel adding")) { presentationMode.wrappedValue.dismiss() },
                                    .cancel()
                                ]
                    )
                }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(product: Product(name: "Jam", expirationDate: "1 May 2021", barcode: nil))
    }
}
