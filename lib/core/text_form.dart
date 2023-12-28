import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFiled extends StatelessWidget {
  TextFormFiled(
      {super.key,
      required this.type,
      required this.titleController,
      required this.text,
      required this.icon,
      this.onTap});
  var titleController = TextEditingController();
  final TextInputType type;
  final String text;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      onTap: onTap,
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return 'must not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
