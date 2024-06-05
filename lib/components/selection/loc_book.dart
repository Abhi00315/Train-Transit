import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final TextEditingController controller;
  final List<String> options;
  final void Function(String?)? onSelected;
  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const CustomDropdown({
    Key? key,
    required this.controller,
    required this.options,
    required this.label,
    this.onSelected,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return widget.options.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String? selected) {
            setState(() {
              widget.controller.text = selected ?? '';
              if (widget.onSelected != null) {
                widget.onSelected!(selected);
              }
            });
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController fieldController,
              FocusNode fieldFocusNode,
              void Function() onFieldSubmitted) {
            return TextFormField(
              controller: fieldController,
              focusNode: fieldFocusNode,
              onFieldSubmitted: (_) => onFieldSubmitted(),
              decoration: InputDecoration(
                labelText: widget.label,
                filled: true,
                prefixIcon:
                    widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
                suffixIcon:
                    widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20), // Adjust the spacing between dropdown boxes
      ],
    );
  }
}
