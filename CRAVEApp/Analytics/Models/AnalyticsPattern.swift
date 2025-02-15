//
//  🍒
//  CRAVEApp/Analytics/Models/AnalyticsPattern.swift
//  Purpose: Defines pattern recognition and analysis for craving behaviors
//

import Foundation
import SwiftData

// MARK: - CravingAnalytics Struct (NEW)
// Define this struct to represent the data used for pattern matching.
struct CravingAnalytics {
    let timestamp: Date
    let triggers: Set<String> // Assuming triggers are strings
    let intensity: Int        // Assuming intensity is available
    // Add other relevant properties as needed
}

// MARK: - Pattern Protocol
protocol AnalyticsPattern: Codable, Identifiable {
    var id: UUID { get }
    var patternType: PatternType { get } // Use the enum defined below
    var confidence: Double { get }
    var frequency: Int { get }
    var firstObserved: Date { get }
    var lastObserved: Date { get }
    var metadata: PatternMetadata { get }
    
    func matches(_ analytics: CravingAnalytics) -> Bool // Use CravingAnalytics
    func updateWith(_ analytics: CravingAnalytics) // Use CravingAnalytics
    func calculateConfidence() -> Double
}

// MARK: - Base Pattern Implementation
class BasePattern: AnalyticsPattern {
    let id: UUID
    let patternType: PatternType
    private(set) var confidence: Double
    private(set) var frequency: Int
    private(set) var firstObserved: Date
    private(set) var lastObserved: Date
    private(set) var metadata: PatternMetadata
    
    private var observations: [PatternObservation]
    
    init(type: PatternType, metadata: PatternMetadata) {
        self.id = UUID()
        self.patternType = type
        self.confidence = 0.0
        self.frequency = 0
        self.firstObserved = Date()
        self.lastObserved = Date()
        self.metadata = metadata
        self.observations = []
    }
    
    func matches(_ analytics: CravingAnalytics) -> Bool {
        fatalError("Must be implemented by subclass")
    }
    
    func updateWith(_ analytics: CravingAnalytics) {
        frequency += 1
        lastObserved = analytics.timestamp
        
        let observation = PatternObservation(
            timestamp: analytics.timestamp,
            strength: calculateStrength(for: analytics)
        )
        observations.append(observation)
        
        // Now we update confidence using the concrete implementation.
        confidence = calculateConfidence()
        updateMetadata(with: analytics)
    }
    
    // Changed from private to internal so it can be overridden
    func calculateStrength(for analytics: CravingAnalytics) -> Double {
        // Default implementation - override in subclasses if needed
        return 1.0
    }
    
    // **New Implementation:** Conforming to protocol requirement
    func calculateConfidence() -> Double {
        guard !observations.isEmpty else { return 0.0 }
        
        let totalStrength = observations.reduce(0.0) { $0 + $1.strength }
        let averageStrength = totalStrength / Double(observations.count)
        
        // Factor in frequency and time span
        let timeSpan = lastObserved.timeIntervalSince(firstObserved)
        let frequencyFactor = min(Double(frequency) / 10.0, 1.0) // Cap at 10 observations
        let timeFactor = min(timeSpan / (30 * 24 * 3600), 1.0)    // Cap at 30 days
        
        return averageStrength * frequencyFactor * timeFactor
    }
    
    private func updateMetadata(with analytics: CravingAnalytics) {
        metadata.updateWith(analytics)
    }
    
    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case id, patternType, confidence, frequency, firstObserved, lastObserved, metadata, observations
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        patternType = try container.decode(PatternType.self, forKey: .patternType)
        confidence = try container.decode(Double.self, forKey: .confidence)
        frequency = try container.decode(Int.self, forKey: .frequency)
        firstObserved = try container.decode(Date.self, forKey: .firstObserved)
        lastObserved = try container.decode(Date.self, forKey: .lastObserved)
        metadata = try container.decode(PatternMetadata.self, forKey: .metadata)
        observations = try container.decode([PatternObservation].self, forKey: .observations)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(patternType, forKey: .patternType)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(firstObserved, forKey: .firstObserved)
        try container.encode(lastObserved, forKey: .lastObserved)
        try container.encode(metadata, forKey: .metadata)
        try container.encode(observations, forKey: .observations)
    }
}

// MARK: - Specific Pattern Types
class TimeBasedPattern: BasePattern {
    private let timeWindow: TimeInterval
    private let targetHour: Int
    
    init(hour: Int, windowMinutes: Int) {
        self.targetHour = hour
        self.timeWindow = TimeInterval(windowMinutes * 60)
        super.init(type: .timeBased, metadata: PatternMetadata())
    }
    
