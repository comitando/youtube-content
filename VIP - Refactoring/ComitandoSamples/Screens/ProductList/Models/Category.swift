struct Category: Codable {
    let name: String
    let items: [Product]
}

struct CategoryList: Codable {
    let categories: [Category]
}
