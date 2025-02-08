import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/controller/user_controller.dart';
import 'package:user_management/model/user_model.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final pinCodeController = TextEditingController();

  final stateController = TextEditingController();
  final addressController = TextEditingController();
  final jobController = TextEditingController();
  final companyController = TextEditingController();
  final experienceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.lightBlue.shade300,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 3) {
                if (_validateStep(_currentStep)) {
                  setState(() => _currentStep++);
                }
              } else {
                // Final step validation before saving user
                if (!_validateStep(2)) return;

                final user = User(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  gender: genderController.text.trim(),
                  dob: dobController.text.trim(),
                  pincode: pinCodeController.text.trim(),
                  state: stateController.text.trim(),
                  address: addressController.text.trim(),
                  jobTitle: jobController.text.trim(),
                  companyName: companyController.text.trim(),
                  workExperience: experienceController.text.trim(),
                );

                final userController = Get.find<UserController>();
                userController.addUser(user);
                Get.back();
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) setState(() => _currentStep--);
            },
            steps: [
              Step(
                title: const Text("Basic Details"),
                isActive: _currentStep >= 0,
                state:
                    _currentStep > 0 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (value) =>
                          value!.isEmpty ? "Name is required" : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: DropdownButtonFormField<String>(
                        value: genderController.text.isNotEmpty
                            ? genderController.text
                            : null,
                        decoration: const InputDecoration(
                          labelText: "Gender",
                        ),
                        isDense: true, 
                        items: ["Male", "Female"].map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            genderController.text = newValue ?? "";
                          });
                        },
                        validator: (value) => (value == null || value.isEmpty)
                            ? "Gender is required"
                            : null,
                      ),
                    ),
                    TextFormField(
                      controller: dobController,
                      decoration: const InputDecoration(
                        labelText: "DOB",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor:
                                    Colors.blue, 
                                hintColor:
                                    Colors.blue,
                                colorScheme: const ColorScheme.light(
                                  primary:
                                      Colors.blue, 
                                  onPrimary: Colors
                                      .white,
                                  onSurface:
                                      Colors.black, 
                                ),
                                dialogBackgroundColor:
                                    Colors.white, 
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          setState(() {
                            dobController.text = formattedDate;
                          });
                        }
                      },
                      validator: (value) =>
                          value!.isEmpty ? "Date of Birth is required" : null,
                    ),
                  
                  ],
                ),
              ),
              Step(
                title: const Text("Employment Details"),
                isActive: _currentStep >= 1,
                state:
                    _currentStep > 1 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: jobController,
                      decoration: const InputDecoration(labelText: "Job Title"),
                      validator: (value) =>
                          value!.isEmpty ? "Job Title is required" : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: companyController,
                      decoration:
                          const InputDecoration(labelText: "Company Name"),
                      validator: (value) =>
                          value!.isEmpty ? "Company Name is required" : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: experienceController,
                      decoration: const InputDecoration(
                          labelText: "Experience", hintText: "in months"),
                      validator: (value) =>
                          value!.isEmpty ? "Job Experience is required" : null,
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text("Address Details"),
                isActive: _currentStep >= 2,
                state:
                    _currentStep > 2 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    
                    
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: addressController,
                      decoration: const InputDecoration(labelText: "Address"),
                      validator: (value) =>
                          value!.isEmpty ? "Address is required" : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: stateController,
                      decoration:
                          const InputDecoration(labelText: "State"),
                      validator: (value) =>
                          value!.isEmpty ? "State is required" : null,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: pinCodeController,
                      decoration:
                          const InputDecoration(labelText: "Pin Code"),
                      validator: (value) =>
                          value!.isEmpty ? "Pin Code is required" : null,
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text("Confirmation"),
                isActive: _currentStep >= 3,
                state: StepState.indexed,
                content: const Text("Review your details before submitting."),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateStep(int stepIndex) {
    switch (stepIndex) {
      case 0: // Basic Details
        if (nameController.text.isEmpty ||
            emailController.text.isEmpty ||
            genderController.text.isEmpty ||
            dobController.text.isEmpty) {
          Get.snackbar("Error", "Please fill all fields in this step",
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }

        // Email Validation
        String emailPattern =
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
        RegExp emailRegex = RegExp(emailPattern);
        if (!emailRegex.hasMatch(emailController.text)) {
          Get.snackbar("Error", "Enter a valid email address",
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
        break;

      case 1: // Employment Details
        if (jobController.text.isEmpty ||
            companyController.text.isEmpty ||
            experienceController.text.isEmpty) {
          Get.snackbar("Error", "Please fill all fields in this step",
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
        break;

      case 2: // Address Details
        if (pinCodeController.text.isEmpty || addressController.text.isEmpty || stateController.text.isEmpty) {
          Get.snackbar("Error", "Please fill all fields in this step",
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }

        // Pin Code Validation
        String phonePattern = r'^[0-9]{6}$';
        RegExp phoneRegex = RegExp(phonePattern);
        if (!phoneRegex.hasMatch(pinCodeController.text)) {
          Get.snackbar("Error", "Enter a valid 6-digit pin code",
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
        break;
    }
    return true;
  }
}
