//
//  StringExtension.swift
//  NetworkingApp
//
//  Created by Omar Barrera Peña on 23/07/21.
//  Copyright © 2021 Aspiration Partners. All rights reserved.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
