import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Fetch another image',
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: isLoading ? null : onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 50,
            decoration: BoxDecoration(
              gradient: isLoading
                  ? LinearGradient(
                colors: [
                  Colors.grey.shade400,
                  Colors.grey.shade500,
                ],
              )
                  : const LinearGradient(
                colors: [
                  Color(0xFFFB8C00),
                  Color(0xFFF4511E),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                if (!isLoading)
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                  ),
              ],
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text(
                'Another',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}