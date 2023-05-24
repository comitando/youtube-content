//
//  SDUIView.swift
//  SDUI
//
//  Created by Julio Junior on 24/02/23.
//

import UIKit

protocol SDUIViewInterface {
    associatedtype RenderType
    func render(_ type: RenderType)
}

open class SDUIView: UIView, ViewCodeHelper, SDUIViewInterface  {
    public private(set) var viewModel: SDUIDynamic?
    private(set) weak var delegate: SDUITargetEvent?

    public convenience init(viewModel: SDUIDynamic? = nil, delegate: SDUITargetEvent? = nil) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        self.delegate = delegate
        setupView()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    public let margin: CGFloat = 16
    public func buildViewHierarchy() {}
    public func setupConstraints() {}
    public func setupAdditionalConfiguration() {}

    enum RenderType {
        case build(SDUIDynamic)
        case customDelegate(SDUITargetEvent?)
    }

    func render(_ type: RenderType) {
        switch type {
        case let .build(viewModel):
            self.viewModel = viewModel
            self.setupAdditionalConfiguration()
        case let .customDelegate(delegate):
            self.delegate = delegate
        }
    }
}
