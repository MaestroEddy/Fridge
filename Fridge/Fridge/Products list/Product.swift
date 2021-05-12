import Foundation

struct Product: Identifiable {
    var name: String
    var expirationDate: String
    let barcode: String?
    let id = UUID()
}
