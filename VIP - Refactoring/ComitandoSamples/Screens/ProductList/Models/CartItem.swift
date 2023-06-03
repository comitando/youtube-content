struct CartItem {
    let productId: String
    private(set) var quantity: Int = 0
    
    mutating func incrementQuantity() {
        quantity += 1
    }
    
    mutating func decrementQuantity() {
        quantity -= 1
    }
    
    var hasOnlyOne: Bool {
        quantity == 1
    }
}
