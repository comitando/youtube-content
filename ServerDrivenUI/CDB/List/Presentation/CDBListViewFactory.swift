//
//  TableViewFactory.swift
//  Poc
//
//  Created by Julio Junior on 28/02/23.
//

import UIKit
import SDUI
import Coordinator
import NetworkService
import Observability

final class CDBListViewFactory {
    
    private let network = NetworkClientMock()
    private let observability = ObservabilityMock()
    
    func makeBuilder(router: SDUICoodinatorRouter) -> UIViewController {
        let service = CDBUILoader(network: network, observability: observability)
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
                        "subtitle": "PicPay Bank",
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
                            "title": "Investir",
                            "action": [
                                "type": "deeplink",
                                "value": "picpay://investir/cdb"
                            ]
                        ]
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "LCA",
                        "subtitle": "Original Bank",
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
                            "title": "Investir",
                            "action": [
                                "type": "deeplink",
                                "value": "picpay://investir/lca"
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
                        "subtitle": "PicPay Bank",
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
                            "title": "Investir",
                            "action": [
                                "type": "deeplink",
                                "value": "picpay://investir/cdb"
                            ]
                        ]
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "LCA",
                        "subtitle": "Original Bank",
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
                            "title": "Investir",
                            "action": [
                                "type": "deeplink",
                                "value": "picpay://investir/lca"
                            ]
                        ]
                    ]
                ],
                [
                    "id": investimentCard.id,
                    "content": [
                        "title": "LCA",
                        "subtitle": "Original Bank",
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
                            "title": "Investir",
                            "action": [
                                "type": "deeplink",
                                "value": "picpay://investir/lca"
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

final class ObservabilityMock: Observability {
    
    func sendData(_ error: Error) {
        
    }
    
}
