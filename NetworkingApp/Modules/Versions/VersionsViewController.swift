//
//  VersionsViewController.swift
//  NetworkingApp
//
//  Created by Justin Peckner on 2/17/21.
//  Copyright © 2021 Aspiration Partners. All rights reserved.
//

import UIKit

class VersionsViewController: UIViewController {

    private let versionsView = VersionsView()

    override func loadView() {
        view = versionsView
        view.backgroundColor = .systemBackground
    }

}

extension VersionsViewController {

    func render() {
        versionsView.render()
    }
    
    /**
     Sets the downloaded data to a table view with a simple animation
     
     - Parameters:
        - data: Arrays of `RemoteData` objects to be set
     
     - Author: Omar Barrera Peña
     */
    func setData(_ data: [RemoteData]) {
        versionsView.loadData(data)
    }
    
    /**
     Shows an error on the screen with a simple animation
     
     - Parameters:
        - message: Error message to be shown on screen
     
     - Author: Omar Barrera Peña
     */
    func showError(_ message: String) {
        versionsView.showError(message)
    }
}
