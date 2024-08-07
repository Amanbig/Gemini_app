# Gem AI App

Gem AI App is a versatile application that allows users to generate various types of creative content, including songs, stories, and paragraphs. It also features a dynamic conversation module with an AI model, as well as built-in connectivity checks.

<div align="center">
  <img src="https://github.com/Amanbig/Gemini_app/blob/main/homepage.png" alt="HomePage" width="200"/>
  <img src="https://github.com/Amanbig/Gemini_app/blob/main/genpage.png" alt="Gen Page" width="200"/>
  <img src="https://github.com/Amanbig/Gemini_app/blob/main/randomChat.png" alt="Chat Page" width="200"/>
</div>

## Features

- **Generate Content**: Create songs, stories, and paragraphs through a user-friendly interface.
- **Random Chat**: Engage in real-time conversations with an AI model.
- **Connectivity Check**: Automatically checks for internet connectivity and provides feedback if no connection is detected.
- **Animations**: Smooth animations enhance the user experience.
- **Retry Mechanism**: Allows users to retry connection if there is no internet.

## Installation

To get started with Gem AI App, follow these steps:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/Amanbig/Gemini_app.git
    ```

2. **Navigate to the project directory**:
    ```bash
    cd Gemini_app
    ```

3. **Install dependencies**:
    ```bash
    flutter pub get
    ```
4. **Create Environment File**:

   Create a `.env` file in the root directory of the project and add your API credentials:

    ```plaintext
    API_KEY=your_api_key_here
    ```
   
5. **Run the app**:
    ```bash
    flutter run
    ```

## Usage

After installing the app, you can:

- **Generate Content**: Select the type of content you want to generate from the home page.
- **Engage in Chat**: Navigate to the Random Chat section to start a conversation with the AI.

## Code Overview

- **`lib/screens/home_page.dart`**: Contains the main home screen with content generation options and connectivity checks.
- **`lib/screens/generate_page.dart`**: Handles the content generation functionality.
- **`lib/screens/random_chat.dart`**: Manages the random chat feature with AI.
- **`lib/components/parts.dart`**: Provides reusable UI components used throughout the app.

## Contributing

If you would like to contribute to this project, please fork the repository and create a pull request with your changes.