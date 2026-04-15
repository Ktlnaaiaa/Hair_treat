import 'package:flutter/material.dart';
import 'home_page.dart';
import 'booking_page.dart';
import 'bottom_nav_bar.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
 State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String selectedService = 'Keratin';
  String? selectedSpecialist;

  final List<Map<String, dynamic>> services = [
    {
      'title': 'Keratin',
      'image': 'assets/photo/17.png',
      'description':
          'Tratamente pentru netezire, hidratare și regenerarea părului.',
      'specialists': [
        'Ana - Hair Stylist',
        'Maria - Hair Stylist',
      ],
    },
    {
      'title': 'Nails',
      'image': 'assets/photo/18.png',
      'description':
          'Manichiură elegantă, gel, întreținere și design modern.',
      'specialists': [
        'Elena - Nail Technician',
        'Diana - Nail Technician',
      ],
    },
    {
      'title': 'Head Spa',
      'image': 'assets/photo/20.png',
      'description':
          'Relaxare, curățare și îngrijire profundă pentru scalp și păr.',
      'specialists': [
        'Sofia - Head Spa Specialist',
      ],
    },
    {
      'title': 'Massage',
      'image': 'assets/photo/4.png',
      'description':
          'Masaj relaxant și terapeutic pentru stare de bine completă.',
      'specialists': [
        'Valeria - Massage Therapist',
      ],
    },
  ];

  Map<String, dynamic> get currentService {
    return services.firstWhere((service) => service['title'] == selectedService);
  }

  @override
  Widget build(BuildContext context) {
    final specialists = List<String>.from(currentService['specialists']);

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 14),
            Text(
              "Hair_TREAT",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
                fontFamily: 'Judson',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Serviciile noastre",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4E342E),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.92,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: services.map((service) {
                        final bool isSelected =
                            selectedService == service['title'];

                        return _serviceCard(
                          title: service['title'],
                          imagePath: service['image'],
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedService = service['title'];
                              selectedSpecialist = null;
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.72),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF8D6E63).withValues(alpha: 0.18),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentService['title'],
                            style: const TextStyle(
                              fontFamily: 'Judson',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D4037),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentService['description'],
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Color(0xFF5D4037),
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            'Specialiști',
                            style: TextStyle(
                              fontFamily: 'Judson',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D4037),
                            ),
                          ),
                          const SizedBox(height: 14),

                          ...specialists.map(
                            (specialist) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _specialistButton(
                                name: specialist,
                                isSelected: selectedSpecialist == specialist,
                                onTap: () {
                                  setState(() {
                                    selectedSpecialist = specialist;
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BookingPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF7B5A46).withValues(alpha: 0.95),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Text(
                                selectedSpecialist == null
                                    ? 'Programează-te'
                                    : 'Programează-te cu $selectedSpecialist',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HairTreatBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
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

  Widget _serviceCard({
    required String title,
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color:
                  isSelected ? const Color(0xFF8B5E3C) : Colors.transparent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isSelected ? 0.14 : 0.08),
                blurRadius: isSelected ? 12 : 7,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.28),
                  ),
                ),
                if (isSelected)
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xFF8B5E3C).withValues(alpha: 0.18),
                    ),
                  ),
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _specialistButton({
    required String name,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF8B5E3C)
                : const Color(0xFFB08968).withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white.withValues(alpha: 0.88),
                child: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF5D4037),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle : Icons.arrow_forward_ios,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}