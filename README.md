# Ecommerce App - Clean Architecture

This is a Flutter-based eCommerce application designed using Clean Architecture principles.

## 📁 Architecture Layers


## 🔄 Data Flow

1. **UI Layer**: User interaction triggers a method in a provider/controller.
2. **Use Case Layer**: The provider calls a use case.
3. **Repository Layer**: The use case delegates to the repository interface.
4. **Data Layer**: The repository implementation handles network or local data access.
5. **Model Layer**: Converts JSON to `ProductModel`, which extends the domain `Product` entity.

## ✅ Features

- Clean and scalable architecture
- Well-separated domain, data, and UI layers
- Full test coverage on entities, use cases, and models

## 📦 Technologies

- Flutter
- Dart
- Mockito for unit testing
- Dartz for functional error handling

## 🧪 Testing

Use the following command to run all tests:

```bash
flutter test
