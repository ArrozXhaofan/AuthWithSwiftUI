//
//  MetaDataSource.swift
//  savelink
//
//  Created by Jeanpiere Laura on 29/12/24.
//

import Foundation
import LinkPresentation

enum MetaDataError: Error {
    case invalidUrl
}

final class MetaDataSource {
    
    var manager: LPMetadataProvider?
    
    func getMetaData(url: String, completion: @escaping (Result<LinkModel, Error>) -> Void) {
        
        guard let realUrl = URL(string: url) else {
            completion(.failure(MetaDataError.invalidUrl))
            return
        }
        
        manager = LPMetadataProvider()
        manager?.startFetchingMetadata(for: realUrl, completionHandler: { metadata, error in
            
            if let error = error {
                completion(.failure(error))
                print("Error getting metadata: \(error.localizedDescription)")
                return
            }
            
            let data = LinkModel(title: metadata?.title?.description ?? "No title",
                                 url: realUrl.absoluteString,
                                 isFavorited: false,
                                 isCompleted: false)
            
            completion(.success(data))
        })
        
    }
    
}
