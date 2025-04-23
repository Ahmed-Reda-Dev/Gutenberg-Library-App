# README.md

# Gutenberg Library App

This project is a simple mobile application that allows users to browse and search books from the Project Gutenberg library using the Gutendex API.

## Features

- **Book List Screen**: Displays a list of books with infinite scrolling.
- **Book List Item**: Each item shows the cover image, title, authors, and a collapsible summary.
- **Search Functionality**: Users can search for books and view results with pagination.
- **Offline Caching**: The app caches book data for offline access.

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