//
//
//  🍒
//  CRAVEApp/Analytics/AnalyticsCoordinator.swift
//  Purpose: Coordinates and orchestrates all analytics operations across the app
//
//
//
// CRAVEApp/Analytics/AnalyticsReporter.swift
// Purpose: Generates and manages analytics reports with customizable formats and delivery mechanisms
//

import Foundation
import Combine

@MainActor
final class AnalyticsReporter: ObservableObject {
    @Published private(set) var reportGenerationState: ReportGenerationState = .idle
    @Published private(set) var lastReport: Report?

    private let analyticsStorage: AnalyticsStorage
    private var cancellables = Set<AnyCancellable>()

    init(analyticsStorage: AnalyticsStorage) {
        self.analyticsStorage = analyticsStorage
    }

    func generateReport(for type: ReportType, format: ReportFormat) async throws -> Report {
        reportGenerationState = .generating

        let reportData = ReportData(
            title: "Analytics Report",
            content: "Generated report for \(type.rawValue)"
        )

        let report = Report(
            metadata: ReportMetadata(
                reportType: type,
                format: format,
                creationDate: Date()
            ),
            data: reportData,
            format: format,
            generationDate: Date(),
            state: .completed
        )

        lastReport = report
        reportGenerationState = .completed
        return report
    }

    func handleReport(_ report: Report) async {
        // Store report data
        print("Handling report: \(report.metadata.reportType)")
    }

    func handleInsights(_ insights: [any AnalyticsInsight]) async {
        // Process insights
        print("Processing \(insights.count) insights")
    }

    func handlePredictions(_ predictions: [any AnalyticsPrediction]) async {
        // Process predictions
        print("Processing \(predictions.count) predictions")
    }
}

// MARK: - Supporting Types
enum ReportGenerationState: String, Codable {
    case idle
    case generating
    case completed
    case error
}

enum ReportType: String, CaseIterable, Codable {
    case summary = "Summary"
    case detailed = "Detailed"
    case trend = "Trend"
}

enum ReportFormat: String, CaseIterable, Codable {
    case pdf = "PDF"
    case csv = "CSV"
    case json = "JSON"
}

struct Report: Codable {
    let metadata: ReportMetadata
    let data: ReportData
    let format: ReportFormat
    let generationDate: Date
    let state: ReportGenerationState
}

struct ReportMetadata: Codable {
    let reportType: ReportType
    let format: ReportFormat
    let creationDate: Date
}

struct ReportData: Codable {
    let title: String
    let content: String
}

import Foundation
import Combine
import SwiftUI
import SwiftData

// MARK: - Supporting Types
enum AnalyticsDetectionState: Equatable {
    case idle//
    // CRAVEApp/Analytics/AnalyticsReporter.swift
    // Purpose: Generates and manages analytics reports with customizable formats and delivery mechanisms
    //

    import Foundation
    import Combine

    @MainActor
    final class AnalyticsReporter: ObservableObject {
        @Published private(set) var reportGenerationState: ReportGenerationState = .idle
        @Published private(set) var lastReport: Report?

        private let analyticsStorage: AnalyticsStorage
        private var cancellables = Set<AnyCancellable>()

        init(analyticsStorage: AnalyticsStorage) {
            self.analyticsStorage = analyticsStorage
        }

        func generateReport(for type: ReportType, format: ReportFormat) async throws -> Report {
            reportGenerationState = .generating

            let reportData = ReportData(
                title: "Analytics Report",
                content: "Generated report for \(type.rawValue)"
            )

            let report = Report(
                metadata: ReportMetadata(
                    reportType: type,
                    format: format,
                    creationDate: Date()
                ),
                data: reportData,
                format: format,
                generationDate: Date(),
                state: .completed
            )

            lastReport = report
            reportGenerationState = .completed
            return report
        }

        func handleReport(_ report: Report) async {
            // Store report data
            print("Handling report: \(report.metadata.reportType)")
        }

        func handleInsights(_ insights: [any AnalyticsInsight]) async {
            // Process insights
            print("Processing \(insights.count) insights")
        }

        func handlePredictions(_ predictions: [any AnalyticsPrediction]) async {
            // Process predictions
            print("Processing \(predictions.count) predictions")
        }
    }

    // MARK: - Supporting Types
    enum ReportGenerationState: String, Codable {
        case idle
        case generating
        case completed
        case error
    }

