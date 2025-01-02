//
//  HomeViewModel.swift
//  savelink
//
//  Created by Jeanpiere Laura on 28/12/24.
//

import Foundation
import Observation

//@Observable
final class HomeViewModel: ObservableObject {
    
    private let repository: LinkRepository
    
    @Published var links: [LinkModel] = []
    @Published var messageString: String?
    
    init(repository: LinkRepository = LinkRepository()) {
        self.repository = repository
        getAllLinks()
    }
    
    func getAllLinks() {
        repository.getAllLinks { [weak self] results in
            switch results {
            case .success(let links):
                self?.links = links
            case .failure(let error):
                self?.messageString = error.localizedDescription
            }
        }
    }
    
    func createNewLink(fromUrl: String) {
        repository.getMetadata(url: fromUrl) { [weak self] results in
            
            switch results {
                case .success(let metadata):
                print("Success: \(metadata.title)")
            case .failure(let error):
                self?.messageString = error.localizedDescription
            }
        }
    }
    
    func updateFavorited(value: LinkModel) {
        let newValue = LinkModel(id: value.id,
                                 title: value.title,
                                 url: value.url,
                                 isFavorited: value.isFavorited ? false : true,
                                 isCompleted: value.isCompleted)
        repository.update(value: newValue)
    }
    
    func updateCompleted(value: LinkModel) {
        let newValue = LinkModel(id: value.id,
                                 title: value.title,
                                 url: value.url,
                                 isFavorited: value.isFavorited,
                                 isCompleted: value.isCompleted ? false : true)
        repository.update(value: newValue)
    }
    
    func deleteLink(value: LinkModel) {
        repository.delete(value: value)
    }
    
}
