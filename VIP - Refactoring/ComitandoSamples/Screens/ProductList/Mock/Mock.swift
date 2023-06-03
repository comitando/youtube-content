import Foundation

struct Mock {
    private static let jsonMock = """
    {
        "categories": [
            {
                "name": "Macs",
                "items": [
                    {
                        "id": "1",
                        "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery1-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621031697",
                        "name": "MacBookPro 14' (1)",
                        "description": "GPU de 16 núcleos, 16GB, 512GB SSD",
                        "price": 10.10,
                        "installments": "em até 10x de R$ 2.314,88 sem juros"
                    },{
                        "id": "2",
                        "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery1-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621031697",
                        "name": "MacBookPro 14' (2)",
                        "description": "GPU de 16 núcleos, 16GB, 512GB SSD",
                        "price": 10.10,
                        "installments": "em até 10x de R$ 2.314,88 sem juros"
                    },{
                        "id": "3",
                        "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp14-spacegray-gallery1-202301?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1670621031697",
                        "name": "MacBookPro 14' (3)",
                        "description": "GPU de 16 núcleos, 16GB, 512GB SSD",
                        "price": 10.10,
                        "installments": "em até 10x de R$ 2.314,88 sem juros"
                    },
                ]
            },{
                "name": "iPhones",
                "items": [
                   {
                       "id": "4",
                       "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-2-202209_GEO_US?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1660753617560",
                       "name": "iPhone 14 Pro (4)",
                       "description": "Tela de 6,1', 5G, Câmera Tripla de 48MP",
                       "price": 9.5,
                       "installments": "em até 5x R$ 1.699,38 no cartão"
                   }, {
                        "id": "5",
                        "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-2-202209_GEO_US?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1660753617560",
                        "name": "iPhone 14 Pro (5)",
                        "description": "Tela de 6,1', 5G, Câmera Tripla de 48MP",
                        "price": 9.5,
                        "installments": "em até 5x R$ 1.699,38 no cartão"
                    }, {
                        "id": "6",
                        "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-2-202209_GEO_US?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1660753617560",
                        "name": "iPhone 14 Pro (6)",
                        "description": "Tela de 6,1', 5G, Câmera Tripla de 48MP",
                        "price": 9.5,
                        "installments": "em até 5x R$ 1.699,38 no cartão"
                    }, {
                        "id": "7",
                        "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-2-202209_GEO_US?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1660753617560",
                        "name": "iPhone 14 Pro (7)",
                        "description": "Tela de 6,1', 5G, Câmera Tripla de 48MP",
                        "price": 9.5,
                        "installments": "em até 5x R$ 1.699,38 no cartão"
                    }, {
                        "id": "8",
                        "photo": "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-model-unselect-gallery-2-202209_GEO_US?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1660753617560",
                        "name": "iPhone 14 Pro (8)",
                        "description": "Tela de 6,1', 5G, Câmera Tripla de 48MP",
                        "price": 9.5,
                        "installments": "em até 5x R$ 1.699,38 no cartão"
                    }
                ]
            }
        ]
    }
    """.data(using: .utf8) ?? .init()
    
    var categories: [Category] = {
        
        do {
            let response = try JSONDecoder().decode(CategoryList.self, from: jsonMock)

        } catch  {
            print(error)
        }
        
        guard let response = try? JSONDecoder().decode(CategoryList.self, from: jsonMock) else {
            return []
        }
        
        return response.categories
    }()
}