    enum ReportType: String, CaseIterable, Codable {
        case summary = "Summary"
        case detailed = "Detailed"
        case trend = "Trend"
    }

    enum ReportFormat: String, CaseIterable, Codable {
        case pdf = "PDF"
        case csv = "CSV"
        case json = "JSON"
    }

    struct Report: Codable {
        let metadata: ReportMetadata
        let data: ReportData
        let format: ReportFormat
        let generationDate: Date
        let state: ReportGenerationState
    }

    struct ReportMetadata: Codable {
        let reportType: ReportType
        let format: ReportFormat
        let creationDate: Date
    }

    struct ReportData: Codable {
        let title: String
        let content: String
    }
    //
    // CRAVEApp/Analytics/AnalyticsReporter.swift
    // Purpose: Generates and manages analytics reports with customizable formats and delivery mechanisms
    //

    import Foundation
    import Combine

    @MainActor
    final class AnalyticsReporter: ObservableObject {
        @Published private(set) var reportGenerationState: ReportGenerationState = .idle
        @Published private(set) var lastReport: Report?

        private let analyticsStorage: AnalyticsStorage
        private var cancellables = Set<AnyCancellable>()

        init(analyticsStorage: AnalyticsStorage) {
            self.analyticsStorage = analyticsStorage
        }

        func generateReport(for type: ReportType, format: ReportFormat) async throws -> Report {
            reportGenerationState = .generating

            let reportData = ReportData(
                title: "Analytics Report",
                content: "Generated report for \(type.rawValue)"
            )

            let report = Report(
                metadata: ReportMetadata(
                    reportType: type,
                    format: format,
                    creationDate: Date()
                ),
                data: reportData,
                format: format,
                generationDate: Date(),
                state: .completed
            )

            lastReport = report
            reportGenerationState = .completed
            return report
        }

        func handleReport(_ report: Report) async {
            // Store report data
            print("Handling report: \(report.metadata.reportType)")
        }

        func handleInsights(_ insights: [any AnalyticsInsight]) async {
            // Process insights
            print("Processing \(insights.count) insights")
        }

        func handlePredictions(_ predictions: [any AnalyticsPrediction]) async {
            // Process predictions
            print("Processing \(predictions.count) predictions")
        }
    }

    // MARK: - Supporting Types
    enum ReportGenerationState: String, Codable {
        case idle
        case generating
        case completed
        case error
    }

    enum ReportType: String, CaseIterable, Codable {
        case summary = "Summary"
        case detailed = "Detailed"
        case trend = "Trend"
    }

    enum ReportFormat: String, CaseIterable, Codable {
        case pdf = "PDF"
        case csv = "CSV"
        case json = "JSON"
    }

    struct Report: Codable {
        let metadata: ReportMetadata
        let data: ReportData
        let format: ReportFormat
        let generationDate: Date
        let state: ReportGenerationState
    }

    struct ReportMetadata: Codable {
        let reportType: ReportType
        let format: ReportFormat
        let creationDate: Date
    }

    struct ReportData: Codable {
        let title: String
        let content: String
    }
    //
    // CRAVEApp/Analytics/AnalyticsReporter.swift
    // Purpose: Generates and manages analytics reports with customizable formats and delivery mechanisms
    //

    import Foundation
    import Combine

    @MainActor
    final class AnalyticsReporter: ObservableObject {
        @Published private(set) var reportGenerationState: ReportGenerationState = .idle
        @Published private(set) var lastReport: Report?

        private let analyticsStorage: AnalyticsStorage
        private var cancellables = Set<AnyCancellable>()

        init(analyticsStorage: AnalyticsStorage) {
            self.analyticsStorage = analyticsStorage
        }

        func generateReport(for type: ReportType, format: ReportFormat) async throws -> Report {
            reportGenerationState = .generating

            let reportData = ReportData(
                title: "Analytics Report",
                content: "Generated report for \(type.rawValue)"
            )

            let report = Report(
                metadata: ReportMetadata(
                    reportType: type,
                    format: format,
                    creationDate: Date()
                ),
                data: reportData,
                format: format,
                generationDate: Date(),
                state: .completed
            )

            lastReport = report
            reportGenerationState = .completed
            return report
        }

        func handleReport(_ report: Report) async {
            // Store report data
            print("Handling report: \(report.metadata.reportType)")
        }

