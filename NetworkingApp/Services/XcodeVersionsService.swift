//
//  XcodeVersionsService.swift
//  NetworkingApp
//
//  Created by Justin Peckner on 2/17/21.
//  Copyright © 2021 Aspiration Partners. All rights reserved.
//

import Foundation

class XcodeVersionsService {

    func fetchVersions(completion: @escaping ([XcodeVersion]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Source for data in file: https://xcodereleases.com/data.json
            let fileURL = Bundle.main.url(forResource: "xcode_versions", withExtension: "json")!
            let data = try! Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            let versions = try! jsonDecoder.decode([XcodeVersion].self, from: data)
            completion(versions)
        }
    }

    /**
     Fetch remote data and tries to parse it as a `Codable` object
     
     - Parameters:
        - completion: Contains either response or error after fetching some remote data
     
     - Important: Completion will return data or error, but never both
     
     - Author: Omar Barrera Peña
     */
    func fetchRemoteData(completion: @escaping RemoteDataAlias) {
        DispatchQueue.main.async {
            do {
                guard let url = URL(string: "https://xcodereleases.com/data.json") else { throw "Error loading data" }
                let data = try Data(contentsOf: url)
                let fetchedData = try JSONDecoder().decode([RemoteData].self, from: data)
                completion(fetchedData, nil)
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
    }
}

/**
 Contains the data or error obtained from a URL
 
 - Parameters:
    - data: Array of `RemoteData` objects
    - errorMessage: The error returned after failed to obtain data from an URL or trying to parse it
 
 - Author: Omar Barrera Peña
 */
typealias RemoteDataAlias = (_ data: [RemoteData]?, _ errorMessage: String?) -> ()
