import 'package:flutter/material.dart';
import 'package:timker/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.yellow),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Timer Name',
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          //TODO: Add time in hours minutes and seconds to the timer card (probably change int to time variable like the clock widget video)

          //save and cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                text: 'Save',
                onPressed: onSave,
              ),
              const SizedBox(
                width: 10,
              ),
              MyButton(
                text: 'Cancel',
                onPressed: onCancel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