        func handleInsights(_ insights: [any AnalyticsInsight]) async {
            // Process insights
            print("Processing \(insights.count) insights")
        }

        func handlePredictions(_ predictions: [any AnalyticsPrediction]) async {
            // Process predictions
            print("Processing \(predictions.count) predictions")
        }
    }

    // MARK: - Supporting Types
    enum ReportGenerationState: String, Codable {
        case idle
        case generating
        case completed
        case error
    }

    enum ReportType: String, CaseIterable, Codable {
        case summary = "Summary"
        case detailed = "Detailed"
        case trend = "Trend"
    }

    enum ReportFormat: String, CaseIterable, Codable {
        case pdf = "PDF"
        case csv = "CSV"
        case json = "JSON"
    }

    struct Report: Codable {
        let metadata: ReportMetadata
        let data: ReportData
        let format: ReportFormat
        let generationDate: Date
        let state: ReportGenerationState
    }

    struct ReportMetadata: Codable {
        let reportType: ReportType
        let format: ReportFormat
        let creationDate: Date
    }

    struct ReportData: Codable {
        let title: String
        let content: String
    }

    case detecting
    case completed
    case error(String)
    
    static func == (lhs: AnalyticsDetectionState, rhs: AnalyticsDetectionState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.detecting, .detecting),
             (.completed, .completed):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}

//This is the struct that was causing the error
struct AnalyticsPattern: Identifiable {
    let id: UUID
    let type: String  // Using String for now, will fix with enum later
    let confidence: Double
    let description: String
}

