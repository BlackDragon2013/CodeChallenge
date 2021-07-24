//
//  RemoteData.swift
//  NetworkingApp
//
//  Created by Omar Barrera Peña on 23/07/21.
//  Copyright © 2021 Aspiration Partners. All rights reserved.
//

import Foundation

struct RemoteData: Codable {
    let compilers: Compilers?
    let requires: String
    let date: DateDetail
    let links: Links?
    let version: Version
    let sdks: SDKs?
    let name: Name
    let checksums: Checksums?
}

struct Checksums: Codable {
    let sha1: String
}

struct Compilers: Codable {
    let clang, swift, llvm, llvmGCC, gcc: [Clang]?
    
    enum CodingKeys: String, CodingKey {
        case clang, swift, llvm, gcc
        case llvmGCC = "llvm_gcc"
    }
}

struct Clang: Codable {
    let number, build: String?
    let release: ClangRelease
}

struct ClangRelease: Codable {
    let release: Bool
}

struct DateDetail: Codable {
    let year, month, day: Int
    
    func dateString() -> String? {
        let string = "\(day)\(month)\(year)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        guard let date = dateFormatter.date(from: string) else { return nil }
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct Links: Codable {
    let notes, download: Download?
}

struct Download: Codable {
    let url: String
}

enum Name: String, Codable {
    case xcode = "Xcode"
    case xcTools = "Xcode Tools"
    case xcUniversal = "Xcode (Universal)"
}

struct SDKs: Codable {
    let macOS, tvOS, iOS, watchOS: [Clang]?
}

struct Version: Codable {
    let number, build: String
    let release: VersionRelease
}

struct VersionRelease: Codable {
    let beta, rc, gmSeed, dp: Int?
    let release, gm: Bool?
}
