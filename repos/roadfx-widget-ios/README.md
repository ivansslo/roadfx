# ROADFX Widget iOS

iOS (Swift) SDK for ROADFX customer service widget. Provides a drop-in chat UI that connects to ROADFXs backend API and WuKongIM for real-time messaging.

## Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 15+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/roadfx-widget-ios.git", from: "1.0.0")
]
```

Or in Xcode: File → Add Package Dependencies → paste the repository URL.

## Quick Start

### Option 1: One-line modal presentation (UIKit)

```swift
import ROADFXWidget

ROADFXWidget.show(apiKey: "pk_xxx", from: viewController)
```

### Option 2: SwiftUI embedded view

```swift
import ROADFXWidget

struct ContentView: View {
    var body: some View {
        ROADFXChatView(apiKey: "pk_xxx")
    }
}
```

### Option 3: Pre-configure + show

```swift
import ROADFXWidget

// Configure once (e.g. in AppDelegate)
ROADFXWidget.configure(
    apiKey: "pk_xxx",
    baseURL: "https://your-api.com",  // optional
    theme: .dark                       // optional
)

// Show anywhere
ROADFXWidget.show(from: viewController)
```

### Option 4: With visitor info

```swift
ROADFXWidget.configure(
    apiKey: "pk_xxx",
    visitorInfo: VisitorInfo(
        name: "John",
        email: "john@example.com",
        company: "Acme Inc"
    )
)
```

## Architecture

```
Sources/ROADFXWidget/
├── ROADFXWidget.swift          # Public API entry point
├── ROADFXConfig.swift          # Configuration
├── Models/                  # Data models (Message, Visitor, PlatformInfo)
├── Services/                # Network layer (APIClient, IM, Upload, etc.)
├── Store/                   # State management (ChatStore, PlatformStore)
├── Views/                   # SwiftUI views
└── Utils/                   # Helpers (Storage, DeviceInfo, TimeFormatter)
```

## API Endpoints

All endpoints match the JS widget (`roadfx-widget-js`):

| Endpoint | Description |
|----------|-------------|
| `GET /v1/platforms/info` | Platform configuration |
| `POST /v1/visitors/register` | Visitor registration |
| `POST /v1/visitors/messages/sync` | Message history |
| `POST /v1/chat/upload` | File upload |
| `POST /v1/chat/completion` | Send message + AI reply |
| `POST /v1/ai/runs/cancel-by-client` | Cancel streaming |

## System Requirements

- 4 Core / 8 GiB (recommended for development)
