//
//  SearchBlogNetwork.swift
//  SearchDaumBlog
//
//  Created by 유준상 on 2022/08/07.
//

import RxSwift
import Foundation

enum SearchNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
}

extension SearchNetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invalidURL:
      return NSLocalizedString("Description of invalid URL", comment: "Invalid URL")
    case .invalidJSON:
      return NSLocalizedString("Description of invalid JSON", comment: "Invalid JSON")
    case.networkError:
        return NSLocalizedString("Description of network error", comment: "Network error")
    }
  }
}

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK e50c7b55e0ff280133362c3c66277c8c", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                    .just(.failure(.networkError))
            }
            .asSingle()
    }
}
