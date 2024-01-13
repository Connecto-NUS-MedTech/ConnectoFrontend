import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  // If more field-value pairs are needed, use an Array instead
  final String field;
  final String? value;
  final Widget child;

  // Callback function to save the new value(s)
  final Function(String) onEditSaved;

  const EditDialog({
    super.key,
    required this.field,
    required this.value,
    required this.child,
    required this.onEditSaved,
  });

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController textValueController;

  @override
  void initState() {
    super.initState();
    textValueController =
        TextEditingController(text: widget.value ?? widget.field);
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.field),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: textValueController,
                  decoration: InputDecoration(labelText: widget.field),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                textValueController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.onEditSaved(textValueController.text);
                textValueController.clear();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((_) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(context),
      child: widget.child,
    );
  }
}
