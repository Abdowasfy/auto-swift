import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  final String? value;
  final String valid, hint;
  final List<DropdownMenuItem<String>>? items;
  final Function(dynamic v)? onChanged;
  const CustomDropDown({
    super.key,
    this.value,
    required this.valid,
    required this.hint,
    this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      initialValue: value,
      validator: (value) => value == null ? valid : null,

      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.w)),
      ),
    );
  }
}
