import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    Key? key,
    this.disabled = false,
    required this.onTap,
  }) : super(key: key);

  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: disabled ? Colors.blueGrey.withOpacity(0.2) : Colors.blueGrey,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '投稿',
            style: TextStyle(
                color: disabled ? Colors.white.withOpacity(0.2) : Colors.white),
          ),
        ),
      ),
    );
  }
}
