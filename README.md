# 021 Trade Watchlist Assignment
## ️ Architecture & Tech Stack

This project follows **Clean Architecture** principles to ensure scalability and maintainability.

- **State Management:** flutter_bloc (using `emit.forEach` for efficient stream handling).
- **Data Layer:** Repository Pattern to decouple business logic from the data source.
- **Model Layer:** Immutable models using Equatable for value-based equality.
- **UI Layer:** Responsive design using Material 3 components.

##  Project Structure

```text
lib/
├── business_logic/
│   ├── bloc/          # StocksBloc For handling business logic of realtime stock api simulation and wishlist reordering 
│   └── cubit/         # ReorderStatusCubit for managing state to show repositioning icon
├── models/            # Immutable Data Models 
├── repositories/      # Data Source for stock market api simulation
├── ui/                # UI Components and Screens
│   └── screens/       # Main StockListScreen
│   └── widgets/        #Stock Tile widget
└── main.dart          # App Entry Point & Dependency Injection
```

##  Approach

### 1. Stock market like api simulation
It was so difficult to implement stock market like api because integrating real api's would be time consuming so i have created simulation and for implementing this simulation i have used streams concepts and added 1 seconds delay for stock price change updates but there was a catch my bloc was not reflecting changes with emit so i have searched the reason and then come up with solution by using emit.forEach

### 2. Swaping logic
When i was swapping the stock then when my stream was emitting new changes my swapped list was getting refreshed so i came up with solution that i was modifying static stock list from StockRepo
