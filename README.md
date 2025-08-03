# Bubbles: Breaking Down Complex Journeys With Single-Responsibility Orchestrators

A Flutter project demonstrating the **"Bubbles" architecture pattern** for managing complex, multi-step user flows. This repository is the companion source code for the article **Bubbles: Breaking Down Complex Journeys With Single-Responsibility Orchestrators**.

This pattern is designed to decouple individual steps of a journey (like a checkout process) into self-contained modules, orchestrated by a central manager.


## 🫧 The "Bubbles" Pattern

The core idea is to break down a complex user journey into isolated "Bubbles".

* **Journey**: any relatively complex flow in an application. It consists of a series of steps a user must complete. In our case these steps were jumped together behind the scenes.

* **Bubble**: a smaller section of a journey.  Users enter a bubble, complete a series of steps, then exit. Think of it as a chapter in a larger story. (e.g., `DeliveryDetailsConfirmationView` confirms an address). A Bubble knows nothing about other Bubbles.

* **Orchestrator**: a finite-state machine that tracks the current state of a bubble and spans over the entire journey (`DeliveryJourneyOrchestrationCubit`). It holds the business logic needed to move between states and handle errors. Its state is always clear and predictable. In Flutter terms, this would be a Bloc or a Cubit.


### Why use this pattern?

-   **Decoupling**: Each step of the journey is completely independent. You can change the `Payment` bubble without touching the `Delivery` bubble.
-   **Reusability**: Bubbles can potentially be reused in different user journeys.
-   **Testability**: Each bubble can be developed and tested in isolation.
-   **Clarity**: The Orchestrator provides a clear, high-level view of the entire user flow, making the journey logic easy to understand and modify.

## 📂 Project Structure

The project follows the principles of **Clean Architecture**, separating concerns into three main layers:

```
lib
├── data/
│   ├── datasources/  # Fetches data (e.g., from an API)
│   └── repos/        # Implements domain repositories
├── domain/
│   ├── entities/     # Core business objects
│   ├── usecases/     # Business logic
│   └── ...
└── presentation/
    ├── delivery_details/ # A "Bubble"
    │   ├── bloc/
    │   └── view/
    ├── payment/          # Another "Bubble"
    │   ├── bloc/
    │   └── widget/
    └── main_delivery_journey/ # The Orchestrator
        ├── bloc/
        └── delivery_journey_page.dart
```

## ✨ Features Demonstrated

This example project showcases:

*   A multi-step user journey: **Basket ➡️ Delivery Details ➡️ Payment ➡️ Confirmation**.
*   The **Bubbles & Orchestrator** pattern for flow control.
*   State management using `flutter_bloc` (**Cubit**).
*   Dependency Injection using `get_it` for a decoupled architecture.
*   Clean Architecture principles.
*   Simulated asynchronous operations (API calls) with loading and error states.

## 🚀 Getting Started

To run this project locally:

1.  Ensure you have the Flutter SDK installed.
2.  Clone the repository (replace `[YOUR_USERNAME]` with your actual GitHub username):
    ```sh
    git clone https://github.com/[YOUR_USERNAME]/bubbles_example.git
    cd bubbles_example
    ```
3.  Install dependencies:
    ```sh
    flutter pub get
    ```
4.  Run the app:
    ```sh
    flutter run
    ```

## 📖 Associated Article

This repository provides the source code for the companion article. You can find the detailed walkthrough and explanation here:

**[Link to the Article!!!](https://tinybigtheory.substack.com/p/bubbles-breaking-down-complex-journeys)**
