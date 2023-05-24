//
//  CDBInvestmentSummaryFactory.swift
//  CDB
//
//  Created by Julio Junior on 01/03/23.
//

import UIKit
import SDUI
import Coordinator
import NetworkService
import Observability

final class CDBInvestmentSummaryFactory {
    
    private let network = NetworkClientMock()
    private let observability = ObservabilityMock()
    
    func makeBuilder(
        router: SDUICoodinatorRouter,
        manager: SDUILoader
    ) -> UIViewController {
        let loader = CDBUIInvestmentSummaryLoader(network: network, observability: observability)
        let serviceCompose = CDBInvestmentValueCompose(loader: loader, manager: manager)
        let presenter = SDUIListPresenter()
        let interactor = SDUIListInteractor(service: serviceCompose, presenter: presenter)
        let controller = CDBInvestmentSummary(interactor: interactor, router: router)
        presenter.controller = controller
        
        return controller
    }
    
}

final class CDBInvestmentSummary: SDUIListController {}

private final class NetworkClientMock: NetworkClient {
    
    func execute(_ endpoint: ApiEndpointExposable, completion: @escaping ((Result<Data, Error>) -> Void)) {
        completion(.success(mockSDUI().data))
    }
    
    func mockSDUI() -> (data: Data, model: SDUIDTO) {
        let heading5 = SDUIDynamic(id: "Heading")
        let investimentCard = SDUIDynamic(id: "InvestimentCard")
        let fullButtom = SDUIDynamic(id: "FullButtom")
        
        let model = SDUIDTO(
            title: "Investir",
            screenViewAnalytics: "renda_fixa_investir_summary_screen_view",
            body: [
                heading5,
                investimentCard
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
                        "title": "R$ 200,00"
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
                                "title": "Vencimento em",
                                "subtitle": "12/ago/2024"
                            ],
                            [
                                "title": "Resgate",
                                "subtitle": "Imediato"
                            ]
                        ]
                    ]
                ]
            ],
            "footer": [
                [
                    "id": fullButtom.id,
                    "content": [
                        "title": "Continuar",
                        "action": [
                            "type": "sendEvents",
                            "value": ""
                        ]
                    ]
                ]
            ]
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: responseJson)
        return (data, model)
    }

}
