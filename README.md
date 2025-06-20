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


