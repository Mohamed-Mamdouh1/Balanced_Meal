import 'package:flutter/material.dart';
import 'package:meal_app/home/personal_details_page.dart';
import 'package:meal_app/widgets/active_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/th.jpg'),
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balanced Meal',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Craft your ideal meal effortlessly with our app. Select nutritious ingredients tailored to your taste and well-being.',

                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 17,
                        color: Colors.white.withAlpha(200),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ActiveButton(
                      buttonText: "Order Food",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return  PersonalDetailsPage();
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
