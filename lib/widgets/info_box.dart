import 'package:flutter/material.dart';

class InfoBox extends StatefulWidget {
  final IconData icon;
  final String label;
  final TextInputType tit;
  final bool editable;
  TextEditingController controller;

  InfoBox({
    Key? key,
    required this.icon,
    required this.label,
    required this.tit,
    required this.editable,
    required this.controller,
  }) : super(key: key);

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Required';
            }
            return null;
          },
          keyboardType: widget.tit,
          readOnly: !(widget.editable),
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            prefixIcon: widget.editable ? Icon(widget.icon) : Icon(Icons.lock),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
