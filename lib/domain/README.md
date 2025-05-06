# Domain Layer

The Domain layer contains the business logic and use cases of the application.

## Structure

- `entities/`: Business objects representing game entities
- `repositories/`: Interfaces for repositories used by use cases
- `usecases/`: Application use cases implementing business rules

## Purpose

The Domain layer defines the core business logic of the application. It specifies what the application does without concerning itself with the details of data sources or UI.

Key responsibilities:
- Defining business rules
- Specifying repository interfaces
- Implementing use cases
- Defining entity models

## Guidelines

When adding to the Domain layer:
- Focus on business logic rather than implementation details
- Define clear interfaces for repositories
- Create focused use cases for each business requirement
- Keep entities simple and focused on business rules
- Ensure the domain layer is independent of frameworks or external concerns