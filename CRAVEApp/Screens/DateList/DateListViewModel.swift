// DateListViewModel.swift
import SwiftUI
import Foundation

@Observable
class DateListViewModel {
    var cravingsByDate: [Date: [Craving]] = [:]
    var dateSections: [Date] = []

    func setData(_ cravings: [Craving]) {
        let calendar = Calendar.current
        var temp: [Date: [Craving]] = [:]

        for craving in cravings {
            let comps = calendar.dateComponents([.year, .month, .day], from: craving.timestamp)
            if let dayDate = calendar.date(from: comps) {
                temp[dayDate, default: []].append(craving)
            }
        }

        dateSections = temp.keys.sorted(by: >)
        cravingsByDate = temp
    }
}
