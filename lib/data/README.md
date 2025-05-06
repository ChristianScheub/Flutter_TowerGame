# Data Layer

The Data layer handles all data operations in the application, including data models and repositories.

## Structure

- `models/`: Data model classes representing game entities
- `repositories/`: Implementation of repository interfaces defined in the Domain layer
- `sources/`: Data sources (local, remote, etc.)

## Purpose

The Data layer is responsible for:
- Providing concrete implementations of repository interfaces
- Defining data models
- Handling data persistence
- Managing data validation and transformation

## Guidelines

When working with the Data layer:
- Implement repository interfaces from the Domain layer
- Keep data models simple and focused on data representation
- Handle data validation and transformation
- Document repository implementations and data models