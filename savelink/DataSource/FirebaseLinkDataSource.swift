//
//  FirebaseLinkDataSource.swift
//  savelink
//
//  Created by Jeanpiere Laura on 28/12/24.
//

import Foundation
import FirebaseFirestore


struct LinkModel: Codable, Identifiable {
    @DocumentID var id: String?
    let title: String
    let url: String
    let isFavorited: Bool
    let isCompleted: Bool
    
}

final class FirebaseLinkDataSource {
    
    private let manager = Firestore.firestore()
    private let collection = "links"
    
    func getLinks(completion: @escaping (Result<[LinkModel], Error>) -> Void) {
        
        manager.collection(collection)
            .addSnapshotListener { query, error in
                
                if let realError = error {
                    print("There are a error: \(realError.localizedDescription)")
                    completion(.failure(realError))
                    return
                }
                
                guard let documents = query?.documents.compactMap({$0}) else {
                    completion(.success([]))
                    return
                }
                
                let links = documents.map {try? $0.data(as: LinkModel.self)}
                    .compactMap {$0}
                
                completion(.success(links))
            }
    }
    
    func insertlink(link: LinkModel, completion: @escaping (Result<LinkModel, Error>) -> Void) {
        do {
            try manager.collection(collection).addDocument(from: link)
            completion(.success(link))
        } catch  {
            completion(.failure(error))
        }
    }
    
    func updateLink(value: LinkModel) {
        guard let documentId = value.id else { return }

        do {
            try manager.collection(collection).document(documentId).setData(from: value)
        } catch  {
            print("Error al actualizar")
        }
    }
    
    func deleteLink(value: LinkModel) {
        guard let documentId = value.id else { return }
        manager.collection(collection).document(documentId).delete()
    }
    
}
