<<<<<<< HEAD
# meal_app

A  Flutter project make users choose  their meals depending on their cal .

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# Balanced_Meal
This Flutter-based application allows users to create a personalized food order by selecting ingredients from multiple categories (Vegetables, Meats, and Carbs) while tracking total calorie intake based on their personal health data. The app dynamically interacts with Firebase Firestore and integrates with an external API to place food orders.

 User Flow:
1- User Info Input:

The user is asked to enter their gender, weight, height, and age.

The app calculates their daily required calories using gender-based formulas.

2- Create Order Page:

The user sees a categorized list of ingredients fetched from Firebase Firestore (Vegetables, Meats, Carbs).

Each ingredient displays an image, name, calorie value, and an "Add" button.

When ingredients are added, the total calorie and price update live.

Calories must stay under the user’s limit to proceed.

3- Order Summary Page:

Shows a summary of the selected ingredients.

Allows the user to increase or decrease quantity using + / - buttons.

Calorie and price totals update automatically.

A Confirm button sends the final order to a backend API.


>>>>>>> d7bb6a56ce28da3b1ba0395684775a5533c821b9
