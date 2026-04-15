import 'package:flutter/material.dart';
import 'services_page.dart';
import 'booking_page.dart';
import 'bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF2D1B12);
    const softBeige = Color(0xFFCFC6B5);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 700;

          final horizontalPadding = isMobile ? 16.0 : 28.0;
          final titleFontSize = isMobile ? 28.0 : 62.0;
          final subtitleFontSize = isMobile ? 11.5 : 24.0;
          final verticalTextSize = isMobile ? 15.0 : 28.0;

          final overlayHeight = isMobile ? 145.0 : 210.0;
          final overlayBottom = isMobile ? 150.0 : 205.0;

          final buttonsBottom = isMobile ? 82.0 : 95.0;
          final buttonsHeight = isMobile ? 52.0 : 70.0;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/photo/10.png',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.05),
                ),
              ),
              Positioned(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: overlayBottom,
                child: Container(
                  height: overlayHeight,
                  decoration: BoxDecoration(
                    color: softBeige.withValues(alpha: 0.50),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.18),
                      width: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: isMobile ? 28 : 52,
                bottom: overlayBottom + (isMobile ? 12 : 24),
                child: SizedBox(
                  height: isMobile ? 96 : 165,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _VerticalLetter('S', fontSize: verticalTextSize),
                      _VerticalLetter('A', fontSize: verticalTextSize),
                      _VerticalLetter('L', fontSize: verticalTextSize),
                      _VerticalLetter('O', fontSize: verticalTextSize),
                      _VerticalLetter('N', fontSize: verticalTextSize),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: isMobile ? 68 : 120,
                right: horizontalPadding + 8,
                bottom: overlayBottom + (isMobile ? 52 : 58),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HAIR_TREAT',
                      style: TextStyle(
                        fontFamily: 'Judson',
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700,
                        color: darkBrown,
                        height: 1,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 14),
                    Text(
                      'KERATIN. NAILS. HEAD SPA. MASSAGE',
                      style: TextStyle(
                        fontFamily: 'Judson',
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.w700,
                        color: darkBrown,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: buttonsBottom,
                child: Column(
                  children: [
                    SizedBox(
                      height: buttonsHeight,
                      width: double.infinity,
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
                    const SizedBox(height: 12),
                    SizedBox(
                      height: buttonsHeight,
                      width: double.infinity,
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
          );
        },
      ),
      bottomNavigationBar: HairTreatBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ServicesPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BookingPage()),
            );
          }
        },
      ),
    );
  }
}

class _VerticalLetter extends StatelessWidget {
  final String letter;
  final double fontSize;

  const _VerticalLetter(this.letter, {required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      letter,
      style: TextStyle(
        fontFamily: 'Judson',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF2D1B12),
        height: 1,
      ),
    );
  }
}

class _SalonButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _SalonButton({
    required this.text,
    required this.onTap,
  });

  @override
  State<_SalonButton> createState() => _SalonButtonState();
}

class _SalonButtonState extends State<_SalonButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovered || _isPressed;
    final scale = _isPressed ? 0.97 : (_isHovered ? 1.02 : 1.0);

    final backgroundColor = _isPressed
        ? const Color(0xFF5A3421).withValues(alpha: 0.84)
        : _isHovered
            ? const Color(0xFF6B3E28).withValues(alpha: 0.75)
            : const Color(0xFF5E3D2A).withValues(alpha: 0.72);

    final borderColor = _isHovered
        ? Colors.white.withValues(alpha: 0.32)
        : Colors.white.withValues(alpha: 0.14);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _isPressed = false;
        });
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 140),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: borderColor,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isActive ? 0.22 : 0.12),
                  blurRadius: isActive ? 14 : 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: widget.onTap,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Judson',
                        fontSize:
                            MediaQuery.of(context).size.width < 700 ? 16 : 23,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: const Color(0xFFF7EDE1),
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}