import 'package:flutter/material.dart';

class StationDropdown extends StatefulWidget {
  final TextEditingController controller;
  final List<String> options;
  final String label;

  const StationDropdown({
    super.key,
    required this.controller,
    required this.options,
    required this.label,
  });

  @override
  StationDropdownState createState() => StationDropdownState();
}

class StationDropdownState extends State<StationDropdown> {
  String? selectedStation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        DropdownButtonFormField<String>(
          value: selectedStation,
          onChanged: (String? newValue) {
            setState(() {
              selectedStation = newValue;
              widget.controller.text = newValue ?? '';
            });
          },
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: const InputDecoration(
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        const SizedBox(height: 20), // Adjust the spacing between dropdown boxes
      ],
    );
  }
}
