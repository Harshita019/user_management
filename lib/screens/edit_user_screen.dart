import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/controller/user_controller.dart';
import 'package:user_management/screens/user_list_screen.dart';
import 'package:user_management/model/user_model.dart';

class EditUserScreen extends StatefulWidget {
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final UserController userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;
  late TextEditingController pinCodeController;
  late TextEditingController stateController;
  late TextEditingController addressController;
  late TextEditingController jobController;
  late TextEditingController companyController;
  late TextEditingController experienceController;

  String? selectedGender;
  int userIndex = -1;

  @override
  void initState() {
    super.initState();

    final userData = Get.arguments;

    if (userData == null || userData["user"] == null) {
      Get.back();
      return;
    }

    final User user = userData["user"];
    userIndex = userData["index"];

    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    dobController = TextEditingController(text: user.dob);
    pinCodeController = TextEditingController(text: user.pincode);
    addressController = TextEditingController(text: user.address);
    stateController = TextEditingController(text: user.state);
    jobController = TextEditingController(text: user.jobTitle);
    companyController = TextEditingController(text: user.companyName);
    experienceController = TextEditingController(text: user.workExperience);
    selectedGender = user.gender;
  }

  void saveUser() {
    if (_formKey.currentState!.validate()) {
      final updatedUser = User(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        gender: selectedGender ?? "",
        dob: dobController.text.trim(),
        pincode: pinCodeController.text.trim(),
        address: addressController.text.trim(),
        state: stateController.text.trim(),
        jobTitle: jobController.text.trim(),
        companyName: companyController.text.trim(),
        workExperience: experienceController.text.trim(),
      );

      userController.updateUser(userIndex, updatedUser);
      Get.to(UserListScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit User")),
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              commonTextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                labelText: "Name",
                validator: (value) =>
                    value!.isEmpty ? "Name is required" : null,
              ),
              const SizedBox(height: 10),
              commonTextField(
                controller: emailController,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return "Enter a valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(
                  labelText: "Gender",
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                ),
                items: ["Male", "Female"].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
                validator: (value) => (value == null || value.isEmpty)
                    ? "Gender is required"
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: dobController,
                decoration: const InputDecoration(
                  labelText: "DOB",
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
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
                          hintColor: Colors.blue, 
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blue, 
                            onPrimary:
                                Colors.white, 
                            onSurface: Colors.black,
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
              const SizedBox(height: 10),
              commonTextField(
                controller: addressController,
                labelText: "Address",
                keyboardType: TextInputType.name,
                validator: (value) =>
                    value!.isEmpty ? "Address is required" : null,
              ),
              const SizedBox(height: 10),
              commonTextField(
                controller: stateController,
                labelText: "State",
                keyboardType: TextInputType.name,
                validator: (value) =>
                    value!.isEmpty ? "State is required" : null,
              ),
              const SizedBox(height: 10),
              commonTextField(
                controller: pinCodeController,
                labelText: "Pin Code",
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pin Code. is required";
                  }
                  if (value.length != 6) {
                    return "Enter a valid pin code";
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 10),
              commonTextField(
                controller: jobController,
                labelText: "Job Title",
                keyboardType: TextInputType.name,
                validator: (value) =>
                    value!.isEmpty ? "Job Title is required" : null,
              ),
              const SizedBox(height: 10),
              commonTextField(
                controller: companyController,
                labelText: "Company",
                keyboardType: TextInputType.name,
                validator: (value) =>
                    value!.isEmpty ? "Company Name is required" : null,
              ),
              const SizedBox(height: 10),
              commonTextField(
                controller: experienceController,
                labelText: "Experience",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Job Experience is required" : null,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade300,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: saveUser,
                child: const Text("Save Changes"),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  TextFormField commonTextField({
    required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.lightBlue,
          fontWeight: FontWeight.bold,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
