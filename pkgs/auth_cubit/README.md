[![Latest version of 'auth_cubit' @ Cloudsmith](https://api-prd.cloudsmith.io/v1/badges/version/evoleen/dart_packages/dart/auth_cubit/latest/a=noarch/?render=true&show_latest=true&badge_token=gAAAAABmJPxvvBNVt6n_bQCQPvrKxYzok70eQ4g89RxVD_07izU-5YJIQNminrg3djryKq6MaGBBPdSUmLZiDL3uHcdJPhQQeqD0gVID80B-Uk2iVT9TXOs%3D)](https://cloudsmith.io/~evoleen/repos/dart_packages/packages/detail/dart/auth_cubit/latest/a=noarch/)

# auth_cubit 
A Flutter library for managing authentication in Flutter applications. This library provides a comprehensive solution for handling authentication processes, including sign-in, sign-out, two-factor authentication, and access token retrieval.

## Features

- **Clear Structure**: The code is well-organized into separate classes and files, making it easy to understand and maintain.
  
- **Documentation**: Detailed comments explain the purpose of each class, method, and parameter, facilitating understanding and usage.

- **Type Safety**: Generics and abstract classes ensure type safety and structured passing of authentication parameters.

- **Error Handling**: Acknowledges potential exceptions during authentication operations and provides documentation to inform users about potential errors.

- **Equality Handling**: Overrides `equals`, `hashCode`, and `isValidKey` methods for proper handling of equality and key validity, crucial for collections.

- **Freezed Integration**: Utilizes the freezed package for state management, simplifying the creation of immutable classes and reducing boilerplate code.

- **Overall**: Provides a robust foundation for implementing authentication in Flutter applications, offering clarity, documentation, type safety, error handling, and integration with state management.

- **Extensibility**: Users can implement custom authentication providers and integrate them with the provided AuthBloc for a tailored authentication solution.

## Installation
Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  auth_cubit: ^0.0.1
```

## Release
```dart
dart run auth_cubit:release
```