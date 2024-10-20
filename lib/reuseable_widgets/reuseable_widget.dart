import 'package:flutter/material.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType, TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.teal, // Changed the cursor color for better contrast
    style: const TextStyle(color: Colors.black87), // Text color
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.teal.shade600), // Changed icon color
      labelText: text,
      labelStyle: const TextStyle(color: Colors.teal), // Label color
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto, // Floating label behavior for better UX
      fillColor: Colors.grey.shade200, // Soft background color
      contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0), // Better padding for the field
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.teal.shade600, width: 2.0), // Color for focused border
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.grey, width: 1.0), // Color for normal border
      ),
    ),
    keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}


Container signInSignUpButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.85, // Adjusted width for a nicer look
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.teal.shade800; // Darker color when pressed
            } else if (states.contains(MaterialState.hovered)) {
              return Colors.teal.shade700; // Darker color when hovered
            }
            return Colors.teal; // Default color
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 15),
        ), // Better padding for button
      ),
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
          color: Colors.white, // Text color
          fontWeight: FontWeight.bold, 
          fontSize: 18, // Increased font size for better readability
        ),
      ),
    ),
  );
}