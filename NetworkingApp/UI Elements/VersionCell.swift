//
//  VersionCell.swift
//  NetworkingApp
//
//  Created by Omar Barrera Peña on 23/07/21.
//  Copyright © 2021 Aspiration Partners. All rights reserved.
//

import UIKit

class VersionCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var statusLabel: UILabel!
    var versionLabel: UILabel!
    var releaseDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        drawUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        drawUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawUI()
    }
    
    func drawUI() {
        setUpNameLabel()
        setUpStatusLabel()
        setUpVersionLabel()
        setUpReleaseDateLabel()
    }
    
    func setUpNameLabel() {
        let frame = CGRect(x: 8, y: 8, width: bounds.size.width - 128, height: 22)
        nameLabel = UILabel(frame: frame)
        nameLabel.textColor = UIColor(named: "Text Color")
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(nameLabel)
    }
    
    func setUpStatusLabel() {
        let frame = CGRect(x: bounds.size.width - 140, y: 8, width: bounds.size.width - 188, height: 22)
        statusLabel = UILabel(frame: frame)
        statusLabel.textColor = UIColor(named: "Text Color")
        statusLabel.textAlignment = .right
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(statusLabel)
    }
    
    func setUpVersionLabel() {
        let frame = CGRect(x: 8, y: 32, width: (bounds.size.width / 2) - 12, height: 18)
        versionLabel = UILabel(frame: frame)
        versionLabel.textColor = UIColor(named: "Text Color")
        versionLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(versionLabel)
        versionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: (bounds.size.width / 2) - 12).isActive = true
    }
    
    func setUpReleaseDateLabel() {
        let frame = CGRect(x: (bounds.size.width / 2) + 4, y: 32, width: (bounds.size.width / 2) - 12, height: 18)
        releaseDateLabel = UILabel(frame: frame)
        releaseDateLabel.textColor = UIColor(named: "Text Color")
        releaseDateLabel.textAlignment = .right
        releaseDateLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(releaseDateLabel)
        releaseDateLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: (bounds.size.width / 2) - 12).isActive = true
    }
}
