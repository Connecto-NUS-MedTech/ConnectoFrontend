import 'package:flutter/material.dart';

enum SwitchStatus { on, off, neither }

class CustomSwitch extends StatefulWidget {
  SwitchStatus value;
  ValueChanged<SwitchStatus> onChanged;

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

// manually toggle main switch
  void toggleSwitch() {
    print('in toggleSwitch BEFORE: ${widget.value}');
    setState(() {
      // If the previous SwitchStatus is neither or off, toggling it will turn it on
      if (widget.value == SwitchStatus.neither ||
          widget.value == SwitchStatus.off) {
        widget.value = SwitchStatus.on;
      } else {
        widget.value = SwitchStatus.off;
      }
      // widget.value =
      //     widget.value == SwitchStatus.on ? SwitchStatus.off : SwitchStatus.on;
      widget.onChanged(widget.value);
      print('in toggleSwitch AFTER: ${widget.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: toggleSwitch,
          child: Container(
            decoration: BoxDecoration(
              // if status is off or neither, white background
              color: widget.value == SwitchStatus.off
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
                  color: widget.value == SwitchStatus.off
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
          child: Container(
            decoration: BoxDecoration(
              // if status is off or neither, white background
              color: widget.value == SwitchStatus.on
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
                  color: widget.value == SwitchStatus.on
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
