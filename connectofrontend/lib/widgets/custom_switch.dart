import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  bool value;
  ValueChanged<bool> onChanged;

  CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() {
    return _CustomSwitchState();
  }
}

class _CustomSwitchState extends State<CustomSwitch> {
  final Color _primaryColor = const Color(0xFF455A64);
  final Color _selectedText = const Color(0xFFA5A5A5);

  void toggleSwitch() {
    setState(() {
      widget.value = !widget.value;
      widget.onChanged(widget.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: toggleSwitch,
          // () {
          //   setState(() {
          //     widget.value = !widget.value;
          //     widget.onChanged(widget.value);
          //   });
          // },
          child: Container(
            decoration: BoxDecoration(
              color: widget.value == false
                  ? _primaryColor
                  : const Color(0xFFFFFFFF),
              border: Border(
                top: BorderSide(width: 1, color: _primaryColor),
                right: BorderSide(width: 0.5, color: _primaryColor),
                bottom: BorderSide(width: 1, color: _primaryColor),
                left: BorderSide(width: 1, color: _primaryColor),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
              child: Text(
                'OFF',
                style: TextStyle(
                  color: widget.value == false
                      ? const Color(0xFFFFFFFF)
                      : _selectedText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: toggleSwitch,
          // () {
          //   setState(() {
          //     widget.value = !widget.value;
          //     widget.onChanged(widget.value);
          //   });
          // },
          child: Container(
            decoration: BoxDecoration(
              color: widget.value == true
                  ? _primaryColor
                  : const Color(0xFFFFFFFF),
              border: Border(
                top: BorderSide(width: 1, color: _primaryColor),
                right: BorderSide(width: 1, color: _primaryColor),
                bottom: BorderSide(width: 1, color: _primaryColor),
                left: BorderSide(width: 0.5, color: _primaryColor),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 24, 8),
              child: Text(
                'ON',
                style: TextStyle(
                  color: widget.value == true
                      ? const Color(0xFFFFFFFF)
                      : _selectedText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
