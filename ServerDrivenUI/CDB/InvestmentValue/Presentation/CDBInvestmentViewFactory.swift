//
//  CDBInvestmentViewFactory.swift
//  CDB
//
//  Created by Julio Junior on 01/03/23.
//

import UIKit
import SDUI
import Coordinator
import NetworkService
import Observability

final class CDBInvestmentViewFactory {
    
    private let network = NetworkClientMock()
    private let observability = ObservabilityMock()
    
    func makeBuilder(router: SDUICoodinatorRouter) -> UIViewController {
        let manager = CDBManager(network: network, observability: observability)
        let loader = CDBUIInvestmentValueLoader(network: network, observability: observability)
        let serviceCompose = CDBInvestmentValueCompose(loader: loader, manager: manager)
        let presenter = SDUIListPresenter()
        let interactor = SDUIListInteractor(service: serviceCompose, presenter: presenter)
        let controller = CDBInvestmentValueView(interactor: interactor, router: router)
        presenter.controller = controller
        
        return controller
    }
    
}

final class CDBInvestmentValueView: SDUIListController {}

private final class NetworkClientMock: NetworkClient {
    
    func execute(_ endpoint: ApiEndpointExposable, completion: @escaping ((Result<Data, Error>) -> Void)) {
        completion(.success(mockSDUI().data))
    }
    
    func mockSDUI() -> (data: Data, model: SDUIDTO) {
        let money = SDUIDynamic(id: "MoneyTextField")
        let fullButtom = SDUIDynamic(id: "FullButtom")
        
        let model = SDUIDTO(
            title: "Quanto você quer investir?",
            screenViewAnalytics: "renda_fixa_investir_screen_view",
            body: [
                money
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
                    "id": money.id,
                    "content": [
                        "title": "Saldo disponível na carteira R$ 950,00",
                        "placeHolder": "R$ 0,00",
                        "message": "Invista um valor a partir de R$ 10,00",
                        "buttoms": [
                            [
                                "title": "R$ 200,00",
                                "action": [
                                    "type": "addValue",
                                    "value": "200"
                                ]
                            ],
                            [
                                "title": "R$ 500,00",
                                "action": [
                                    "type": "addValue",
                                    "value": "500"
                                ]
                            ],
                            [
                                "title": "R$ 950,00",
                                "action": [
                                    "type": "newValue",
                                    "value": "950"
                                ]
                            ]
                        ]
                    ]
                ],
            ],
            "footer": [
                [
                    "id": fullButtom.id,
                    "content": [
                        "title": "Continuar",
                        "action": [
                            "type": "transition",
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
