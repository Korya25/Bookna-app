BookFlick 📚
Welcome to BookFlick, a Flutter-based mobile application crafted for book enthusiasts to discover, explore, and manage their favorite books using the Google Books API. Built with Clean Architecture, Cubit for state management, and GetIt for dependency injection, BookFlick delivers a polished user experience with fluid animations, a responsive UI, and offline capabilities.

✨ Features

Books Section:
Animated Slider Card: A visually appealing carousel with auto-scroll and swipe gestures for featured books.
Popular Books: Curated list of trending books with smooth reveal animations.
Top Rated Books: High-rated books displayed with dynamic loading indicators.


Book Detail View: In-depth book info (synopsis, ratings, reviews) with fade-in transitions and collapsible sections.
Author View: Dedicated author profiles with animated book galleries.
Similar Books: Personalized recommendations with a horizontal sliding card effect.
Categories Section: Explore books by genre in an interactive grid with scale-on-tap animations.
Search Section: Real-time search with debounced input and circular progress spinners.
Favorites Section: Save books offline with an animated heart toggle and persistent storage via Hive.
Offline Support: View favorite books without an internet connection.
Dark Mode: Toggle between light and dark themes with seamless transitions.


🛠 Technologies Used

Frontend:
Flutter & Dart: Cross-platform UI with a focus on performance.
Animations: Custom Hero, fade, slide, and scale animations using Flutter’s animation framework.


Architecture & State Management:
Clean Architecture: Modular, testable, and scalable codebase.
Cubit (Bloc): Lightweight and efficient state management.
GetIt: Dependency injection for loose coupling.


Backend & Storage:
Google Books API: Robust book data retrieval.
Hive: Fast, lightweight local storage for favorites.


Tools:
Flutter Lints: Enforced code quality and best practices.
VS Code & Android Studio: Development and debugging.




📸 Screenshots



Home Screen
Book Details
Search
Favorites









(Place screenshots in the screenshots/ folder. Use tools like Canva or Figma to add device frames for a professional look.)

🎥 Demo
See BookFlick in action, showcasing smooth animations like the Slider Card, heart toggle, and page transitions:
(Record a 5-10 second GIF using LiceCap or ScreenToGif. Optimize with EZGIF to keep file size under 5MB.)

🚀 Getting Started
Run BookFlick locally with these steps:
Prerequisites

Flutter SDK: v3.0.0 or later
Dart: v2.17.0 or later
Google Books API Key: Obtain from Google Cloud Console
A compatible IDE (VS Code, Android Studio)

Installation

Clone the repository:
git clone https://github.com/yourusername/BookFlick.git


Navigate to the project:
cd BookFlick


Install dependencies:
flutter pub get


Set up the API key:

Create a .env file in the root directory.

Add:
GOOGLE_BOOKS_API_KEY=your_api_key_here




Run the app:
flutter run



Troubleshooting

API errors: Ensure your Google Books API key is valid and quotas are not exceeded.
Build issues: Run flutter clean and flutter pub get to refresh the project.
Emulator setup: Use a recent Android/iOS emulator for optimal performance.


🛠 Project Structure
BookFlick adheres to Clean Architecture for maintainability:
lib/
├── core/                # Utilities, constants, themes, and error handling
├── data/                # API services, Hive storage, and data models
├── domain/              # Entities, use cases, and repositories
├── presentation/        # Screens, widgets, Cubits, and animations
└── main.dart            # App entry point with dependency injection


🎨 Animations
BookFlick elevates the user experience with carefully crafted animations:

Hero Animations: Seamless image transitions from book cards to detail views.
Fade Transitions: Elegant fades for loading states and content reveals.
Slide Animations: Smooth card slides in the carousel and similar books.
Heart Toggle: Playful scale-and-bounce effect for favoriting books.
Scale Animations: Interactive category grid with tap feedback.
Loading Indicators: Custom spinners with gradient effects for API calls.

(Highlight your favorite animation in the demo GIF, like the Slider Card auto-scroll or heart toggle.)

🌟 Why BookFlick?

User-Centric Design: Intuitive navigation and responsive layouts.
Performance Optimized: Efficient API calls and local caching with Hive.
Scalable Codebase: Clean Architecture ensures easy feature additions.
Engaging Animations: Subtle yet delightful transitions for a premium feel.


🤝 Contributing
Contributions are welcome! To contribute:

Fork the repository.

Create a feature branch:
git checkout -b feature/your-feature


Commit changes:
git commit -m "Add your feature"


Push to the branch:
git push origin feature/your-feature


Open a Pull Request with a clear description.


Please follow the Code of Conduct and use Flutter Lints for consistency.

📜 License
Licensed under the MIT License. Feel free to use, modify, and distribute.

📬 Contact
Built with ❤️ by [Your Name]. Reach out to me:

LinkedIn: linkedin.com/in/yourusername
GitHub: github.com/yourusername
Email: your.email@example.com

Explore, read, and enjoy with BookFlick! 📖
