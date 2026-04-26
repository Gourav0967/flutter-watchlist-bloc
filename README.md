# Flutter Watchlist (Assignment)

This project is a simple watchlist screen built using Flutter as part of an assignment. The main goal was to implement reordering of stocks using BLoC state management.

---

## What I implemented

- Reorderable watchlist using drag & drop
- State management using BLoC
- Swipe to delete (extra feature)
- Clean UI with basic trading-style layout
- Smooth drag animation

---

## Approach

I used the BLoC pattern to keep UI and logic separate.

- BLoC handles all state changes (reorder, delete, load data)
- UI listens to state and updates accordingly
- Repository provides stock data

Reordering is handled inside the BLoC by creating a new list, removing the item from old index and inserting it at the new index.

---

## Project Structure

I followed a feature-based structure:

lib/
 └── features/
      └── watchlist/
           ├── data/
           ├── presentation/
                ├── bloc/
                ├── cubit/
                ├── screens/
                ├── widgets/

---
## Screenshots

### Watchlist Screen
![Watchlist](assets/screenshots/home.jpg)

### Drag & Reorder
![Drag1](assets/screenshots/drag1.jpg)
![Drag](assets/screenshots/drag2.jpg)


### Swipe to Delete
![Delete](assets/screenshots/delete.png)

## How to run

```bash
git clone https://github.com/Gourav0967/flutter-watchlist-bloc.git
cd flutter-watchlist-bloc
flutter pub get
flutter run