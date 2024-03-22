import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final void Function()? onPressed;

  const CustomErrorWidget(
      {super.key, required this.errorMessage, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Error occurred:'),
          const SizedBox(height: 5),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
