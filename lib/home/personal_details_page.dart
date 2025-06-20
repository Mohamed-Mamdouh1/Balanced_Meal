import 'package:flutter/material.dart';
import 'package:meal_app/home/ingredients_page.dart';
import 'package:meal_app/widgets/details_text_form_field.dart';

enum Gender {
  Male,
  Female,
}
class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedGender;
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();

  bool get isFormValid {
    return selectedGender != null &&
        weightController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        ageController.text.isNotEmpty;
  }
  double calculateCalories({
    required String gender,
    required double weightKg,
    required double heightCm,
    required int age,
  }) {
    if (gender.toLowerCase() == 'female') {
      return 655.1 + (9.56 * weightKg) + (1.85 * heightCm) - (4.67 * age);
    } else {
      return 666.47 + (13.75 * weightKg) + (5 * heightCm) - (6.75 * age);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Enter your details'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            onChanged: () => setState(() {}),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: inputDecoration(hint: 'Choose your gender'),
                  value: selectedGender,
                  items: [Gender.Male.name.toString(), Gender.Female.name.toString()]
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selectedGender == gender
                                  ? Colors.orange.shade100
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(gender),
                                if (selectedGender == gender)
                                  Icon(Icons.done, color: Colors.orange),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  selectedItemBuilder: (context) {
                    return [
                      'Male',
                      'Female',
                    ].map((gender) => Text(gender)).toList();
                  },
                  onChanged: (value) => setState(() => selectedGender = value),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Weight',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DetailsTextFormField(
                  controller: weightController,
                  keyBoardType: TextInputType.number,
                  hint: 'Enter your weight',
                  suffixText: 'Kg',
                ),
                const SizedBox(height: 20),

                const Text(
                  'Height',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DetailsTextFormField(
                  controller: heightController,
                  keyBoardType: TextInputType.number,
                  hint: 'Enter your height',
                  suffixText: 'Cm',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Age',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DetailsTextFormField(
                  controller: ageController,
                  keyBoardType: TextInputType.number,
                  hint: 'Enter your age',
                  maxLength: 2,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isFormValid
                        ? () {
                      final weight = double.tryParse(weightController.text) ;
                      final height = double.tryParse(heightController.text) ;
                      final age = int.tryParse(ageController.text) ;

                      final calories = calculateCalories(
                        gender: selectedGender!,
                        weightKg: weight!,
                        heightCm: height!,
                        age: age!,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateOrderPage(userCalorieLimit: calories,),
                        ),
                      );

                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepOrange,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isFormValid
                        ? const Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          )
                        : Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
