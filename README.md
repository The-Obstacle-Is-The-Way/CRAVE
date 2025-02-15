# CRAVE 🍒 MVP — Modern Cravings Management App

**CRAVE** is an iOS application built with **SwiftUI** and **SwiftData**, helping you track and manage your cravings through a clean, intuitive interface. Whether it’s late-night snacks or midday munchies, CRAVE ensures you stay in control.

📄 YC MVP Planning Document → https://docs.google.com/document/d/1kcK9C_-ynso44XMNej9MHrC_cZi7T8DXjF1hICOXOD4/edit?tab=t.0

📂 Project Structure

```bash

CRAVEApp/
├── Docs/
│   ├── Images/
│   │   ├── crave-architecture.png
│   │   ├── crave-logging-flow.png
│   │   └── crave-navigation-states.png
│   ├── AnalyticsArchitecture.md
│   ├── AnalyticsImplementationGuide.md
│   └── AnalyticsAPIReference.md
│
├── CRAVE.entitlements
├── Info.plist
├── CRAVEApp.swift  <-- ValueTransformer.registerTransformers() MUST be called here!
├── ContentView.swift
├── Assets.xcassets/
│
├── Core/  <-- "Core" for app-wide, reusable components
│   ├── Configuration/
│   │   └── AnalyticsConstants.swift  // Constants, if any.  Likely empty for now.
│   ├── DesignSystem/
│   │   ├── CRAVEDesignSystem.swift
│   │   └── Components/
│   │       ├── CraveButton.swift    // Reusable UI components
│   │       └── CraveTextEditor.swift
│   ├── Extensions/
│   │   ├── Date+Formatting.swift  // ALL Date extensions in ONE file.
│   │   ├── View+Extensions.swift
│   │   ├── Array+Analytics.swift  // If you have array-specific extensions for analytics.
│   │   └── Dictionary+Analytics.swift // If you have dictionary-specific extensions.
│   └── Services/
│       └── EventTrackingService.swift  // Stays in Core, as it's fundamental.
│
├── Data/
│   ├── Entities/
│   │   └── CravingModel.swift  // Your main data model.
│   └── CravingManager.swift      // Data access and manipulation for CravingModel.
│
├── Analytics/  <-- Dedicated module for ALL analytics-related code.
│   ├── Configuration/
│   │   └── AnalyticsConfiguration.swift  // Configuration specific to analytics.
│   ├── Services/  <-- Core analytics services.
│   │   ├── AnalyticsService.swift      // Main service, public API.
│   │   ├── AnalyticsAggregator.swift
│   │   ├── AnalyticsProcessor.swift
│   │   ├── AnalyticsStorage.swift
│   │   └── PatternDetectionService.swift
│   ├── Models/  <-- Data models SPECIFIC to analytics.
│   │   ├── AnalyticsMetadata.swift
│   │   ├── InteractionData.swift
│   │   ├── ContextualData.swift
│   │   ├── AnalyticsEvent.swift      // Moved here - it's an analytics data model.
│   │   ├── AnalyticsPattern.swift    // Moved here
│   │   ├── AnalyticsInsight.swift    // Moved here
│   │   ├── AnalyticsPrediction.swift // Moved here
│   │   └── BasicAnalyticsResult.swift
│   ├── Coordination/
│   │   └── AnalyticsCoordinator.swift  // Orchestrates the analytics flow.
│   ├── UI/
│   │   ├── Components/
│   │   │   ├── CravingBarChart.swift
│   │   │   ├── TimeOfDayPieChart.swift
│   │   │   ├── CalendarHeatmapView.swift
│   │   │   ├── AnalyticsInsightView.swift  // If you have specific insight views.
│   │   │   └── PatternVisualizationView.swift
│   │   └── Shared/
│   │       ├── AnalyticsView.swift        // A general analytics view.
│   │       └── AnalyticsViewModel.swift   // ViewModel for the general view.
│   └── Utilities/  <-- Analytics-specific helpers.
│       ├── AnalyticsFormatter.swift
│       ├── AnalyticsValidator.swift
│       └── AnalyticsError.swift
│       └── AnalyticsTransformers.swift  <-- NEW: Value Transformers.
│
├── Screens/  <-- Your app's main screens/features.
│   ├── LogCraving/
│   │   ├── LogCravingView.swift
│   │   └── LogCravingViewModel.swift
│   ├── DateList/
│   │   ├── DateListView.swift
│   │   └── DateListViewModel.swift
│   ├── CravingList/
│   │   ├── CravingListView.swift
│   │   └── CravingListViewModel.swift
│   └── AnalyticsDashboard/
│       ├── AnalyticsDashboardView.swift
│       └── AnalyticsDashboardViewModel.swift
│
├── Navigation/
│   └── CRAVETabView.swift
│
├── Preview Content/
│   └── Preview Assets.xcassets/
│
└── Tests/
    ├── CRAVETests/  <-- Your unit tests.
    │   ├── AnalyticsAggregatorTests.swift
    │   ├── AnalyticsConfigurationTests.swift
    │   ├── AnalyticsCoordinatorTests.swift
    │   ├── AnalyticsEventTests.swift
    │   ├── AnalyticsInsightTests.swift
    │   ├── AnalyticsManagerTests.swift
    │   ├── AnalyticsModelTests.swift
    │   ├── AnalyticsPatternTests.swift
    │   ├── AnalyticsPredictionTests.swift
    │   ├── AnalyticsProcessorTests.swift
    │   ├── AnalyticsStorageTests.swift
    │   ├── BasicAnalyticsResultTests.swift
    │   ├── CraveModelTests.swift
    │   ├── CravingAnalyticsIntegrationTests.swift
    │   ├── CravingManagerTests.swift
    │   └── InteractionDataTests.swift
    └── CRAVEUITests/  <-- Your UI tests.
        └── CRAVEUITests.swift

```
---

