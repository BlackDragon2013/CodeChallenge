//
//  VersionsCoordinator.swift
//  NetworkingApp
//
//  Created by Justin Peckner on 2/17/21.
//  Copyright © 2021 Aspiration Partners. All rights reserved.
//

import UIKit

class VersionsCoordinator {

    enum State {
        case idle
        case loading
        case success
        case failure
    }

    private let versionsService = XcodeVersionsService()
    private let viewController = VersionsViewController()
    fileprivate var versions: [XcodeVersion] = []
    fileprivate var data: [RemoteData] = []
    fileprivate var errorMessage: String!
    
    private var state: State = .idle {
        didSet {
            let currentState = state
            switch currentState {
                case .idle:
                    //inactive state
                    break
                case .loading:
                    fetchRemoteData()
                case .success:
                    viewController.setData(data)
                case .failure:
                    viewController.showError(errorMessage)
            }
        }
    }

    var rootViewController: UIViewController {
        viewController
    }

    func start() {
        viewController.render()
        state = .loading
    }

    fileprivate func fetchRemoteData() {
        versionsService.fetchRemoteData { [self] fetchedData, error in
            if let fetchedData = fetchedData {
                if fetchedData.isEmpty {
                    errorMessage = "No data found"
                    state = .failure
                } else {
                    data = fetchedData
                    state = .success
                }
            } else if let error = error {
                errorMessage = error
                state = .failure
            }
        }
    }
}
