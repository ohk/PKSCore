import Foundation
import Combine

/// URLSession-based implementation of the PKSNetwork protocol.
public class PKSNetworkURLSession: PKSNetwork {
    private let session: URLSession
    private let baseURL: URL
    private let tokenProvider: PKSTokenProvider
    
    /// Initializes a new instance of PKSNetworkURLSession.
    ///
    /// - Parameters:
    ///   - baseURL: The base URL for all network requests.
    ///   - tokenProvider: The provider for authentication tokens.
    ///   - configuration: The URLSession configuration to use.
    public init(baseURL: URL, tokenProvider: PKSTokenProvider, configuration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.tokenProvider = tokenProvider
        self.session = URLSession(configuration: configuration)
    }
    
    /// Sends a network request and returns a publisher with the response.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: A publisher that emits the response data or an error.
    public func send<T: Decodable, P: Encodable>(_ request: PKSRequest<P>) -> AnyPublisher<T, PKSNetworkError> {
        return Future { promise in
            Task {
                do {
                    let urlRequest = try await self.createURLRequest(from: request)
                    let (data, response) = try await self.session.data(for: urlRequest)
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        promise(.failure(.invalidResponse))
                        return
                    }
                    
                    if 200...299 ~= httpResponse.statusCode {
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            promise(.success(decodedData))
                        } catch {
                            promise(.failure(.decodingFailed))
                        }
                    } else if httpResponse.statusCode == 401 {
                        promise(.failure(.authenticationFailed))
                    } else {
                        promise(.failure(.requestFailed))
                    }
                } catch {
                    if let networkError = error as? PKSNetworkError {
                        promise(.failure(networkError))
                    } else {
                        promise(.failure(.unknown))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// Sends a network request and returns the response asynchronously.
    ///
    /// - Parameter request: The request to be sent.
    /// - Returns: The decoded response data.
    /// - Throws: A PKSNetworkError if the request fails.
    public func send<T: Decodable, P: Encodable>(_ request: PKSRequest<P>) async throws -> T {
        do {
            let urlRequest = try await self.createURLRequest(from: request)
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PKSNetworkError.invalidResponse
            }
            
            if 200...299 ~= httpResponse.statusCode {
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw PKSNetworkError.decodingFailed
                }
            } else if httpResponse.statusCode == 401 {
                throw PKSNetworkError.authenticationFailed
            } else {
                throw PKSNetworkError.requestFailed
            }
        } catch {
            if let networkError = error as? PKSNetworkError {
                throw networkError
            } else {
                throw PKSNetworkError.unknown
            }
        }
    }
    
    /// Creates a URLRequest from a PKSRequest.
    ///
    /// - Parameter request: The PKSRequest to convert.
    /// - Returns: A URLRequest configured based on the PKSRequest.
    /// - Throws: A PKSNetworkError if the request creation fails.
    private func createURLRequest<P: Encodable>(from request: PKSRequest<P>) async throws -> URLRequest {
        let url = baseURL.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.timeoutInterval = request.timeoutInterval
        urlRequest.cachePolicy = request.cachePolicy.toURLRequestCachePolicy()
        
        if let parameters = request.parameters {
            try PKSParameterEncoder.encode(urlRequest: &urlRequest, with: parameters, using: request.parametersEncoding)
        }
        
        if request.requiresAuthentication {
            do {
                let token = try await tokenProvider.getToken()
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } catch {
                throw PKSNetworkError.authenticationFailed
            }
        }
        
        return urlRequest
    }
}