## Architecture

<img src="https://github.com/The-Obstacle-Is-The-Way/CRAVE/blob/main/CRAVEApp/Docs/Images/crave-architecture.png" alt="CRAVE Architecture" width="800"/>

---

## Logging Flow

<img src="https://github.com/The-Obstacle-Is-The-Way/CRAVE/blob/main/CRAVEApp/Docs/Images/crave-logging-flow.png" alt="CRAVE Logging Flow" width="800"/>

---

## Navigation States

<img src="https://github.com/The-Obstacle-Is-The-Way/CRAVE/blob/main/CRAVEApp/Docs/Images/crave-navigation-states.png" alt="CRAVE Navigation States" width="800"/>

---

*This MVP has a solid MVVM foundation, and I'm in the process of pivoting to find a technical cofounder for YC. Once that's secured, I'll revisit and refine the code further.*

## 🌟 Architecture & Features

### Data Layer
- **SwiftData Integration**: Harnesses `@Model` for modern persistence and efficient CRUD operations.  
- **Soft Deletions**: Archives cravings instead of fully removing them, preserving data for potential analytics.  
- **Data Manager**: A dedicated `CravingManager` ensures thread-safe data access and state consistency.

### Design System
- **Centralized Tokens**: Unified colors, typography, and spacing for a polished, cohesive design.  
- **Reusable Components**: Custom buttons, text editors, and haptic feedback helpers.  
- **Adaptive Layout**: Responsive UI that looks great on various iOS screens.

### Core Features
- **Quick Logging**: Rapid craving entry with instant persistence.  
- **Smart History**: Cravings are grouped by date, with friendly placeholders if no data exists.  
- **Easy Management**: Swipe-to-archive, bulk edits, and other intuitive actions keep your list tidy.

### Technical Excellence
- **MVVM Architecture**: Leverages `@Observable` for clean, scalable state management.  
- **Comprehensive Testing**: Unit tests, UI tests, and ephemeral in-memory data configurations using XCTest.  
- **Performance Focus**: Swift animations, minimal overhead, and optimized data fetches keep the app smooth.

---

## 🚀 Roadmap
💎 Ultra Dank Roadmap for Voice, AI, and Analytics Integration

---

### **Phase 1: iOS Voice Recording Integration**
**Goal:** Let users record, store, and access voice logs for cravings.

**Steps:**
- **Implement Voice Recording:**  
  Use iOS's AVFoundation to build a simple voice recorder within the LogCravingView.
- **Data Integration:**  
  Extend SwiftData models to store audio files alongside text-based craving logs.
- **UI/UX:**  
  Add a recording button/icon (🍒🎙️) that toggles recording and playback.

**Deliverable:**  
A basic voice recording feature fully integrated into the iOS app.

---

### **Phase 2: Apple Watch Connectivity & Voice Recording**
**Goal:** Enable seamless voice recording on the Apple Watch with connectivity to iOS.

**Steps:**
- **Develop a WatchKit Companion App:**  
  Create a watchOS interface for recording and managing voice logs.
- **Connectivity Pairing:**  
  Leverage WatchConnectivity to sync recordings between the watch and iOS.
