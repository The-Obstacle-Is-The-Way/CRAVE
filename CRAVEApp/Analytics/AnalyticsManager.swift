//
//  AnalyticsManager.swift
//  CRAVE
//

import Foundation

@MainActor
class AnalyticsManager {
    let cravingManager: CravingManager
    private let frequencyQuery = FrequencyQuery()
    private let timeOfDayQuery = TimeOfDayQuery()
    
    init(cravingManager: CravingManager) {
        self.cravingManager = cravingManager
    }
    
    func getBasicStats() async -> BasicAnalyticsResult {
        let allCravings = await cravingManager.fetchAllCravings()
        
        let freqDict = frequencyQuery.cravingsPerDay(using: allCravings)
        let dayParts = timeOfDayQuery.cravingsByTimeSlot(using: allCravings)
        
        return BasicAnalyticsResult(
            cravingsPerDay: freqDict,
            cravingsByTimeSlot: dayParts
        )
    }
}
