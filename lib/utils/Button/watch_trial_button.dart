import 'package:flutter/material.dart';

class WatchTrialButton extends StatelessWidget {
  const WatchTrialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15.0),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () {},
      child: const Text(
        'Watch Trial',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
