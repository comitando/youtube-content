import UIKit
import SDUI
import Coordinator
import NetworkService

final class CDBListViewFactory {
    
    private let network = NetworkClientMock()
    
    func makeBuilder(router: SDUICoodinatorRouter) -> UIViewController {
        let service = CDBUILoader(network: network)
        let presenter = SDUIListPresenter()
        let interactor = SDUIListInteractor(service: service, presenter: presenter)
        let controller = CDBListView(interactor: interactor, router: router)
        presenter.controller = controller
        
        return controller
    }
    
}

final class CDBListView: SDUIListController {}

private final class NetworkClientMock: NetworkClient {
    
    func execute(_ endpoint: ApiEndpointExposable, completion: @escaping ((Result<Data, Error>) -> Void)) {
        completion(.success(mockSDUI().data))
    }
    
    func mockSDUI() -> (data: Data, model: SDUIDTO) {
        let heading5 = SDUIDynamic(id: "Heading")
        let quickActions = SDUIDynamic(id: "QuickActions")
        let investimentCard = SDUIDynamic(id: "InvestimentCard")
        
        let model = SDUIDTO(
            title: "Renda Fixa",
            screenViewAnalytics: "renda_fixa_screen_view",
            body: [
                heading5,
                quickActions,
                investimentCard
            ]
        )
        
        let responseJson: [String: Any] = [
            "title": model.title,
            "isRefreshEnabled": true,
            "screenViewAnalytics": model.screenViewAnalytics,
            "body": [
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Investimentos de baixo risco, que fazem seu dinheiro render com segurança."
                    ]
                ],
                [
                    "id": quickActions.id,
                    "content": [
                        "items": [
                            [
                                "title": "CDB",
                                "action": [
                                    "type": "realod",
                                    "value": "cdb"
                                ]
                            ],
                            [
                                "title": "LCI",
                                "action": [
                                    "type": "realod",
                                    "value": "lci"
                                ]
                            ],
                            [
                                "title": "lCA",
                                "action": [
                                    "type": "realod",
                                    "value": "lca"
                                ]
                            ]
                        ]
                    ]
                ],
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Curto prazo"
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "CDB resgate imediato",
                        "subtitle": "Bank A",
                        "tag": "102% do CDI",
                        "infos": [
                            [
                                "title": "Resgate",
                                "subtitle": "No vencimento"
                            ],
                            [
                                "title": "Invista a partir de",
                                "subtitle": "R$ 10,00"
                            ]
                        ],
                        "action": [
                            "title": "Detalhe",
                            "action": [
                                "type": "deeplink",
                                "value": "poc://investir/cdb"
                            ]
                        ]
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "LCA",
                        "subtitle": "Bank B",
                        "tag": "123% do CDI",
                        "infos": [
                            [
                                "title": "Resgate",
                                "subtitle": "No vencimento"
                            ],
                            [
                                "title": "Invista a partir de",
                                "subtitle": "R$ 1000,00"
                            ]
                        ],
                        "action": [
                            "title": "Detalhe",
                            "action": [
                                "type": "deeplink",
                                "value": "poc://investir/lca"
                            ]
                        ]
                    ]
                ],
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Longo prazo"
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "CDB resgate imediato",
                        "subtitle": "Bank A",
                        "tag": "102% do CDI",
                        "infos": [
                            [
                                "title": "Resgate",
                                "subtitle": "No vencimento"
                            ],
                            [
                                "title": "Invista a partir de",
                                "subtitle": "R$ 10,00"
                            ]
                        ],
                        "action": [
                            "title": "Detalhe",
                            "action": [
                                "type": "deeplink",
                                "value": "poc://investir/cdb"
                            ]
                        ]
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "LCA",
                        "subtitle": "Bank B",
                        "tag": "123% do CDI",
                        "infos": [
                            [
                                "title": "Resgate",
                                "subtitle": "No vencimento"
                            ],
                            [
                                "title": "Invista a partir de",
                                "subtitle": "R$ 1000,00"
                            ]
                        ],
                        "action": [
                            "title": "Detalhe",
                            "action": [
                                "type": "deeplink",
                                "value": "poc://investir/lca"
                            ]
                        ]
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "LCA",
                        "subtitle": "Bank B",
                        "tag": "123% do CDI",
                        "infos": [
                            [
                                "title": "Resgate",
                                "subtitle": "No vencimento"
                            ],
                            [
                                "title": "Invista a partir de",
                                "subtitle": "R$ 1000,00"
                            ]
                        ],
                        "action": [
                            "title": "Detalhe",
                            "action": [
                                "type": "deeplink",
                                "value": "poc://investir/lca"
                            ]
                        ]
                    ]
                ],
            ]
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: responseJson)
        return (data, model)
    }

}
