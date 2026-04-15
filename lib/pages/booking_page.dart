import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bottom_nav_bar.dart';
import 'home_page.dart';
import 'services_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String? selectedCategory;
  String? selectedService;
  String? selectedSpecialist;
  String? selectedTime;
  DateTime? selectedDate;

  final Map<String, List<ServiceOption>> serviceCategories = {
    'Keratin': [
      ServiceOption(name: 'Keratin clasic', price: 1200),
      ServiceOption(name: 'Botox capilar', price: 1000),
      ServiceOption(name: 'Reconstrucție păr', price: 900),
    ],
    'Nails': [
      ServiceOption(name: 'Manichiură clasică', price: 300),
      ServiceOption(name: 'Gel pe unghii', price: 450),
      ServiceOption(name: 'Întreținere gel', price: 350),
    ],
    'Head Spa': [
      ServiceOption(name: 'Head Spa Basic', price: 700),
      ServiceOption(name: 'Head Spa Relax', price: 850),
      ServiceOption(name: 'Head Spa Deluxe', price: 1000),
    ],
    'Massage': [
      ServiceOption(name: 'Masaj relaxare', price: 500),
      ServiceOption(name: 'Masaj spate', price: 350),
      ServiceOption(name: 'Masaj complet', price: 800),
    ],
  };

  final Map<String, List<String>> specialistsByCategory = {
    'Keratin': ['Ana - Hair Stylist', 'Maria - Hair Stylist'],
    'Nails': ['Elena - Nail Technician', 'Diana - Nail Technician'],
    'Head Spa': ['Sofia - Head Spa Specialist'],
    'Massage': ['Valeria - Massage Therapist'],
  };

  final List<String> allTimes = const [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ];

  final Map<String, List<String>> bookedTimesByDate = {
    '2026-3-28': ['09:00', '12:00', '15:00'],
    '2026-3-29': ['10:00', '11:00', '16:00'],
    '2026-3-30': ['09:00', '10:00', '13:00', '14:00'],
  };

  final List<String> fullyBlockedDates = [
    '2026-3-31',
  ];

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  List<ServiceOption> get availableServices {
    if (selectedCategory == null) return [];
    return serviceCategories[selectedCategory] ?? [];
  }

  List<String> get availableSpecialists {
    if (selectedCategory == null) return [];
    return specialistsByCategory[selectedCategory] ?? [];
  }

  ServiceOption? get selectedServiceObject {
    if (selectedCategory == null || selectedService == null) return null;
    final services = serviceCategories[selectedCategory] ?? [];
    for (final service in services) {
      if (service.name == selectedService) return service;
    }
    return null;
  }

  List<String> get availableTimes {
    if (selectedDate == null) return allTimes;

    final key =
        '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';
    final booked = bookedTimesByDate[key] ?? [];

    return allTimes.where((time) => !booked.contains(time)).toList();
  }

  bool _isDateSelectable(DateTime day) {
    final now = DateTime.now();
    final pureNow = DateTime(now.year, now.month, now.day);
    final pureDay = DateTime(day.year, day.month, day.day);

    if (pureDay.isBefore(pureNow)) return false;
    if (day.weekday == DateTime.sunday) return false;

    final key = '${day.year}-${day.month}-${day.day}';
    if (fullyBlockedDates.contains(key)) return false;

    return true;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
      selectableDayPredicate: _isDateSelectable,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4A2A12),
              onPrimary: Colors.white,
              onSurface: Color(0xFF4A2A12),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedTime = null;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Alege data';
    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  Future<void> _submitBooking() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;

    if (selectedCategory == null ||
        selectedService == null ||
        selectedSpecialist == null ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completează toate câmpurile programării.'),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'notes': _notesController.text.trim(),
        'category': selectedCategory,
        'service': selectedService,
        'specialist': selectedSpecialist,
        'date': selectedDate!.toIso8601String(),
        'time': selectedTime,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Programarea a fost salvată cu succes.'),
        ),
      );

      setState(() {
        selectedCategory = null;
        selectedService = null;
        selectedSpecialist = null;
        selectedDate = null;
        selectedTime = null;
      });

      _nameController.clear();
      _phoneController.clear();
      _notesController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Eroare la salvare: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF4A2A12);
    const beigePanel = Color(0xFFD8CABE);
    const fieldColor = Color(0xFFF8F2EC);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          return Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Image.asset(
                    'assets/photo/15.png',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.white.withValues(alpha: 0.10),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 32,
                    vertical: isMobile ? 12 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: const Color(0xFFEFE8E1),
                          size: isMobile ? 18 : 24,
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 14),
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 700),
                        padding: EdgeInsets.all(isMobile ? 16 : 24),
                        decoration: BoxDecoration(
                          color: beigePanel.withValues(alpha: 0.90),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Programare',
                                style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontSize: isMobile ? 28 : 40,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: darkBrown,
                                ),
                              ),
                              SizedBox(height: isMobile ? 8 : 12),
                              Text(
                                'Alege serviciul, specialistul, data și ora disponibilă',
                                style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontSize: isMobile ? 14 : 18,
                                  color: darkBrown,
                                ),
                              ),
                              SizedBox(height: isMobile ? 20 : 28),

                              _SectionTitle(title: 'Nume'),
                              _CustomTextField(
                                controller: _nameController,
                                hintText: 'Introdu numele tău',
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Introdu numele';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: isMobile ? 14 : 18),

                              _SectionTitle(title: 'Telefon'),
                              _CustomTextField(
                                controller: _phoneController,
                                hintText: 'Introdu numărul de telefon',
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Introdu telefonul';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: isMobile ? 14 : 18),

                              _SectionTitle(title: 'Categorie serviciu'),
                              _CustomDropdown<String>(
                                value: selectedCategory,
                                hint: 'Alege categoria',
                                items: serviceCategories.keys.toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                    selectedService = null;
                                    selectedSpecialist = null;
                                  });
                                },
                              ),

                              SizedBox(height: isMobile ? 14 : 18),

                              _SectionTitle(title: 'Tip serviciu'),
                              _CustomDropdown<String>(
                                value: selectedService,
                                hint: selectedCategory == null
                                    ? 'Mai întâi alege categoria'
                                    : 'Alege tipul de serviciu',
                                items: availableServices
                                    .map((service) => service.name)
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedService = value;
                                  });
                                },
                              ),

                              SizedBox(height: isMobile ? 14 : 18),

                              if (selectedServiceObject != null)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: fieldColor,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: darkBrown.withValues(alpha: 0.25),
                                    ),
                                  ),
                                  child: Text(
                                    'Preț: ${selectedServiceObject!.price} MDL',
                                    style: const TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: darkBrown,
                                    ),
                                  ),
                                ),

                              SizedBox(height: isMobile ? 14 : 18),

                              _SectionTitle(title: 'Specialist'),
                              _CustomDropdown<String>(
                                value: selectedSpecialist,
                                hint: selectedCategory == null
                                    ? 'Mai întâi alege categoria'
                                    : 'Alege specialistul',
                                items: availableSpecialists,
                                onChanged: (value) {
                                  setState(() {
                                    selectedSpecialist = value;
                                  });
                                },
                              ),

                              SizedBox(height: isMobile ? 14 : 18),

                              _SectionTitle(title: 'Data'),
                              InkWell(
                                onTap: _pickDate,
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 14 : 18,
                                    vertical: isMobile ? 14 : 18,
                                  ),
                                  decoration: BoxDecoration(
                                    color: fieldColor,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: darkBrown.withValues(alpha: 0.25),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDate(selectedDate),
                                        style: TextStyle(
                                          fontFamily: 'Times New Roman',
                                          fontSize: isMobile ? 15 : 18,
                                          color: darkBrown,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: darkBrown,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: isMobile ? 10 : 14),

                              Text(
                                'Duminica și zilele blocate nu pot fi selectate.',
                                style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontSize: isMobile ? 12 : 14,
                                  color: darkBrown.withValues(alpha: 0.75),
                                ),
                              ),

                              SizedBox(height: isMobile ? 14 : 18),

                              _SectionTitle(title: 'Ore libere'),
                              _CustomDropdown<String>(
                                value: selectedTime,
                                hint: selectedDate == null
                                    ? 'Mai întâi alege data'
                                    : (availableTimes.isEmpty
                                          ? 'Nu sunt ore libere'
                                          : 'Alege ora'),
                                items: availableTimes,
                                onChanged: (value) {
                                  setState(() {
                                    selectedTime = value;
                                  });
                                },
                              ),

                              SizedBox(height: isMobile ? 10 : 14),

                              if (selectedDate != null)
                                Text(
                                  availableTimes.isEmpty
                                      ? 'În această zi nu mai sunt ore disponibile.'
                                      : 'Orele afișate sunt doar cele libere.',
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: isMobile ? 12 : 14,
                                    color: darkBrown.withValues(alpha: 0.75),
                                  ),
                                ),

                              SizedBox(height: isMobile ? 14 : 18),

                              _SectionTitle(title: 'Mesaj suplimentar'),
                              _CustomTextField(
                                controller: _notesController,
                                hintText: 'Scrie dacă ai dorințe speciale',
                                maxLines: 4,
                              ),

                              SizedBox(height: isMobile ? 22 : 30),

                              Center(
                                child: _SubmitButton(
                                  text: _isSubmitting
                                      ? 'Se salvează...'
                                      : 'Trimite programarea',
                                  onTap: _isSubmitting ? null : _submitBooking,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 100 : 110),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: HairTreatBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ServicesPage()),
            );
          }
        },
      ),
    );
  }
}

