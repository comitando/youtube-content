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

final class CDBDetailViewFactory {
    
    private let network = NetworkClientMock()
    private let observability = ObservabilityMock()
    
    func makeBuilder(router: SDUICoodinatorRouter) -> UIViewController {
        let service = CDBDetailUILoader(network: network, observability: observability)
        let presenter = SDUIListPresenter()
        let interactor = SDUIListInteractor(service: service, presenter: presenter)
        let controller = CDBDetailView(interactor: interactor, router: router)
        presenter.controller = controller
        
        return controller
    }
    
}

final class CDBDetailView: SDUIListController {}

private final class NetworkClientMock: NetworkClient {
    
    func execute(_ endpoint: ApiEndpointExposable, completion: @escaping ((Result<Data, Error>) -> Void)) {
        completion(.success(mockSDUI().data))
    }
    
    func mockSDUI() -> (data: Data, model: SDUIDTO) {
        let heading5 = SDUIDynamic(id: "Heading")
        let fullButtom = SDUIDynamic(id: "FullButtom")
        
        let model = SDUIDTO(
            title: "CDB resgate imediato",
            screenViewAnalytics: "renda_fixa_detalhe_screen_view",
            body: [
                heading5
            ],
            footer: [
                fullButtom
            ]
        )
        
        let responseJson: [String: Any] = [
            "title": model.title,
            "isRefreshEnabled": false,
            "screenViewAnalytics": model.screenViewAnalytics,
            "body": [
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Emissor: PicPay Bank"
                    ]
                ],
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Vencimento em: 12/ago/2024"
                    ]
                ],
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Resgate: Imediato"
                    ]
                ],
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Risco: Baixo"
                    ]
                ],
                [
                    "id": heading5.id,
                    "content": [
                        "title": "IOF sobre Rendimento: Isento após 30 dias"
                    ]
                ],
                [
                    "id": heading5.id,
                    "content": [
                        "title": "Invista a partir de: R$ 10,00"
                    ]
                ],
            ],
            "footer": [
                [
                    "id": fullButtom.id,
                    "content": [
                        "title": "Investir",
                        "action": [
                            "type": "deeplink",
                            "value": "picpay://invest-flow"
                        ]
                    ]
                ]
            ]
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: responseJson)
        return (data, model)
    }

}
