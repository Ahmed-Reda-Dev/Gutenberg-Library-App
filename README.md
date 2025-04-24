# Book Listing App

![Flutter Version](https://img.shields.io/badge/Flutter-3.19.0-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.3.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

A modern, responsive Flutter application for browsing and searching books from the Project Gutenberg library. The app showcases adaptive UI design principles, responsive layouts, and follows clean architecture.

<p align="center">
  <img src="assets/images/app_preview.png" alt="Book Listing App Preview" width="600">
</p>

## Features

- **Responsive UI**: Optimized for phones and tablets in both portrait and landscape orientations.
- **Platform Adaptivity**: Automatically adjusts UI elements for Android and iOS platforms.
- **Book List Screen**: Displays a list of books with infinite scrolling pagination.
- **Book List Item**: Each item shows the cover image, title, authors, languages, and an expandable summary.
- **Search Functionality**: Real-time search with pagination and result highlighting.
- **Offline Caching**: The app caches book data for offline access.
- **Adaptable Layouts**: Different layouts for tablets and phones to optimize reading experience.
- **Shimmer Loading Effects**: Beautiful placeholder animations while content loads.

## How to Build and Run the Application

### Prerequisites

- Flutter SDK 3.19.0 or higher
- Dart 3.3.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/Ahmed-Reda-Dev/Gutenberg-Library-App.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Gutenberg-Library-App
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Design Decisions and Architecture

The application follows Clean Architecture principles and is organized into layers:

### Architecture

- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Data sources, repositories, and models

### Libraries Used

Beyond Flutter SDK and required dependencies (http/flutter_bloc), the app uses:

- **flutter_screenutil**: For responsive UI scaling across devices
- **cached_network_image**: For efficient image loading and caching
- **shimmer**: For loading animation effects
- **hive**: For local data persistence and offline support
- **flutter_svg**: For SVG asset rendering
- **get_it**: For dependency injection

### State Management

The app uses the BLoC pattern (via Cubit) for state management:

- **BookCubit**: Manages the book listing states (initial, loading, success, error)
- **API Integration**: Handles pagination and search requests
- **Error Handling**: Gracefully manages network errors and retry logic

### Assumptions Made

- The application assumes a minimum screen width of 320px for phones
- Tablet detection is based on a width threshold of 600px
- Internet connection is required for initial data loading, but cached data is used when offline
- The Gutendex API does not require authentication

## Responsive UI Implementation

```
lib/
├── core/               # Core utilities and common functionality
│   ├── di/             # Dependency injection
│   ├── helpers/        # Helper functions
│   ├── networking/     # API client and networking utilities
│   ├── routing/        # Navigation and routing
│   └── theming/        # Colors, styles, and themes
├── features/           # Feature modules
│   ├── book_details/   # Book detail screen
│   └── home/           # Home screen with book listing
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   └── usecases/
│       └── presentation/
│           ├── cubit/
│           ├── pages/
│           └── widgets/
│               └── book_list/    # Modular book list components
└── main.dart           # Application entry point
```

## Responsive UI Implementation

The app implements a fully responsive UI that adapts to different device types and orientations:

### Phone vs Tablet Detection

- Uses screen width breakpoints (≥600px for tablets)
- Automatically detects device orientation changes

### Layout Adaptations

- **Phones (Portrait)**: Single-column list view with book cards
- **Phones (Landscape)**: Optimized row layout with compact book details
- **Tablets (Portrait)**: Two-column grid with larger book cards
- **Tablets (Landscape)**: Three-column grid for optimal content density

### Platform-Specific UI

- iOS-specific adjustments (centered app title, iOS-style icons)
- Android Material Design compliance

## Getting Started

### Prerequisites

- Flutter SDK 3.19.0 or higher
- Dart 3.3.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Ahmed-Reda-Dev/Gutenberg-Library-App.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Gutenberg-Library-App
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## State Management

The app uses the BLoC pattern (via Cubit) for state management:

- **BookCubit**: Manages the book listing states (initial, loading, success, error)
- **API Integration**: Handles pagination and search requests
- **Error Handling**: Gracefully manages network errors and retry logic

## Key Components

### Widget Modularity

The UI is built with modular components for better maintainability:

- **BookListItem**: Adaptive card for displaying book information
  - Specialized layouts for different screen sizes and orientations
  - Compact layouts for landscape mode on phones
  - Expanded layouts for tablets

### Shimmer Loading

Custom loading placeholders with shimmer animation effects that match the final content structure for a smoother user experience.

## Future Enhancements

- [ ] Book detail screen with full metadata
- [ ] Download functionality for offline reading
- [ ] User bookmarks and favorites
- [ ] Reading history tracking
- [ ] Dark mode support

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Project Gutenberg](https://www.gutenberg.org/) for the extensive book library
- [Gutendex API](https://gutendex.com/) for providing access to the Gutenberg catalog
- Flutter team for the amazing cross-platform framework

## Technical Requirements

- **State Management**: Utilizes Cubit for managing application state.
- **Architecture**: Follows Clean Code Architecture principles.
- **UI/UX**: Designed for responsiveness across mobile and tablet devices.

## Getting Started

To build and run the application, follow these steps:

1. Clone the repository:

   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:

   ```
   cd gutenberg_library
   ```

3. Install dependencies:

   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Design Decisions

- The application uses the Gutendex API for fetching book data, which does not require authentication.
- State management is handled using Cubit to keep the UI responsive and maintainable.

## Notes

- Ensure you have Flutter SDK installed and configured on your machine.
- For any issues or feature requests, please open an issue in the repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
