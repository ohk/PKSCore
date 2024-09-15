//
//  PKSNetworkPublisherViewModel.swift
//  Examples
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import PKSNetwork
import Combine
import Foundation

/// The ViewModel handles the business logic and interacts with the network layer using Combine.
/// It conforms to `ObservableObject` to allow the view to observe changes.
class PKSNetworkPublisherViewModel: ObservableObject {
    // Published properties to update the view when they change
    @Published var todo: Todo?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var operationResult: String?
    
    // Network handler using PKSNetworkURLSession
    // Initialized with the base URL and token provider
    private var networkHandler: PKSNetworkURLSession
    // A set to store Combine's AnyCancellable instances
    private var cancellables = Set<AnyCancellable>()
    
    // Initialize the network handler
    init() {
        self.networkHandler = PKSNetworkURLSession(
            baseURL: URL(string: "https://jsonplaceholder.typicode.com")!,
            tokenProvider: TokenProvider()
        )
    }
    
    /// Fetches a Todo item from the API using a GET request
    func fetchTodo() {
        isLoading = true
        errorMessage = nil
        operationResult = nil
        
        // Create a GET request to fetch the Todo with ID 1
        let request = PKSRequest(path: "todos/1", method: .get)
        
        // Send the request using the network handler and handle the publisher
        networkHandler.send(request)
            .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
            .sink { completion in
                // Handle completion (success or failure)
                self.isLoading = false
                switch completion {
                case .finished:
                    self.operationResult = "GET operation successful"
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { (fetchedTodo: Todo) in
                // Receive the fetched Todo item
                self.todo = fetchedTodo
            }
            .store(in: &cancellables) // Store the subscription
    }
    
    /// Creates a new Todo item on the server using a POST request
    func createTodo() {
        isLoading = true
        errorMessage = nil
        operationResult = nil
        
        // Create a new Todo object to send
        let newTodo = Todo(userId: 1, id: 0, title: "New Todo", completed: false)
        // Create a POST request with the new Todo as parameters
        let request = PKSRequest(
            path: "todos",
            method: .post,
            parameters: newTodo,
            parametersEncoding: .jsonEncoded
        )
        
        // Send the request and handle the publisher
        networkHandler.send(request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Handle completion
                self.isLoading = false
                switch completion {
                case .finished:
                    self.operationResult = "POST operation successful"
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { (createdTodo: Todo) in
                // Receive the created Todo item
                self.todo = createdTodo
            }
            .store(in: &cancellables)
    }
    
    /// Updates the current Todo item on the server using a PUT request
    func updateTodo() {
        // Ensure there is a current Todo to update
        guard let currentTodo = todo else {
            errorMessage = "No todo to update"
            return
        }
        
        isLoading = true
        errorMessage = nil
        operationResult = nil
        
        // Create an updated Todo object
        let updatedTodo = Todo(
            userId: currentTodo.userId,
            id: currentTodo.id,
            title: "Updated Todo",
            completed: true
        )
        // Create a PUT request to update the Todo with the given ID
        let request = PKSRequest(
            path: "todos/\(currentTodo.id ?? 1)",
            method: .put,
            parameters: updatedTodo,
            parametersEncoding: .jsonEncoded
        )
        
        // Send the request and handle the publisher
        networkHandler.send(request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Handle completion
                self.isLoading = false
                switch completion {
                case .finished:
                    self.operationResult = "PUT operation successful"
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { (updatedTodo: Todo) in
                // Receive the updated Todo item
                self.todo = updatedTodo
            }
            .store(in: &cancellables)
    }
    
    /// Deletes the current Todo item on the server using a DELETE request
    func deleteTodo() {
        // Ensure there is a current Todo to delete
        guard let currentTodo = todo else {
            errorMessage = "No todo to delete"
            return
        }
        
        isLoading = true
        errorMessage = nil
        operationResult = nil
        
        // Create a DELETE request for the Todo with the given ID
        let request = PKSRequest(
            path: "todos/\(currentTodo.id ?? 1)",
            method: .delete
        )
        
        // Send the request and handle the publisher
        networkHandler.send(request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Handle completion
                self.isLoading = false
                switch completion {
                case .finished:
                    self.operationResult = "DELETE operation successful"
                    // Clear the todo property since it has been deleted
                    self.todo = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { _ in
                // No value expected for DELETE request
            }
            .store(in: &cancellables)
    }
}
