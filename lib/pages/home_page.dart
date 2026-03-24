import 'package:flutter/material.dart';
import 'booking_page.dart';
import 'services_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF2D1B12);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 570 / 692,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.grey.shade800, width: 1),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/photo/10.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 145,
                    child: Container(
                      height: 155,
                      color: Color(0xFFCFC6B5).withValues(alpha: 0.70),
                    ),
                  ),

                  Positioned(
                    left: 46,
                    bottom: 168,
                    child: SizedBox(
                      height: 118,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _VerticalLetter('S'),
                          _VerticalLetter('A'),
                          _VerticalLetter('L'),
                          _VerticalLetter('O'),
                          _VerticalLetter('N'),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 85,
                    bottom: 205,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'HAIR_TREAT',
                          style: TextStyle(
                            fontFamily: 'Judson',
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: darkBrown,
                            height: 1,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'KERATIN. NAILS. HEAD SPA. MASSAGE',
                          style: TextStyle(
                            fontFamily: 'Judson',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: darkBrown,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 28,
                    right: 28,
                    bottom: 42,
                    child: Row(
                      children: [
                        Expanded(
                          child: _SalonButton(
                            text: 'PROGRAMEAZĂ-TE',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BookingPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _SalonButton(
                            text: 'SERVICII',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ServicesPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VerticalLetter extends StatelessWidget {
  final String letter;

  const _VerticalLetter(this.letter);

  @override
  Widget build(BuildContext context) {
    return Text(
      letter,
      style: const TextStyle(
        fontFamily: 'Judson',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2D1B12),
        height: 1,
      ),
    );
  }
}

class _SalonButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SalonButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2D1B12).withValues(alpha: 0.92),
          foregroundColor: const Color(0xFFF3E7D7),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        onPressed: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Judson',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
