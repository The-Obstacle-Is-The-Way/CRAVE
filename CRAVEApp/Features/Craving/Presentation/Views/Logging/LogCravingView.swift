//
//  🍒
//  CRAVEApp/Screens/LogCraving/LogCravingView.swift
//  Purpose: A view for logging a craving.
//

import SwiftUI
import SwiftData

struct LogCravingView: View {
    @Environment(\.modelContext) var modelContext // Correct: Get from environment
    @StateObject private var viewModel = LogCravingViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                CraveTextEditor(text: $viewModel.cravingText, placeholder: "Enter craving...")
                    .padding()

                CraveButton(title: "Log Craving") {
                    viewModel.addCraving(modelContext: modelContext) { success in
                        if success {
                            // Success
                        } else {
                            alertMessage = "Please enter a valid craving (at least 3 characters)."
                            showAlert = true
                        }
                    }
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Log Craving")
            //UPDATE: Use the new title font
            .navigationBarTitleDisplayMode(.inline)
              .toolbar {
                  ToolbarItem(placement: .principal) {
                      Text("Log Craving")
                          .font(CRAVEDesignSystem.Typography.headline)
                          .foregroundColor(CRAVEDesignSystem.Colors.textPrimary)
                  }
              }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Input"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
