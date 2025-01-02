//
//  LinkRepository.swift
//  savelink
//
//  Created by Jeanpiere Laura on 28/12/24.
//

import Foundation
import FirebaseFirestore

final class LinkRepository {
    
    private let datasource: FirebaseLinkDataSource
    private let metadata: MetaDataSource
    
    init(datasource: FirebaseLinkDataSource = FirebaseLinkDataSource(),
         metadata: MetaDataSource = MetaDataSource()) {
        self.datasource = datasource
        self.metadata = metadata
    }
    
    func getAllLinks(completion: @escaping (Result<[LinkModel], Error>) -> Void) {
        datasource.getLinks(completion: completion)
    }
    
    func getMetadata(url: String, completion: @escaping (Result<LinkModel, Error>) -> Void) {
        metadata.getMetaData(url: url) { [weak self] results in
            switch results {
            case .success(let meta):
                self?.datasource.insertlink(link: meta, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(value: LinkModel) {
        datasource.updateLink(value: value)
    }
    
    func delete(value: LinkModel) {
        datasource.deleteLink(value: value)
    }
    
}
