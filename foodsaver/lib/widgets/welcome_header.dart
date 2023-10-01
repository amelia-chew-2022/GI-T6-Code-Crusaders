import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final String email;
  final VoidCallback onLogout;

  WelcomeHeader({
    required this.email,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Welcome \n" + email,
              style: const TextStyle(
                color: Color(0xFF003B2B),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}
