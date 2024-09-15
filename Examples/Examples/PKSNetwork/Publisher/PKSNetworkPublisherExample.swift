//
//  PKSNetworkPublisherExample.swift
//  Examples
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import SwiftUI

// MARK: - View

/// The main view displaying the Todo item and buttons to perform network operations.
struct PKSNetworkPublisherExample: View {
    // Observed ViewModel to update the view when data changes
    @StateObject private var viewModel = PKSNetworkPublisherViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Show a progress view if loading
                if viewModel.isLoading {
                    ProgressView()
                }
                // Show an error message if there is an error
                else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                // Show the todo details if available
                else if let todo = viewModel.todo {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(todo.title ?? "")
                            .font(.headline)
                        Text(todo.completed ?? false ? "Completed" : "Not Completed")
                            .font(.body)
                        Text("ID: \(String(describing: todo.id))")
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                
                // Show the operation result message if available
                if let operationResult = viewModel.operationResult {
                    Text(operationResult)
                        .font(.caption)
                        .foregroundColor(.green)
                }
                
                // Buttons to perform CRUD operations
                HStack(spacing: 10) {
                    Button("GET") {
                        // Fetch a todo item from the server
                        viewModel.fetchTodo()
                    }
                    Button("POST") {
                        // Create a new todo item on the server
                        viewModel.createTodo()
                    }
                    Button("PUT") {
                        // Update the current todo item on the server
                        viewModel.updateTodo()
                    }
                    Button("DELETE") {
                        // Delete the current todo item from the server
                        viewModel.deleteTodo()
                    }
                }
                // Disable buttons when loading
                .disabled(viewModel.isLoading)
            }
            .padding()
        }
        // Set the navigation title
        .navigationTitle("Publisher Example")
    }
}

// MARK: - Preview

#Preview {
    PKSNetworkPublisherExample()
}
