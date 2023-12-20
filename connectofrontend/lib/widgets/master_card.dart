import 'package:flutter/material.dart';
import 'package:connectofrontend/widgets/custom_switch.dart';

class MasterCard extends StatefulWidget {
  final String cardText;
  bool cardState;

  MasterCard({super.key, required this.cardText, required this.cardState});

  @override
  State<MasterCard> createState() {
    return _MasterCardState();
  }
}

class _MasterCardState extends State<MasterCard> {
  void updateSwitch(bool status) {
    setState(() {
      widget.cardState = status;
    });
    print('printing card state for ${widget.cardText}: ${widget.cardState}');
  }

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
            CustomSwitch(
              value: widget.cardState,
              onChanged: updateSwitch,
            ),
          ],
        ),
      ),
    );
  }
}
