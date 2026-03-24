import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1B12),
        title: const Text(
          'Programează-te',
          style: TextStyle(
            fontFamily: 'Judson',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          'Aici va fi pagina de programare',
          style: TextStyle(
            fontFamily: 'Judson',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D1B12),
          ),
        ),
      ),
    );
  }
}