class ServiceOption {
  final String name;
  final int price;

  const ServiceOption({
    required this.name,
    required this.price,
  });
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4A2A12),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const _CustomTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF4A2A12);
    const fieldColor = Color(0xFFF8F2EC);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Times New Roman',
        fontSize: 16,
        color: darkBrown,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Times New Roman',
          color: darkBrown.withValues(alpha: 0.55),
        ),
        filled: true,
        fillColor: fieldColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: darkBrown.withValues(alpha: 0.25),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: darkBrown,
            width: 1.4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const _CustomDropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF4A2A12);
    const fieldColor = Color(0xFFF8F2EC);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: darkBrown.withValues(alpha: 0.25),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: items.contains(value) ? value : null,
          hint: Text(
            hint,
            style: TextStyle(
              fontFamily: 'Times New Roman',
              color: darkBrown.withValues(alpha: 0.55),
            ),
          ),
          isExpanded: true,
          dropdownColor: fieldColor,
          iconEnabledColor: darkBrown,
          style: const TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 16,
            color: darkBrown,
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: items.isEmpty ? null : onChanged,
        ),
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const _SubmitButton({
    required this.text,
    required this.onTap,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFFF7F3EE);
    const hoverColor = Color(0xFFE8D7C6);
    const pressedColor = Color(0xFFD7BFA8);
    const disabledColor = Color(0xFFE6DED7);
    const borderColor = Color(0xFF8A5A3B);
    const textColor = Color(0xFF4A2A12);

    final isDisabled = widget.onTap == null;

    final currentColor = isDisabled
        ? disabledColor
        : _isPressed
            ? pressedColor
            : (_isHovered ? hoverColor : baseColor);

    final scale = isDisabled ? 1.0 : (_isPressed ? 0.97 : (_isHovered ? 1.02 : 1.0));

    return MouseRegion(
      onEnter: (_) {
        if (!isDisabled) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
        onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
        onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 140),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: borderColor,
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: _isHovered ? 0.18 : 0.08),
                  blurRadius: _isHovered ? 10 : 5,
                  offset: Offset(0, _isHovered ? 4 : 2),
                ),
              ],
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}