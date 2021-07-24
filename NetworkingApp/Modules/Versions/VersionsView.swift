//
//  VersionsView.swift
//  NetworkingApp
//
//  Created by Justin Peckner on 2/17/21.
//  Copyright © 2021 Aspiration Partners. All rights reserved.
//

import UIKit

class VersionsView: UIView {

    private let spinner = UIActivityIndicatorView(style: .medium)
    private let tableView = UITableView()
    private let textLabel = UILabel()
    var versions: [RemoteData] = []

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        setupTable()
        setupSpinner()
        setupTextLabel()
        setupStyling()
    }

    private func setupTable() {
        addSubviewAndEdgeConstraints(tableView)
    }

    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        addConstraints([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        addConstraints([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupStyling() {
        backgroundColor = .white
        spinner.backgroundColor = .clear
        tableView.backgroundColor = .clear
        textLabel.backgroundColor = .clear
        textLabel.textColor = .systemRed
    }

    fileprivate func loadDataInTable(_ data: [RemoteData]) {
        tableView.beginUpdates()
        versions = data
        var indicesToInsert: [IndexPath] = []
        for i in 0 ..< versions.count {
            indicesToInsert.append(IndexPath(row: i, section: 0))
        }
        if versions.isEmpty {
            textLabel.alpha = 1
        }
        tableView.insertRows(at: indicesToInsert, with: .fade)
        tableView.endUpdates()
    }
}

extension VersionsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return versions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VersionCell
        let data = versions[indexPath.row]
        cell.nameLabel.text = data.name.rawValue
        cell.versionLabel.text = "Version: \(data.version.number) (\(data.version.build))"
        cell.releaseDateLabel.text = "Release date: \(data.date.dateString() ?? "N/A")"
        if let isRelease = data.version.release.release, isRelease {
            cell.statusLabel.text = "Release"
        } else {
            if let beta = data.version.release.beta {
                cell.statusLabel.text = "Beta \(beta)"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension VersionsView {

    func render() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VersionCell.self, forCellReuseIdentifier: "cell")
        spinner.alpha = 0
        tableView.alpha = 0
        textLabel.alpha = 0
        spinner.startAnimating()
        UIView.animate(withDuration: 0.3) { [self] in
            spinner.alpha = 1
        }
    }

    /**
     Shows fetched data on the screen and coordinates the animation to display it
     
     - Parameters:
        - data: Fetched data to be shown
     
     - Author: Omar Barrera Peña
     */
    func loadData(_ data: [RemoteData]) {
        UIView.animate(withDuration: 0.2) { [self] in
            spinner.alpha = 0
        } completion: { [self] _ in
            spinner.stopAnimating()
            UIView.animate(withDuration: 0.2) {
                tableView.alpha = 1
            } completion: { _ in
                loadDataInTable(data)
            }
        }
    }
    
    /**
     Shows error message on the screen and coordinates the animation to display it
     
     - Parameters:
        - message: Error message to be shown on screen
     
     - Author: Omar Barrera Peña
     */
    func showError(_ message: String) {
        textLabel.text = message
        UIView.animate(withDuration: 0.2) { [self] in
            spinner.alpha = 0
        } completion: { [self] _ in
            spinner.stopAnimating()
            UIView.animate(withDuration: 0.2) {
                textLabel.alpha = 1
            }
        }
    }
}
