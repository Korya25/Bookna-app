BookFlick 📚
Welcome to BookFlick, a Flutter-based mobile application designed for book lovers to discover, explore, and manage their favorite books using the Google Books API. Built with Clean Architecture, Cubit for state management, and GetIt for dependency injection, BookFlick offers a seamless and engaging user experience with smooth animations and an intuitive UI.

✨ Features

Books Section:
Slider Card: Eye-catching animated carousel showcasing featured books.
Popular Books: Discover trending books with smooth transitions.
Top Rated Books: Explore highly rated books with dynamic loading animations.


Book Detail View: Dive into detailed book information, including synopsis, ratings, and more, with fade-in animations.
Author View: Learn about authors with a clean, animated layout.
Similar Books: Get recommendations with a sliding card effect.
Categories Section: Browse books by genre with a grid layout and tap animations.
Search Section: Find books instantly with real-time search and loading spinners.
Favorites Section: Save and manage your favorite books with heart animation toggles.


🛠 Technologies Used

Flutter & Dart: For cross-platform mobile development.
Clean Architecture: Ensures scalability and maintainability.
Cubit (Bloc): For efficient state management.
GetIt: For dependency injection.
Google Books API: Powers book data retrieval.
Hive: Local storage for favorites (offline support).
Animations: Custom transitions, fades, and slides using Flutter’s animation framework.


📸 Screenshots



Home Screen
Book Details
Search
Favorites









(Add your screenshots to a screenshots/ folder in the repository)

🎥 Demo
(Record a short GIF using tools like LiceCap or ScreenToGif to showcase animations like the slider, heart toggle, or page transitions)

🚀 Getting Started
Follow these steps to run BookFlick locally:
Prerequisites

Flutter SDK (v3.0.0 or later)
Dart (v2.17.0 or later)
A valid Google Books API key (set up in .env)

Installation

Clone the repository:
git clone https://github.com/yourusername/BookFlick.git


Navigate to the project folder:
cd BookFlick


Install dependencies:
flutter pub get


Add your Google Books API key:

Create a .env file in the root directory.
Add: GOOGLE_BOOKS_API_KEY=your_api_key_here


Run the app:
flutter run




🛠 Project Structure
BookFlick follows Clean Architecture for a modular and testable codebase:
lib/
├── core/                # Utilities, constants, and shared resources
├── data/                # API calls, local storage, and data models
├── domain/              # Business logic, use cases, and entities
├── presentation/        # UI, widgets, and Cubit state management
└── main.dart            # App entry point


🎨 Animations
BookFlick is packed with delightful animations to enhance the user experience:

Hero Animations: Smooth transitions between book cards and detail views.
Fade Transitions: Subtle fades for loading book details and images.
Slide Animations: Sliding cards in the carousel and similar books section.
Heart Toggle: Animated favorite button with a scaling heart effect.
Loading Spinners: Custom spinners for search and API loading states.

(Tip: Mention specific animations you implemented, like the slider card transition or favorites toggle)

🤝 Contributing
Contributions are welcome! If you have ideas for new features or improvements, feel free to:

Fork the repository.
Create a new branch: git checkout -b feature-name.
Commit your changes: git commit -m 'Add feature'.
Push to the branch: git push origin feature-name.
Open a Pull Request.


📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

📬 Contact
Built with ❤️ by [Your Name]. Connect with me on:

LinkedIn
GitHub

Happy reading with BookFlick! 📖
