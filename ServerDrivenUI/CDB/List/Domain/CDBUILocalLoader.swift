//
//  CDBUILocalLoader.swift
//  CDB
//
//  Created by JOAO PEREIRA on 24/05/23.
//

import Foundation
import NetworkService
import Observability
import SDUI

final class CDBUILocalLoader: SDUILoader {

    private let observability: Observability

    init(observability: Observability) {
        self.observability = observability
    }

    func request(_ completion: @escaping ((SDUIDTO) -> Void)) {
        completion(
            .init(
                title: "Renda Fixa",
                screenViewAnalytics: "renda_fixa_screen_view",
                body: {
                    [
                        HeadingBuilder("Investimentos de baixo risco, que fazem seu dinheiro render com segurança."),
                        HeadingBuilder("Investimentos de baixo risco, que fazem seu dinheiro render com segurança.")
                    ]
                        .isHidden(true)
                    QuickActionsBuilder(
                        items: [
                            .init(
                                title: "CDB",
                                action: .init(
                                    type: .reload,
                                    value: "cdb"
                                )
                            ),
                            .init(
                                title: "LCI",
                                action: .init(
                                    type: .reload,
                                    value: "lci"
                                )
                            ),
                            .init(
                                title: "LCA",
                                action: .init(
                                    type: .reload,
                                    value: "lca"
                                )
                            ),
                        ]
                    ).isHidden(true)
                    HeadingBuilder("Curto prazo")
                    InvestimentCardBuilder(
                        title: "CDB resgate imediato",
                        subtitle: "Bank",
                        tag: "102% do CDI",
                        infos: [
                            .init(
                                title: "Resgate",
                                subtitle: "No vencimento"
                            ),
                            .init(
                                title: "Invista a partir de",
                                subtitle: "R$ 10,00"
                            )
                        ],
                        action: .init(
                            title: "Investir",
                            action: .init(
                                type: .deeplink,
                                value: "poc://investir/cdb"
                            )
                        )
                    )
                    InvestimentCardBuilder(
                        title: "CDB resgate imediato",
                        subtitle: "Bank",
                        tag: "102% do CDI",
                        infos: [
                            .init(
                                title: "Resgate",
                                subtitle: "No vencimento"
                            ),
                            .init(
                                title: "Invista a partir de",
                                subtitle: "R$ 10,00"
                            )
                        ],
                        action: .init(
                            title: "Investir",
                            action: .init(
                                type: .deeplink,
                                value: "poc://investir/cdb"
                            )
                        )
                    )
                    InvestimentCardBuilder(
                        title: "CDB resgate imediato",
                        subtitle: "Bank",
                        tag: "102% do CDI",
                        infos: [
                            .init(
                                title: "Resgate",
                                subtitle: "No vencimento"
                            ),
                            .init(
                                title: "Invista a partir de",
                                subtitle: "R$ 10,00"
                            )
                        ],
                        action: .init(
                            title: "Investir",
                            action: .init(
                                type: .deeplink,
                                value: "poc://investir/cdb"
                            )
                        )
                    )
                    InvestimentCardBuilder(
                        title: "CDB resgate imediato",
                        subtitle: "Bank",
                        tag: "102% do CDI",
                        infos: [
                            .init(
                                title: "Resgate",
                                subtitle: "No vencimento"
                            ),
                            .init(
                                title: "Invista a partir de",
                                subtitle: "R$ 10,00"
                            )
                        ],
                        action: .init(
                            title: "Investir",
                            action: .init(
                                type: .deeplink,
                                value: "poc://investir/cdb"
                            )
                        )
                    )
                },
                footer: {
                    HeadingBuilder("Investimentos de baixo risco, que fazem seu dinheiro render com segurança.")
                }
            )

        )
    }
}


