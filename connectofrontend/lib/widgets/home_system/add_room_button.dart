import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomButton extends StatefulWidget {
  final Widget child;
  const AddRoomButton({super.key, required this.child});

  @override
  State<AddRoomButton> createState() => _AddRoomButtonState();
}

class _AddRoomButtonState extends State<AddRoomButton> {
  TextEditingController roomNameController = TextEditingController();

  @override
  void dispose() {
    roomNameController.dispose();
    super.dispose();
  }

  Future<void> _showAddRoomDialog(BuildContext context) async {
    var homeSystemState = Provider.of<HomeSystemState>(context, listen: false);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Room'),
          content: Column(
            children: [
              TextField(
                controller: roomNameController,
                decoration: const InputDecoration(labelText: 'Room Name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                roomNameController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Handle create new id logic somewhere
                Room newRoom = Room(id: -1, name: roomNameController.text);
                try {
                  homeSystemState.createRoom(newRoom);
                } catch (e) {
                  // TODO: Create custom exception?
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                roomNameController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddRoomDialog(context),
      child: widget.child,
    );
  }
}
