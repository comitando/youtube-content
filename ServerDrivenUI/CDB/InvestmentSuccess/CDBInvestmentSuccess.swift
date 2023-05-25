//
//  CDBInvestmentSuccess.swift
//  CDB
//
//  Created by Julio Junior on 02/03/23.
//

import UIKit
import SDUI

final class CDBInvestment {
    static func success() -> FeedbackSystem {
        let title = "Parabéns! Seu investimento foi confirmado!"
        let subtitle = "Agora é só acompanhar seu dinheiro render!"
        let buttonTitle = "Ir pra Meus Investimentos"
        return FeedbackSystem(title: title, subtitle: subtitle, buttonTitle: buttonTitle)
    }
    
    static func failure() -> FeedbackSystem {
        let title = "Que pena! Seu investimento não foi confirmado!"
        let subtitle = "Não foi possível realizar a compra"
        let buttonTitle = "Ir pra Meus Investimentos"
        return FeedbackSystem(title: title, subtitle: subtitle, buttonTitle: buttonTitle)
    }
    
}
