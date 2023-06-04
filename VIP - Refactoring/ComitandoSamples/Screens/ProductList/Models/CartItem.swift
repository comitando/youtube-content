class CartItem {
    let productId: String
    private(set) var quantity: Int = 0
    
    init(productId: String, quantity: Int) {
        self.productId = productId
        self.quantity = quantity
    }
    
    func incrementQuantity() {
        quantity += 1
    }
    
    func decrementQuantity() {
        quantity -= 1
    }
    
    var hasOnlyOne: Bool {
        quantity == 1
    }
}