@MainActor
final class AnalyticsCoordinator: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var isAnalyticsEnabled: Bool = false
    @Published private(set) var lastEvent: (any AnalyticsEvent)?
    @Published private(set) var detectionState: AnalyticsDetectionState = .idle
    @Published private(set) var detectedPatterns: [AnalyticsPattern] = []

    // MARK: - Dependencies
    private let configuration: AnalyticsConfiguration
    private let storage: AnalyticsStorage
    private let aggregator: AnalyticsAggregator
    private let processor: AnalyticsProcessor
    private let reporter: AnalyticsReporter
    private let eventTrackingService: EventTrackingService
    private let patternDetectionService: PatternDetectionService
    private let analyticsService: AnalyticsService

    // MARK: - Internal State
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    init(modelContext: ModelContext) {
        self.configuration = .shared
        self.storage = AnalyticsStorage(modelContext: modelContext)
        self.aggregator = AnalyticsAggregator(storage: storage)
        self.processor = AnalyticsProcessor(configuration: .shared, storage: storage) // You'll need to create this
        self.reporter = AnalyticsReporter(analyticsStorage: storage) // You'll need to create this.
        self.eventTrackingService = EventTrackingService(storage: storage, configuration: configuration)
        self.patternDetectionService = PatternDetectionService(storage: storage, configuration: configuration)
        self.analyticsService = AnalyticsService(configuration: configuration, modelContext: modelContext)

        setupBindings()
        setupObservers()
        loadInitialState()
    }

    // MARK: - Setup Methods
    private func setupBindings() {
        configuration.$featureFlags
            .map { $0.isAnalyticsEnabled }
            .assign(to: &$isAnalyticsEnabled)
    }

    private func setupObservers() {
        eventTrackingService.eventPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    print("Event Publisher finished")
                case .failure(let error): // Handle potential errors from eventPublisher
                        print("Event Publisher error: \(error)")
                }
            } receiveValue: { [weak self] event in
                self?.lastEvent = event
                Task { [weak self] in
                    await self?.handleEvent(event)
                }
            }
            .store(in: &cancellables)

        patternDetectionService.$detectionState
            .map { state -> AnalyticsDetectionState in
                switch state {
                case .idle: return .idle
                case .detecting: return .detecting
                case .completed: return .completed
                case .error(let error): return .error(error.localizedDescription)
                }
            }
            .assign(to: &$detectionState)

        patternDetectionService.$detectedPatterns
            .map { patterns in
                patterns.map { pattern in
                    AnalyticsPattern( // Use the local AnalyticsPattern struct
                        id: UUID(),
                        type: pattern.type, // This will need to be a String or an enum case
                        confidence: pattern.confidence,
                        description: pattern.description
                    )
                }
            }
            .assign(to: &$detectedPatterns)
    }

    private func loadInitialState() {
        isAnalyticsEnabled = configuration.featureFlags.isAnalyticsEnabled
    }

    // MARK: - Event Processing
    func trackEvent(_ event: CravingModel) async throws {
        try await analyticsService.trackEvent(event)
    }

    private func handleEvent(_ event: AnalyticsEvent) async {
        await aggregator.aggregateEvent(event)
        await processor.processEvent(event)
    }

    // MARK: - Pattern Detection
    func detectPatterns() async {
        do {
            let patterns = try await patternDetectionService.detectPatterns()
            self.detectedPatterns = patterns.map { pattern in
                 AnalyticsPattern( // Use the local AnalyticsPattern struct
                    id: UUID(),
                    type: pattern.type,  // This will need to be a String or an enum case
                    confidence: pattern.confidence,
                    description: pattern.description
                )
            }
            self.detectionState = .completed
        } catch {
            print("Pattern detection failed: \(error)")
            self.detectionState = .error(error.localizedDescription)
        }
    }

    // MARK: - Reporting
    func generateReport(type: ReportType, timeRange: DateInterval) async throws -> Report {
        let report = try a//
        // CRAVEApp/Analytics/AnalyticsReporter.swift
        // Purpose: Generates and manages analytics reports with customizable formats and delivery mechanisms
        //

        import Foundation
        import Combine

        @MainActor
        final class AnalyticsReporter: ObservableObject {
            @Published private(set) var reportGenerationState: ReportGenerationState = .idle
            @Published private(set) var lastReport: Report?

            private let analyticsStorage: AnalyticsStorage
            private var cancellables = Set<AnyCancellable>()

            init(analyticsStorage: AnalyticsStorage) {
                self.analyticsStorage = analyticsStorage
            }

            func generateReport(for type: ReportType, format: ReportFormat) async throws -> Report {
                reportGenerationState = .generating

                let reportData = ReportData(
                    title: "Analytics Report",
                    content: "Generated report for \(type.rawValue)"
                )

                let report = Report(
                    metadata: ReportMetadata(
                        reportType: type,
                        format: format,
                        creationDate: Date()
                    ),
                    data: reportData,
                    format: format,
                    generationDate: Date(),
                    state: .completed
                )

                lastReport = report
                reportGenerationState = .completed
                return report
            }

            func handleReport(_ report: Report) async {
                // Store report data
                print("Handling report: \(report.metadata.reportType)")
            }

            func handleInsights(_ insights: [any AnalyticsInsight]) async {
                // Process insights
                print("Processing \(insights.count) insights")
            }

            func handlePredictions(_ predictions: [any AnalyticsPrediction]) async {
                // Process predictions
                print("Processing \(predictions.count) predictions")
            }
        }

        // MARK: - Supporting Types
        enum ReportGenerationState: String, Codable {
            case idle
            case generating
            case completed
            case error
        }

        enum ReportType: String, CaseIterable, Codable {
            case summary = "Summary"
            case detailed = "Detailed"
            case trend = "Trend"
        }

        enum ReportFormat: String, CaseIterable, Codable {
            case pdf = "PDF"
            case csv = "CSV"
            case json = "JSON"
        }

        struct Report: Codable {
            let metadata: ReportMetadata
            let data: ReportData
            let format: ReportFormat
            let generationDate: Date
            let state: ReportGenerationState
        }

        struct ReportMetadata: Codable {
            let reportType: ReportType
            let format: ReportFormat
            let creationDate: Date
        }

        struct ReportData: Codable {
            let title: String
            let content: String
        }
wait analyticsService.generateReport(type: type, timeRange: timeRange)
        await reporter.handleReport(report)
        return report
    }

    func fetchInsights() async throws -> [AnalyticsInsight] {
        let insights = try await analyticsService.fetchInsights()
        await reporter.handleInsights(insights)
        return insights
    }

    func fetchPredictions() async throws -> [AnalyticsPrediction] {
        let predictions = try await analyticsService.//
        // CRAVEApp/Analytics/AnalyticsReporter.swift
        // Purpose: Generates and manages analytics reports with customizable formats and delivery mechanisms
        //

        import Foundation
        import Combine

        @MainActor
        final class AnalyticsReporter: ObservableObject {
            @Published private(set) var reportGenerationState: ReportGenerationState = .idle
            @Published private(set) var lastReport: Report?

            private let analyticsStorage: AnalyticsStorage
            private var cancellables = Set<AnyCancellable>()

            init(analyticsStorage: AnalyticsStorage) {
                self.analyticsStorage = analyticsStorage
            }

            func generateReport(for type: ReportType, format: ReportFormat) async throws -> Report {
                reportGenerationState = .generating

                let reportData = ReportData(
                    title: "Analytics Report",
                    content: "Generated report for \(type.rawValue)"
                )

                let report = Report(
                    metadata: ReportMetadata(
                        reportType: type,
                        format: format,
                        creationDate: Date()
                    ),
                    data: reportData,
                    format: format,
                    generationDate: Date(),
                    state: .completed
                )

                lastReport = report
                reportGenerationState = .completed
                return report
            }

            func handleReport(_ report: Report) async {
                // Store report data
                print("Handling report: \(report.metadata.reportType)")
            }

            func handleInsights(_ insights: [any AnalyticsInsight]) async {
                // Process insights
                print("Processing \(insights.count) insights")
            }

            func handlePredictions(_ predictions: [any AnalyticsPrediction]) async {
                // Process predictions
                print("Processing \(predictions.count) predictions")
            }
        }

        // MARK: - Supporting Types
        enum ReportGenerationState: String, Codable {
            case idle
            case generating
            case completed
            case error
        }

        enum ReportType: String, CaseIterable, Codable {
            case summary = "Summary"
            case detailed = "Detailed"
            case trend = "Trend"
        }

        enum ReportFormat: String, CaseIterable, Codable {
            case pdf = "PDF"
            case csv = "CSV"
            case json = "JSON"
        }

        struct Report: Codable {
            let metadata: ReportMetadata
            let data: ReportData
            let format: ReportFormat
            let generationDate: Date
            let state: ReportGenerationState
        }

        struct ReportMetadata: Codable {
            let reportType: ReportType
            let format: ReportFormat
            let creationDate: Date
        }

        struct ReportData: Codable {
            let title: String
            let content: String
        }
        //
        // CRAVEApp/Analytics/AnalyticsReporter.swift
        // Purpose: Generates and manages analytics reports with customizable formats and delivery mechanisms
        //

        import Foundation
        import Combine

        @MainActor
        final class AnalyticsReporter: ObservableObject {
            @Published private(set) var reportGenerationState: ReportGenerationState = .idle
            @Published private(set) var lastReport: Report?

            private let analyticsStorage: AnalyticsStorage
            private var cancellables = Set<AnyCancellable>()

            init(analyticsStorage: AnalyticsStorage) {
                self.analyticsStorage = analyticsStorage
            }

            func generateReport(for type: ReportType, format: ReportFormat) async throws -> Report {
                reportGenerationState = .generating

                let reportData = ReportData(
                    title: "Analytics Report",
                    content: "Generated report for \(type.rawValue)"
                )

                let report = Report(
                    metadata: ReportMetadata(
                        reportType: type,
                        format: format,
                        creationDate: Date()
                    ),
                    data: reportData,
                    format: format,
                    generationDate: Date(),
                    state: .completed
                )

                lastReport = report
                reportGenerationState = .completed
                return report
            }

            func handleReport(_ report: Report) async {
                // Store report data
                print("Handling report: \(report.metadata.reportType)")
            }

            func handleInsights(_ insights: [any AnalyticsInsight]) async {
                // Process insights
                print("Processing \(insights.count) insights")
            }

            func handlePredictions(_ predictions: [any AnalyticsPrediction]) async {
                // Process predictions
                print("Processing \(predictions.count) predictions")
            }
        }

        // MARK: - Supporting Types
        enum ReportGenerationState: String, Codable {
            case idle
            case generating
            case completed
            case error
        }

        enum ReportType: String, CaseIterable, Codable {
            case summary = "Summary"
            case detailed = "Detailed"
            case trend = "Trend"
        }

        enum ReportFormat: String, CaseIterable, Codable {
            case pdf = "PDF"
            case csv = "CSV"
            case json = "JSON"
        }

        struct Report: Codable {
            let metadata: ReportMetadata
            let data: ReportData
            let format: ReportFormat
            let generationDate: Date
            let state: ReportGenerationState
        }

        struct ReportMetadata: Codable {
            let reportType: ReportType
            let format: ReportFormat
            let creationDate: Date
        }

        struct ReportData: Codable {
            let title: String
            let content: String
        }
fetchPredictions()
        await reporter.handlePredictions(predictions)
        return predictions
    }
}
