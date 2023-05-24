//
//  ViewCodeHelper.swift
//  SDUI
//
//  Created by Julio Junior on 14/03/23.
//

import Foundation

public protocol ViewCodeHelper {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

public extension ViewCodeHelper {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }

    func setupAdditionalConfiguration() {}
}
