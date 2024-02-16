//
//  AuthorViewModel.swift
//  DemoTask
//
//  Created by MacMini-dev on 24/05/23.
//

import Foundation
// MARK: - AuthorViewModel
final class AuthorViewModel {
    var authors:[AuthorModel] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    // fetching data from api
    @MainActor func fetchAuthorsData() {
        self.eventHandler?(.loading)
//        APIManager.shared.fetchAuthorsData { response in
//            self.eventHandler?(.stopLoading)
//            switch response {
//            case .success(let authors):
//                self.authors = authors
//                self.eventHandler?(.dataLoaded)
//            case .failure(let error):
//                print(error)
//                self.eventHandler?(.error(error))
//            }
//        }
        Task {
            do {
                let authorResponseArray: [AuthorModel] = try await APIManager.shared.requestAuthors(url: Constant.API.authorUrl)
                self.authors = authorResponseArray
            } catch {
                
            }
            
        }
        
    }
}

//MARK: - Data Binding
extension AuthorViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
