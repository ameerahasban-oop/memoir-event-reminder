# Memoir – Mobile Event Reminder Application

Memoir is a mobile event reminder application developed using Flutter and Dart. The application allows users to create, manage, and organize personal events such as appointments, meetings, exams, and daily activities.

## Features

* User registration and login
* Create, view, edit, and delete events
* Store events locally using SharedPreferences
* Display events based on the selected date
* Sort and organize upcoming events
* Add event locations
* Retrieve weather information based on the event location
* Attach images from the device gallery
* Mark events as favourites
* Delete and edit existing events
* Submit and view application reviews

## Technologies Used

* **Flutter** – Mobile application development
* **Dart** – Programming language
* **SharedPreferences** – Local data storage
* **OpenWeather API** – Weather information
* **Google Apps Script** – Backend integration for reviews
* **Google Sheets** – Review data storage
* **GPS / Location Services** – Current location functionality

## Application Screens

### Login
![Login Page](assets/screenshots/login.png)

### Home
![Home Page](assets/screenshots/home.png)

### Create Event
![Create Event](assets/screenshots/create_event.png)

### Event Details
![Event Details](assets/screenshots/event_details.png)

### Weather
![Weather](assets/screenshots/weather.png)

## Project Structure

```text
lib/
├── main.dart
├── models/
├── pages/
├── services/
└── widgets/

assets/
└── ...
```

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/ameerahasban-oop/memoir-event-reminder.git
```

### 2. Open the project

```bash
cd memoir-event-reminder
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Configure the OpenWeather API

The weather feature requires an OpenWeather API key.

Open:

```text
lib/weather_service.dart
```

Replace:

```dart
static const String apiKey =
    "YOUR_OPENWEATHER_API_KEY";
```

with your own OpenWeather API key.

**Note:** The actual API key is not included in this repository for security reasons.

### 5. Run the application

Connect an Android device or start an Android emulator, then run:

```bash
flutter run
```

## Learning Outcomes

Through this project, I gained practical experience in:

* Flutter mobile application development
* Dart programming
* CRUD operations
* Local data storage
* API integration
* Working with device features such as GPS and image gallery
* JSON and external data handling
* Integrating Google Apps Script and Google Sheets
* Designing user-friendly mobile interfaces

## Future Improvements

Possible future improvements include:

* Push notifications for upcoming events
* Cloud-based data synchronization
* User profile management
* Recurring events
* Calendar integration
* Improved authentication and security

## Author

**Ameerah Solehah Bt Asban**

Diploma in Computer Science + SAS
Kolej Profesional MARA Beranang
