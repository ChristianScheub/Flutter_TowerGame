# Presentation Layer

The Presentation layer handles all user interface components and user interaction.

## Structure

- `blocs/`: BLoC (Business Logic Component) state management
- `pages/`: Top-level screens of the application
- `widgets/`: Reusable UI components
- `routes/`: Navigation and routing
- `game/`: Game-specific rendering and logic using Flame

## Purpose

The Presentation layer is responsible for:
- Displaying game elements and UI to the user
- Handling user input
- Managing application state using BLoC pattern
- Navigating between screens

## Guidelines

When working with the Presentation layer:
- Separate UI components into small, reusable widgets
- Use BLoC for state management
- Keep UI components free of business logic
- Handle navigation through a centralized router
- Follow Flutter best practices for performance