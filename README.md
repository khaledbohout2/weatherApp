# WeatherApp

WeatherApp is an iOS project designed to display weather information. It primarily focuses on managing a list of cities saved locally using Core Data and providing detailed weather forecasts.

The project is built using the **MVVM-C architecture** and **Clean Architecture** principles, ensuring scalability and adherence to SOLID principles. It leverages the **Combine** framework for reactive programming.

## Architecture

The application employs:

-   **Model (M):** Represents the data entities.
-   **ViewModel (VM):** Handles the business logic and interacts with various services.
-   **View (V):** Contains the user interface.
-   **Coordinator (C):** Manages navigation and data flow between different modules.

It also adheres to **Clean Architecture**, utilizing use cases and repositories to interact with services, promoting a clear separation of concerns.

## Modules

1.  **Cities List:** Handles fetching the list of saved cities from Core Data and displaying them in the UI.
2.  **Weather Details:** Displays detailed weather information for a selected city.
3.  **Search Screen:** Manages user searches for new cities to add to the saved list.
4.  **City History Screen:** Displays all past weather requests and data for a specific city.

## Technologies Used

-   **MVVM-C Architecture**
-   **Combine** framework for reactive programming
-   **Clean Architecture**
-   **Core Data** for local data persistence
-   **iOS SDK 15.0**
-   **Swift version 5.5**
-   **Xcode version 14.0**

## How to Run

1.  Clone the repository:
    ```bash
    git clone [repository_url]
    cd [project_directory]
    ```
2.  Open the project in Xcode (likely a `.xcodeproj` or `.xcworkspace` file).
3.  Build and run the application on a simulator or a physical iOS device.

## Contributing

Contributions are welcome! Please feel free to submit pull requests with improvements or bug fixes. For major changes, please open an issue first to discuss what you would like to change.
