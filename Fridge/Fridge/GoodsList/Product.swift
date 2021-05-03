import Foundation

struct Product: Identifiable {
    let name: String
    let expirationDate: Date
    let barcode: String?
    let id = UUID()
}
