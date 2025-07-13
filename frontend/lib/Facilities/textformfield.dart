import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

final String texthint ;
final AutovalidateMode? mode;
final Icon? icon ;
final String? Function(String?)? val;
final TextEditingController controller;

  const CustomTextField({super.key, required this.texthint, required this.controller,   this.icon, this.val,  this.mode} );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                    validator: val,
                    autovalidateMode: mode,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fillColor: Colors.grey[200],
                        filled: true,
                        suffixIcon: icon,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: texthint,
                        helperText: "",
                        errorStyle: TextStyle(height: 1),
                        contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10)
                        ),
                    controller: controller,
                  );
  }
}