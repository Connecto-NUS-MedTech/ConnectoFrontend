import 'package:flutter/material.dart';

class HomeSystemHeaderRow extends StatefulWidget {
  const HomeSystemHeaderRow({
    super.key,
  });

  @override
  State<HomeSystemHeaderRow> createState() => _HomeSystemHeaderRowState();
}

class _HomeSystemHeaderRowState extends State<HomeSystemHeaderRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            iconSize: 40,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            iconSize: 40,
            onPressed: () {},
          ),
          GestureDetector(
            // TODO: Show dropdown? Of all the existing rooms
            onTap: () => {},
            child: const Row(
              children: [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 8),
                Text(
                  'Bookmark Room',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
