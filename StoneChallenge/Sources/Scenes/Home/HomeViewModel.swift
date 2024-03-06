//
//  HomeViewModel.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 13/12/22.
//

import Foundation

class HomeViewModel  {
    
    let service = APIService()
    var characters: [CharacterInfos] = []
    var page: Int = 1
    var canFetch: Bool = true
    var name: String?
    
    weak var delegate: CollectionDelegate?
    
    func getCharacters() {
        if !canFetch { return }
        
        canFetch = false
        
        service.getCharacters(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                    case .failure:
                        self.delegate?.reloadCollectionData()
                    case .success(let characters):
                        self.characters += characters
                        self.page += 1
                        self.delegate?.reloadCollectionData()
                }
                self.canFetch = true
            }
        }
    }
}


