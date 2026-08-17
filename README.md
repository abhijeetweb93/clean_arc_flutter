# clean_arc_flutter

A Flutter project demonstrating **Clean Architecture** principles with **BLoC** state management. This project is built for learning and understanding Clean Architecture in Flutter applications.

## 📖 Project Purpose

This project is designed to understand Clean Architecture in Flutter. It includes three features:

- **Login** — User login
- **Signup** — Create a new account
- **Home** — View product list

The project uses the [Fake Store API](https://fakestoreapi.com/) for API calls.

---

## 🏗️ Architecture Overview

This project follows the **three layers** of Clean Architecture:

```
lib/
├── core/                    # Shared code across all features
│   ├── constants/           # App constants (API URLs, etc.)
│   ├── network/             # ApiClient (Dio), ApiEndpoints
│   ├── theme/               # App colors and theme
│   ├── use_case/            # Abstract UseCase base class
│   └── utils/               # Utility classes (AssetLoader)
├── features/                # Feature-based modules
│   ├── home/
│   ├── login/
│   └── signup/
├── locator.dart             # Dependency Injection (GetIt)
└── main.dart                # App entry point
```

### Three Layers of Clean Architecture

```
┌─────────────────────────────────────────────┐
│           PRESENTATION LAYER                 │
│   (UI Widgets, BLoC, Events, States)         │
├─────────────────────────────────────────────┤
│             DOMAIN LAYER                     │
│   (Entities, Repository Interfaces,          │
│    UseCases)                                 │
├─────────────────────────────────────────────┤
│              DATA LAYER                      │
│   (DataSources, Repository Implementations,  │
│    Models)                                   │
└─────────────────────────────────────────────┘
```

#### 1. **Domain Layer** (Business Logic — innermost layer)

This is the innermost layer and does not depend on any external dependencies.

| Component | Description |
|-----------|-------------|
| **Entities** | Pure business objects (e.g., `ProductEntity`, `SignupEntity`, `UserEntity`) extending `Equatable` |
| **Repository Interfaces** | Abstract repository contracts (e.g., `HomeRepositories`, `SignupRepositories`, `LoginRepositories`) |
| **UseCases** | Application-specific business rules (e.g., `LoadData`, `LoginUseCase`, `SignupUseCase`) — all extend/implement abstract `UseCase<T, P>` |

**Example — UseCase base class:**
```dart
abstract class UseCase<T, P> {
  Future<Either<Exception, T>> call(P params);
}
```

#### 2. **Data Layer** (Data Access)

This layer implements the repository interfaces from the Domain Layer.

| Component | Description |
|-----------|-------------|
| **Datasources** | Remote/Local data sources (e.g., `HomeDataSourceImpl`, `LoginDataSourceImpl`, `SignupDataSourceImpl`) — uses `Dio` via `ApiClient` |
| **Repository Implementations** | Concrete implementations of domain repository interfaces (e.g., `HomeRepositoriesImpl`, `LoginRepositoriesImpl`, `SignupRepositoriesImpl`) |
| **Models** | Data models with `fromJson`/`toJson` that extend domain entities (e.g., `ProductModel`, `SignupModel`, `SignupResponseModel`) |

**Data flow example (Home):**
```
HomeDataSourceImpl (Dio GET /products)
    → returns Either<Exception, ProductListModel>
    → HomeRepositoriesImpl delegates to datasource
    → LoadData UseCase calls repository
    → HomeBloc calls UseCase and emits state
```

#### 3. **Presentation Layer** (UI + State Management)

| Component | Description |
|-----------|-------------|
| **Pages/Widgets** | Flutter UI (e.g., `LoginPage`, `SignupPage`, `HomePage`) |
| **BLoC** | State management using `flutter_bloc` (e.g., `HomeBloc`, `LoginBloc`, `SignupBloc`) |
| **Events & States** | BLoC events and states using `Equatable` (e.g., `HomeState` → `HomeInitial`, `HomeLoading`, `HomeSuccess`, `HomeError`) |

---

## 📁 Feature Structure (Example: Home)

```
lib/features/home/
├── data/
│   ├── datasources/
│   │   └── home_data_source.dart          # Abstract + Impl (Dio API calls)
│   ├── models/
│   │   └── notes_model.dart               # ProductModel, ProductListModel (JSON mapping)
│   └── repositories/
│       └── home_repositories_impl.dart    # HomeRepositoriesImpl
├── domain/
│   ├── entities/
│   │   └── notes_entity.dart              # ProductEntity, ProductListEntity
│   ├── repositories/
│   │   └── home_repositories.dart         # Abstract HomeRepositories
│   └── usecases/
│       └── load_data.dart                 # LoadData UseCase
└── presentation/
    ├── bloc/
    │   ├── home_bloc.dart                 # HomeBloc + Events (part file)
    │   └── home_state.dart                # HomeState (part file)
    └── pages/
        └── home_page.dart                 # HomePage widget
```

Login and Signup features follow the same pattern.

---

## 🔧 Key Technologies & Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^8.1.3 | State management (BLoC pattern) |
| `dio` | ^5.4.0 | HTTP client for API calls |
| `get_it` | ^7.6.4 | Dependency injection (Service Locator) |
| `dartz` | ^0.10.1 | Functional programming — `Either` for error handling |
| `equatable` | ^2.0.5 | Value equality for entities/states (BLoC comparison) |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `bloc_test` | ^9.1.5 | Testing BLoC |
| `mockito` | ^5.4.3 | Mocking dependencies in tests |
| `mocktail` | ^1.0.0 | Mocking (alternative to mockito) |
| `build_runner` | ^2.4.7 | Code generation runner |
| `json_serializable` | ^6.7.1 | JSON serialization code generation |
| `flutter_lints` | ^3.0.1 | Lint rules |

---

## 🔌 Dependency Injection (GetIt)

All dependencies are registered via `GetIt` in `lib/locator.dart`. The `initDependencies()` function is called in `main.dart` when the app starts.

```dart
final locator = GetIt.instance;

Future<void> initDependencies() async {
  // Api Client
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: ApiConstants.baseUrl),
  );

  // Login
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl(apiClient: locator()));
  locator.registerLazySingleton<LoginRepositories>(() => LoginRepositoriesImpl(locator()));
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: locator(), logoutUseCase: locator()));

  // Signup
  locator.registerLazySingleton<SignupDataSource>(() => SignupDataSourceImpl(apiClient: locator()));
  locator.registerLazySingleton<SignupRepositories>(() => SignupRepositoriesImpl(locator()));
  locator.registerLazySingleton<SignupUseCase>(() => SignupUseCase(locator()));
  locator.registerFactory<SignupBloc>(() => SignupBloc(signupUseCase: locator()));

  // Home
  locator.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl(locator()));
  locator.registerLazySingleton<HomeRepositories>(() => HomeRepositoriesImpl(locator()));
  locator.registerLazySingleton<LoadData>(() => LoadData(locator()));
  locator.registerFactory<HomeBloc>(() => HomeBloc(locator()));
}
```

> **Note:** `registerLazySingleton` is used for DataSources, Repositories, and UseCases (same instance is reused). `registerFactory` is used for BLoCs (a new instance is created each time).

---

## 🌐 Network Layer

### ApiClient (`lib/core/network/api_client.dart`)
- Wraps the `Dio` HTTP client.
- Configures base URL, timeout, headers, and interceptors.
- Includes an auth token interceptor (placeholder) and an error interceptor (401 handling).

### ApiConstants (`lib/core/constants/api_constants.dart`)
- All API URLs are centralized in one place.
- Base URL: `https://fakestoreapi.com/`
- Endpoints: `/auth/login`, `/users`, `/products`

### ApiEndpoints (`lib/core/network/api_endpoints.dart`)
- References endpoint paths from `ApiConstants`.

---

## 🔄 Error Handling (Functional Approach with `dartz`)

Error handling throughout the project is done using `Either<Exception, T>`:

```dart
// DataSource example
Future<Either<Exception, ProductListModel>> loadData() async {
  try {
    final response = await _apiClient.dio.get(ApiEndpoints.products);
    // ... parse response
    return Right(ProductListModel(products));  // success
  } on DioException catch (ex) {
    return Left(Exception(ex.response?.data.toString()));  // error
  } catch (ex) {
    return Left(Exception(ex.toString()));  // error
  }
}
```

In the BLoC, `fold` is used to handle success/error:

```dart
final items = await _loadData.call(NoParams());
items.fold(
  (error) => emit(HomeError(error.toString())),
  (data) => emit(HomeSuccess(data)),
);
```

---

## 🧩 Features Implementation Details

### 1. Login Feature
- **Pages:** `LoginPage` — animated gradient UI with email/password fields and social login buttons
- **BLoC:** `LoginBloc` — handles `DoLoginEvent`, emits `LoginInitial`/`LoginLoading`/`LoginSuccess`/`LoginError`
- **UseCases:** `LoginUseCase` (takes `(email, password)` tuple as params), `LogoutUseCase`
- **API:** `POST /auth/login`
- **Flow:** LoginPage → LoginBloc → LoginUseCase → LoginRepositories → LoginDataSource → Dio

### 2. Signup Feature
- **Pages:** `SignupPage` — animated gradient UI with username, email, password, and confirm password fields
- **BLoC:** `SignupBloc` — handles `DoSignupEvent`, emits `SignupInitial`/`SignupLoading`/`SignupSuccess`/`SignupError`
- **UseCase:** `SignupUseCase` (takes `SignupEntity` as params)
- **API:** `POST /users`
- **Flow:** SignupPage → SignupBloc → SignupUseCase → SignupRepositories → SignupDataSource → Dio

### 3. Home Feature
- **Pages:** `HomePage` — product list with refresh indicator, card-based UI, add item dialog
- **BLoC:** `HomeBloc` — handles `LoadHomeItemsEvent`, emits `HomeInitial`/`HomeLoading`/`HomeSuccess`/`HomeError`
- **UseCase:** `LoadData` (takes `NoParams`)
- **API:** `GET /products`
- **Flow:** HomePage → HomeBloc → LoadData UseCase → HomeRepositories → HomeDataSource → Dio

---

## 🎨 Theming

A centralized color palette is defined in `lib/core/theme/app_colors.dart`:

- **Primary/Secondary Colors** — Brand colors
- **Background Colors** — Light & dark backgrounds
- **Text Colors** — Primary, secondary, hint
- **Status Colors** — Success, error, warning, info
- **Gradient Colors** — Ocean, Sunset, Forest gradients
- **Social Colors** — Google, Facebook, Apple

---

## 📦 Assets

The project includes mock JSON data:

```
assets/
└── mock/
    └── home_data.json    # Mock home data for offline/testing
```

Assets are loaded via the `AssetLoader` utility class (`lib/core/utils/asset_loader.dart`).

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0

### Installation & Run

```bash
# 1. Install dependencies
flutter pub get

# 2. Run the app
flutter run
```

### Build

```bash
# Android APK
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

---

## 🧪 Testing

The project has testing dependencies set up:

```bash
# Run all tests
flutter test

# Tests with coverage
flutter test --coverage
```

Testing tools available:
- `bloc_test` — BLoC state testing
- `mockito` / `mocktail` — Mock dependencies
- `flutter_test` — Widget testing

---

## 📋 Clean Architecture Rules (Followed in this project)

1. **Dependency Rule:** Dependencies always point inward (Presentation → Domain ← Data). The Domain Layer does not depend on anything.
2. **Separation of Concerns:** Each layer has its own responsibility.
3. **Dependency Inversion:** The Domain Layer defines repository interfaces; the Data Layer implements them.
4. **Single Responsibility:** Each UseCase has a single responsibility.
5. **Feature-based Structure:** Features are independent of each other.
6. **Functional Error Handling:** `Either` (dartz) for explicit error handling.
7. **Dependency Injection:** GetIt for loose coupling.

---

## 📂 Complete Project Structure

```
clean_arc_flutter/
├── lib/
│   ├── main.dart                              # Entry point
│   ├── locator.dart                           # DI setup (GetIt)
│   ├── core/
│   │   ├── constants/
│   │   │   └── api_constants.dart              # API URLs & constants
│   │   ├── network/
│   │   │   ├── api_client.dart                 # Dio wrapper
│   │   │   └── api_endpoints.dart              # Endpoint paths
│   │   ├── theme/
│   │   │   └── app_colors.dart                 # Color palette
│   │   ├── use_case/
│   │   │   └── use_case.dart                   # Abstract UseCase<T,P>
│   │   └── utils/
│   │       └── asset_loader.dart               # Asset loading utility
│   └── features/
│       ├── home/
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── home_data_source.dart
│       │   │   ├── models/
│       │   │   │   └── notes_model.dart
│       │   │   └── repositories/
│       │   │       └── home_repositories_impl.dart
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── notes_entity.dart
│       │   │   ├── repositories/
│       │   │   │   └── home_repositories.dart
│       │   │   └── usecases/
│       │   │       └── load_data.dart
│       │   └── presentation/
│       │       ├── bloc/
│       │       │   ├── home_bloc.dart
│       │       │   └── home_state.dart
│       │       └── pages/
│       │           └── home_page.dart
│       ├── login/
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   │   └── login_data_source.dart
│       │   │   └── repositories/
│       │   │       └── login_repositories_impl.dart
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── login_entity.dart
│       │   │   ├── repositories/
│       │   │   │   └── login_repositories.dart
│       │   │   └── usecases/
│       │   │       ├── login_usecase.dart
│       │   │       └── logout_usecase.dart
│       │   └── presentation/
│       │       ├── bloc/
│       │       │   └── login_bloc.dart
│       │       └── pages/
│       │           └── login_page.dart
│       └── signup/
│           ├── data/
│           │   ├── datasources/
│           │   │   └── signup_data_source.dart
│           │   ├── models/
│           │   │   └── signup_model.dart
│           │   └── repositories/
│           │       └── signup_repositories_impl.dart
│           ├── domain/
│           │   ├── entities/
│           │   │   └── signup_entity.dart
│           │   ├── repositories/
│           │   │   └── signup_repositories.dart
│           │   └── usecases/
│           │       └── signup_usecase.dart
│           └── presentation/
│               ├── bloc/
│               │   └── signup_bloc.dart
│               └── pages/
│                   └── signup_page.dart
├── assets/
│   └── mock/
│       └── home_data.json
├── test/
│   └── widget_test.dart
└── pubspec.yaml
```

---

## 🔗 API Reference

This project uses the [Fake Store API](https://fakestoreapi.com/):

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/login` | User login |
| `POST` | `/users` | User registration |
| `GET` | `/products` | Get all products |

---

## 📝 Credentials To login:
```
User Id: mor_2314
Password: 83r5^_
```

## 📝 License

This project is for educational purposes — understanding Clean Architecture in Flutter.# clean_arc_flutter



