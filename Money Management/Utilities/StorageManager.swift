//
//  StorageManager.swift
//  Money Management
//
//  Created by Igna on 13/07/2022.
//

import Foundation

class StorageManager {
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    /// Get the document directory
    private func getDocumentDirectory() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    /// Add to the directory the file name and creat an URL
    private func fileURL(fileName: String, in directory: URL) -> URL {
        return directory.appendingPathComponent(fileName)
    }
    
    /// Save MoneyManagement class in a json
    func save(_ data: MoneyManagement, fileName: String) {
        do {
            guard let documentDirectory = getDocumentDirectory() else { print("couldn't find directory"); return }
            try FileManager().createDirectory(at: documentDirectory, withIntermediateDirectories: true)
            let jsonURL = fileURL(fileName: fileName, in: documentDirectory)
            jsonEncoder.outputFormatting = .prettyPrinted
            let jsonData = try jsonEncoder.encode(data)
            try jsonData.write(to: jsonURL)
        } catch {
            print(error)
        }
    }
    
    /// Fetch data of MoneyManagement class in a json
    func fetch(for fileName: String) -> MoneyManagement {
        var result = MoneyManagement()
        do {
            guard let documentDirectory = getDocumentDirectory() else { print("couldn't find directory"); return result }
            let jsonURL = fileURL(fileName: fileName, in: documentDirectory)
            let data = try Data(contentsOf: jsonURL)
            result = try jsonDecoder.decode(MoneyManagement.self, from: data)
        } catch {
            print(error)
        }
        return result
    }
    
}
