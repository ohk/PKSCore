//
//  VPKSNetworkAsyncAwaitiewModel.swift
//  Examples
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import Foundation
import PKSNetwork

/// The ViewModel handles the business logic and interacts with the network layer.
/// It conforms to `ObservableObject` to allow the view to observe changes.
@MainActor
class PKSNetworkAsyncAwaitViewModel: ObservableObject {
    // Published properties to update the view when they change
    @Published var todo: Todo?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var operationResult: String?

    // Network handler using PKSNetworkURLSession
    // Initialized with the base URL and token provider
    private var networkHandler: PKSNetworkURLSession = .init(
        baseURL: URL(string: "https://jsonplaceholder.typicode.com")!,
        tokenProvider: TokenProvider()
    )

    /// Fetches a Todo item from the API using a GET request
    func fetchTodo() {
        Task {
            isLoading = true
            errorMessage = nil
            operationResult = nil
            do {
                // Create a GET request to fetch the Todo with ID 1
                let request = PKSRequest(
                    path: "todos/1",
                    method: .get,
                    cachePolicy: .reloadRevalidatingCacheData
                )
                // Send the request using the network handler
                todo = try await networkHandler.send(request)
                operationResult = "GET operation successful"
            } catch {
                // Handle any errors that occur during the network request
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    /// Creates a new Todo item on the server using a POST request
    func createTodo() {
        Task {
            isLoading = true
            errorMessage = nil
            operationResult = nil
            do {
                // Create a new TodoRequest object
                let newTodo = TodoRequest(title: "New Todo", completed: false, userId: 1)
                // Create a POST request with the new Todo as the parameters
                let request = PKSRequest(
                    path: "todos",
                    method: .post,
                    parameters: newTodo,
                    parametersEncoding: .jsonEncoded
                )
                // Send the request and receive the created Todo
                let createdTodo: Todo = try await networkHandler.send(request)
                // Update the todo property with the newly created Todo
                todo = createdTodo
                operationResult = "POST operation successful. Created Todo with ID: \(String(describing: createdTodo.id))"
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    /// Updates the current Todo item on the server using a PATCH request
    func updateTodo() {
        Task {
            isLoading = true
            errorMessage = nil
            operationResult = nil
            do {
                // Ensure there is a current Todo to update
                guard let currentTodo = todo else {
                    errorMessage = "No todo to update"
                    isLoading = false
                    return
                }
                // Create an updated TodoRequest object
                let updatedTodoRequest = TodoRequest(
                    title: "Updated Todo",
                    completed: true,
                    userId: currentTodo.userId ?? 1
                )
                // Create a PATCH request to update the Todo with the given ID
                let request = PKSRequest(
                    path: "todos/\(currentTodo.id ?? 1)",
                    method: .patch,
                    parameters: updatedTodoRequest,
                    parametersEncoding: .jsonEncoded
                )
                // Send the request and receive the updated Todo
                let updatedTodo: Todo = try await networkHandler.send(request)
                // Update the todo property with the updated Todo
                todo = updatedTodo
                operationResult = "PUT operation successful. Updated Todo with ID: \(String(describing: updatedTodo.id))"
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    /// Deletes the current Todo item on the server using a DELETE request
    func deleteTodo() {
        Task {
            isLoading = true
            errorMessage = nil
            operationResult = nil
            do {
                // Ensure there is a current Todo to delete
                guard let currentTodo = todo else {
                    errorMessage = "No todo to delete"
                    isLoading = false
                    return
                }
                // Create a DELETE request for the Todo with the given ID
                let request = PKSRequest(
                    path: "todos/\(currentTodo.id ?? 1)",
                    method: .delete
                )
                // Send the request
                try await networkHandler.send(request)
                // Clear the todo property since it has been deleted
                todo = nil
                operationResult = "DELETE operation successful. Deleted Todo with ID: \(String(describing: currentTodo.id))"
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