    override func matches(_ analytics: CravingAnalytics) -> Bool {
        let hour = Calendar.current.component(.hour, from: analytics.timestamp)
        let minuteDifference = abs(Double(hour - targetHour) * 3600)
        return minuteDifference <= timeWindow
    }
    
    override func calculateStrength(for analytics: CravingAnalytics) -> Double {
        let hour = Calendar.current.component(.hour, from: analytics.timestamp)
        let hourDifference = abs(Double(hour - targetHour))
        return max(1.0 - (hourDifference / 12.0), 0.0)
    }
    
    // MARK: - Codable Conformance for TimeBasedPattern
    enum TimeBasedPatternCodingKeys: String, CodingKey {
        case timeWindow, targetHour
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TimeBasedPatternCodingKeys.self)
        self.timeWindow = try container.decode(TimeInterval.self, forKey: .timeWindow)
        self.targetHour = try container.decode(Int.self, forKey: .targetHour)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
         try super.encode(to: encoder)
         var container = encoder.container(keyedBy: TimeBasedPatternCodingKeys.self)
         try container.encode(timeWindow, forKey: .timeWindow)
         try container.encode(targetHour, forKey: .targetHour)
     }
}

class TriggerBasedPattern: BasePattern {
    private let triggerSet: Set<String>
    
    init(triggers: Set<String>) {
        self.triggerSet = triggers
        super.init(type: .triggerBased, metadata: PatternMetadata())
    }
    
    override func matches(_ analytics: CravingAnalytics) -> Bool {
        !triggerSet.isDisjoint(with: analytics.triggers)
    }
    
    override func calculateStrength(for analytics: CravingAnalytics) -> Double {
        let commonTriggers = triggerSet.intersection(analytics.triggers)
        return Double(commonTriggers.count) / Double(triggerSet.count)
    }
    
    // MARK: - Codable Conformance for TriggerBasedPattern
    enum TriggerBasedPatternCodingKeys: String, CodingKey {
        case triggerSet
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TriggerBasedPatternCodingKeys.self)
        self.triggerSet = try container.decode(Set<String>.self, forKey: .triggerSet)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: TriggerBasedPatternCodingKeys.self)
        try container.encode(triggerSet, forKey: .triggerSet)
    }
}

// MARK: - Supporting Types
enum PatternType: String, Codable {
    case timeBased
    case locationBased
    case triggerBased
    case contextBased
    case combinedBased
}

struct PatternMetadata: Codable {
    var observations: Int = 0
    var averageIntensity: Double = 0.0
    var successRate: Double = 0.0
    var contextualFactors: [String: Int] = [:]
    
    mutating func updateWith(_ analytics: CravingAnalytics) {
        observations += 1
        averageIntensity = ((averageIntensity * Double(observations - 1)) + Double(analytics.intensity)) / Double(observations)
        // Update other metadata as needed...
    }
}

struct PatternObservation: Codable {
    let timestamp: Date
    let strength: Double
}

// MARK: - Pattern Recognition Engine (Placeholder)
class PatternRecognitionEngine {
    private var patterns: [any AnalyticsPattern] = [] // Use 'any'
    private let configuration: PatternConfiguration
    
    init(configuration: PatternConfiguration = .default) {
        self.configuration = configuration
    }
    
    func processAnalytics(_ analytics: CravingAnalytics) {
        updateExistingPatterns(with: analytics)
        if let newPattern = detectNewPattern(from: analytics) {
            patterns.append(newPattern)
        }
        prunePatterns()
    }
    
    private func updateExistingPatterns(with analytics: CravingAnalytics) {
        patterns.forEach { pattern in
            if pattern.matches(analytics) {
                pattern.updateWith(analytics)
            }
        }
    }
    
    private func detectNewPattern(from analytics: CravingAnalytics) -> (any AnalyticsPattern)? {
        // Implement pattern detection logic
        return nil
    }
    
    private func prunePatterns() {
        patterns.removeAll { $0.confidence < configuration.minimumConfidence }
    }
}

// MARK: - Configuration
struct PatternConfiguration {
    let minimumConfidence: Double
    let minimumObservations: Int
    let maximumPatterns: Int
    
    static let `default` = PatternConfiguration(
        minimumConfidence: 0.3,
        minimumObservations: 3,
        maximumPatterns: 50
    )
}

// MARK: - Testing Support
extension BasePattern {
    static func mock(type: PatternType = .timeBased) -> BasePattern {
        BasePattern(type: type, metadata: PatternMetadata())
    }
}
