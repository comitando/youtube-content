//
//  TableViewController.swift
//  Poc
//
//  Created by Julio Junior on 27/02/23.
//

import Coordinator
import UIKit

public protocol SDUIDisplayLogic: AnyObject {
    func displayViewModel(_ viewModel: SDKUIListModel.ViewModel)
}

open class SDUIListController: UIViewController {
    private var cells: [SDUICellController]
    private let interactor: SDUIBusinessLogic
    private let router: SDUICoodinatorRouter

    public required init?(coder: NSCoder) { nil }

    public init(
        cells: [SDUICellController] = [],
        interactor: SDUIBusinessLogic,
        router: SDUICoodinatorRouter
    ) {
        self.cells = cells
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: ViewCode
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var footerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var footerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refresh()
    }

    @objc
    func refresh() {
        interactor.doRequest(.fetchData)
    }

    private func refreshConfiguration(_ isEnabled: Bool) {
        if tableView.refreshControl == nil && isEnabled {
            tableView.refreshControl = refreshControl
        }
    }

    private func onLoadingChange(_ isLoading: Bool) {
        if isLoading {
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
        }
    }

    private func displayView(_ viewModel: SDUIDTO) {
        let cells = viewModel.body.compactMap {
            let cell = $0.instantiateCellController(delegate: self)
            cell?.registerCell(tableView: tableView)
            return cell
        }

        let footerItems = viewModel.footer?.compactMap {
            $0.instantiateView(delegate: self)
        } ?? []

        refreshConfiguration(viewModel.isRefreshEnabled)
        builderFooter(footerItems)

        self.title = viewModel.title
        self.cells = cells
        self.tableView.reloadData()
    }

    private func finished(_ error: Error?) {
        if error == nil {
            router.onNext(self, type: .deeplink, value: "sucesso")
        } else {
            router.onNext(self, type: .deeplink, value: "falha")
        }
    }

    private func builderFooter(_ items: [SDUIView]) {
        items.forEach { customView in
            customView.translatesAutoresizingMaskIntoConstraints = false
            footerStack.addArrangedSubview(customView)
            footerContainer.backgroundColor = customView.backgroundColor
        }

        if items.count > 0 && view.subviews.count == 1 {
            view.addSubview(footerContainer)
            footerContainer.addSubview(footerStack)

            let keyWindow = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .filter({ $0.isKeyWindow }).first

            let bottomSafeArea: CGFloat = keyWindow?.safeAreaInsets.bottom ?? 0

            NSLayoutConstraint.activate([
                footerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                footerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                footerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

            NSLayoutConstraint.activate([
                footerStack.topAnchor.constraint(equalTo: footerContainer.topAnchor),
                footerStack.trailingAnchor.constraint(equalTo: footerContainer.trailingAnchor),
                footerStack.bottomAnchor.constraint(equalTo: footerContainer.bottomAnchor, constant: -bottomSafeArea),
                footerStack.leadingAnchor.constraint(equalTo: footerContainer.leadingAnchor)
            ])

            footerContainer.layoutIfNeeded()

            let bottom = footerContainer.frame.height - bottomSafeArea
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
        }
    }
}

// MARK: ViewCodeHelper methods
extension SDUIListController: ViewCodeHelper {
    public func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    public func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    public func setupAdditionalConfiguration() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .white
    }
}

// MARK: UITableViewDataSource methods
extension SDUIListController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
}

// MARK: SDUIViewPresenterDelegate methods
extension SDUIListController: SDUIDisplayLogic {
    public func displayViewModel(_ viewModel: SDKUIListModel.ViewModel) {
        switch viewModel {
        case let .isLoading(isLoading): onLoadingChange(isLoading)
        case let .showData(viewModel): displayView(viewModel)
        case let .sendManager(manager): router.onNext(self, manager: manager)
        case let .finished(error): finished(error)
        }
    }
}

// MARK: SDUITargetEvents methods
extension SDUIListController: SDUITargetEvent {
    public func eventListening(_ target: SDUITarget) {
        switch target {
        case let .buttonAction(type, value) where type == .deeplink: router.onNext(self, type: type, value: value)
        case let .buttonAction(type, _) where type == .transition: interactor.doRequest(.transitionManager)
        case let .buttonAction(type, _) where type == .sendEvents: interactor.doRequest(.postData)
        case let .sendEventData(event): interactor.doRequest(.updateData(event))
        default: break
        }
    }
}
