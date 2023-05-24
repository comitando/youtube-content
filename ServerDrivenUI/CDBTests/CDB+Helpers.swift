//
//  Poc+Helpers.swift
//  PocTests
//
//  Created by Julio Junior on 24/02/23.
//

import Foundation
import SDUI

//func mockSDUI() -> (data: Data, model: SDUIDTO) {
//    let heading5 = SDUIDynamic(id: "Heading")
//    let quickActions = SDUIDynamic(id: "QuickActions")
//    let investimentCard = SDUIDynamic(id: "InvestimentCard")
//    
//    let model = SDUIDTO(
//        title: "Renda Fixa",
//        screenViewAnalytics: "renda_fixa_screen_view",
//        body: [
//            heading5,
//            quickActions,
//            investimentCard
//        ]
//    )
//    
//    let responseJson: [String: Any] = [
//        "title": model.title,
//        "screenViewAnalytics": model.screenViewAnalytics,
//        "body": [
//            [
//                "id": heading5.id,
//                "content": [
//                    "title": "Investimentos de baixo risco, que fazem seu dinheiro render com segurança."
//                ]
//            ],
//            [
//                "id": quickActions.id,
//                "content": [
//                    "items": [
//                        [
//                            "title": "CDB",
//                            "action": [
//                                "type": "realod",
//                                "value": "cdb"
//                            ]
//                        ],
//                        [
//                            "title": "LCI",
//                            "action": [
//                                "type": "realod",
//                                "value": "lci"
//                            ]
//                        ],
//                        [
//                            "title": "lCA",
//                            "action": [
//                                "type": "realod",
//                                "value": "lca"
//                            ]
//                        ]
//                    ]
//                ]
//            ],
//            [
//                "id": investimentCard.id,
//                "content": [
//                    "title": "CDB resgate imediato",
//                    "subtitle": "PicPay Bank",
//                    "tag": "102% do CDI",
//                    "infos": [
//                        [
//                            "title": "Resgate",
//                            "subtitle": "No vencimento"
//                        ],
//                        [
//                            "title": "Invista a partir de",
//                            "subtitle": "R$ 10,00"
//                        ]
//                    ],
//                    "action": [
//                        "type": "deeplink",
//                        "value": "picpay://investir"
//                    ]
//                ]
//            ]
//        ]
//    ]
//    
//    let data = try! JSONSerialization.data(withJSONObject: responseJson)
//    return (data, model)
//}
