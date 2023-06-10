class CartItem: Equatable {
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        lhs.product == rhs.product
    }
    
    let product: Product
    private(set) var quantity: Int = 0
    
    init(product: Product, quantity: Int) {
        self.product = product
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