- **Smooth Integration:**  
  Ensure the watchOS UI is minimal and intuitive with immediate feedback.

**Deliverable:**  
A fully functional Apple Watch app that pairs with the iOS app, capturing voice recordings on the go.

---

### **Phase 3: Whisper AI API Integration**
**Goal:** Automate transcription and initial analysis of voice recordings.

**Steps:**
- **Integrate Whisper API:**  
  Connect to the Whisper AI API to convert voice recordings to text.
- **Real-Time Transcription:**  
  Process recordings from both iOS and watchOS in near real-time.
- **Display & Storage:**  
  Show transcriptions alongside existing craving logs, with options to edit or annotate.

**Deliverable:**  
Transcribed voice logs seamlessly integrated into the app’s craving history.

---

### **Phase 4: Rudimentary AI Analysis Module**
**Goal:** Offer users optional, experimental insights from their voice logs and cravings.

**Steps:**
- **Develop a Sandbox AI Module:**  
  Create an untrained AI module to analyze text and audio data for patterns (frequency, tone, sentiment).
- **User Opt-In:**  
  Allow users to choose whether to run this experimental analysis.
- **Basic Insights:**  
  Display simple analytics or trends that indicate potential trigger patterns.

**Deliverable:**  
A rudimentary AI analysis feature providing basic, actionable insights based on users’ logs.

---

### **Phase 5: Advanced Internal AI Integration**
**Goal:** Build and integrate a custom AI model for deep analysis of cravings and recordings.

**Steps:**
- **Data Collection & Model Training:**  
  Use gathered user data (with consent) to train a custom AI model in a controlled environment.
- **Internal AI Module:**  
  Integrate the model into the app for real-time, advanced pattern recognition and insights.
- **UI/UX Enhancements:**  
  Optimize insight displays to be actionable and user-friendly.

**Deliverable:**  
A robust internal AI capability that augments user data with advanced insights and predictive analytics.

---

### **Phase 6: Advanced Analytics & Insight Integration**
**Goal:** Provide deep analytics on craving patterns with contextual data.

**Steps:**
- **Craving Analytics Dashboard:**  
  Build a dashboard to analyze date/time trends, frequency, and patterns in cravings.
- **Location Analysis (Opt-In):**  
  Integrate location services to track where cravings occur; include user opt-in for privacy.
- **Watch Vitals Analytics:**  
  Capture and analyze watch metrics (heart rate, activity) during craving events.
- **Data Visualization:**  
  Use charts and graphs to present analytics in a clean, minimal UI.

**Deliverable:**  
A comprehensive analytics module offering users actionable insights into their craving behavior, including temporal trends, location contexts, and physiological data from the watch.

---

### **🔥 Best Steps Forward**
- **Iterate & Test:**  
  Run UI tests and gather user feedback at every phase to keep data and UI in sync.
- **Documentation:**  
  Maintain thorough documentation to support iterative development and onboarding.
- **Technical Cofounder:**  
  Prioritize finding a technical cofounder for YC to accelerate MVP refinement.
- **MVP Focus:**  
  Nail core functionalities (voice recording and connectivity) before scaling AI and analytics features.

---

## ⚙️ Development

Built with:
- **SwiftUI**  
- **SwiftData**  
- **Combine**  
- **XCTest**

**Requirements**:
- iOS 17.0+  
- Xcode 15.0+

### Setup & Installation
1. **Clone the repository**:  
   ```bash
   git clone https://github.com/YOUR_USERNAME/CRAVE.git
   cd CRAVE
   ```
2. **Open in Xcode**:  
   Double-click `CRAVE.xcodeproj` or open it via `File > Open...`
3. **Run the project**:  
   Select a simulator or device, then press <kbd>Cmd</kbd> + <kbd>R</kbd>.
4. *(Optional)* **Run Tests**:  
   <kbd>Cmd</kbd> + <kbd>U</kbd> to execute unit and UI tests.

---

## 🤝 Contributing
1. **Fork** this repository  
2. **Create a new branch**:  
   ```bash
   git checkout -b feature-branch
   ```
3. **Commit your changes**:  
   ```bash
   git commit -m "Add new feature"
   ```
4. **Push the branch**:  
   ```bash
   git push origin feature-branch
   ```
5. **Submit a Pull Request** describing your changes.  
   
For issues, feature requests, or ideas, please [open an issue](https://github.com/YOUR_USERNAME/CRAVE/issues).

---

## 📄 License
This project is licensed under the [MIT License](LICENSE).

---

> **CRAVE**: Because understanding your cravings **shouldn’t** be complicated. 🍫  
