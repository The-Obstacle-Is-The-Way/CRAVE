//
//
//  🍒
//  CRAVEApp/Screens/AnalyticsDashboard/Components/PatternVisualizationView.swift
//  Purpose:
//
//

import SwiftUI
import Charts

struct PatternVisualizationView: View {
    let timeOfDayData: [String: Int]
    let patternData: [String: Double]

    var body: some View {
        VStack(spacing: 20) {
            Text("Time of Day Distribution")
                .font(.headline)
            
            TimeOfDayPieChart(data: timeOfDayData)
            
            Text("Pattern Strength")
                .font(.headline)
            
            // Additional pattern visualization components can go here
            
            if !patternData.isEmpty {
                Chart(patternData.sorted(by: { $0.key < $1.key }), id: \.key) { pattern, strength in
                    BarMark(
                        x: .value("Pattern", pattern),
                        y: .value("Strength", strength)
                    )
                }
                .frame(height: 200)
            }
        }
        .padding()
    }
}

#Preview {
    PatternVisualizationView(
        timeOfDayData: [
            "Morning": 3,
            "Afternoon": 5,
            "Evening": 2,
            "Night": 4
        ],
        patternData: [
            "Daily": 0.8,
            "Weekly": 0.6,
            "Monthly": 0.4
        ]
    )
}
