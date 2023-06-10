import Foundation

struct Product: Codable, Equatable {
    let id: String
    let photo: String
    let name: String
    let description: String
    let price: Decimal
    let installments: String
    
    func priceFormatted() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        return formatter.string(from: price as NSNumber) ?? "R$ 0,00"
    }
}
