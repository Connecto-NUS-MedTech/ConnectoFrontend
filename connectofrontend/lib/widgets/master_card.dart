import 'package:flutter/material.dart';

class MasterCard extends StatefulWidget {
  final String cardText;
  bool cardState;

  MasterCard({Key? key, required this.cardText, required this.cardState})
      : super(key: key);

  @override
  State<MasterCard> createState() {
    return _MasterCardState();
  }
}

class _MasterCardState extends State<MasterCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.cardText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 56,
            ),
            Switch.adaptive(
              value: widget.cardState,
              onChanged: (bool newValue) {
                setState(() {
                  widget.cardState = newValue;
                  print(
                      'new state of ${widget.cardText} is ${widget.cardState}');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
