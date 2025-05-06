# Core Layer

The Core layer contains the fundamental building blocks of the application that are used across different layers.

## Structure

- `constants/`: Application-wide constants like colors, theme settings, and asset paths
- `injection/`: Dependency injection setup and configuration
- `storage/`: Local storage implementation for persisting game data
- `utils/`: Utility functions and helper classes

## Purpose

The Core layer serves as the foundation for the application, providing functionality that is shared across the other layers (Data, Domain, and Presentation). It should not depend on any other layer.

Key responsibilities:
- Providing fundamental utilities
- Setting up dependency injection
- Managing local storage
- Defining constants and configurations

## Guidelines

When adding to the Core layer:
- Keep code generic and reusable
- Avoid dependencies on other layers
- Follow clean code practices
- Document all public APIs