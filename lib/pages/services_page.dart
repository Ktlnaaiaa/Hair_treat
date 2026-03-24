import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBrown = Color(0xFF4A2A12);
    const softWhite = Color(0xFFEFE8E1);

    final categories = [
      const _CategoryItem(
        title: 'KERATIN',
        imagePath: 'assets/poho/1.png',
        page: CategoryDetailsPage(title: 'KERATIN'),
      ),
      const _CategoryItem(
        title: 'NAILS',
        imagePath: 'assets/poho/2.png',
        page: CategoryDetailsPage(title: 'NAILS'),
      ),
      const _CategoryItem(
        title: 'HEAD SPA',
        imagePath: 'assets/poho/3.png',
        page: CategoryDetailsPage(title: 'HEAD SPA'),
      ),
      const _CategoryItem(
        title: 'MASSAGE',
        imagePath: 'assets/poho/4.png',
        page: CategoryDetailsPage(title: 'MASSAGE'),
      ),
      const _CategoryItem(
        title: 'SAMPHON',
        imagePath: 'assets/poho/16.png',
        page: CategoryDetailsPage(title: 'SAMPHON'),
      ),
      const _CategoryItem(
        title: 'VOUCHER',
        imagePath: 'assets/poho/17.png',
        page: CategoryDetailsPage(title: 'VOUCHER'),
      ),
    ];

    final specialists = [
      const _SpecialistButtonData(title: 'KERATIN'),
      const _SpecialistButtonData(title: 'HEAD SPA'),
      const _SpecialistButtonData(title: 'NAILS'),
      const _SpecialistButtonData(title: 'MASSAGE'),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 570 / 800,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade800),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/poho/15.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.16),
                    ),
                  ),

                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            color: Color(0xFFD9CABB).withValues(alpha: 0.72),
                            padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: _VerticalSalonText(),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'HAIR_TREAT',
                                          style: TextStyle(
                                            fontFamily: 'Judson',
                                            fontSize: 34,
                                            fontWeight: FontWeight.w700,
                                            color: darkBrown,
                                            height: 1,
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
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 26),

                          const Text(
                            'CATEGORII',
                            style: TextStyle(
                              fontFamily: 'Judson',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: darkBrown,
                            ),
                          ),

                          const SizedBox(height: 18),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 34,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 0.95,
                                ),
                            itemBuilder: (context, index) {
                              final item = categories[index];
                              return _CategoryCard(item: item);
                            },
                          ),

                          const SizedBox(height: 34),

                          const Text(
                            'Specialiști',
                            style: TextStyle(
                              fontFamily: 'Judson',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: darkBrown,
                            ),
                          ),

                          const SizedBox(height: 28),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: specialists.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 24,
                                  crossAxisSpacing: 38,
                                  childAspectRatio: 3.2,
                                ),
                            itemBuilder: (context, index) {
                              final specialist = specialists[index];
                              return _SpecialistButton(data: specialist);
                            },
                          ),

                          const SizedBox(height: 54),

                          Container(
                            width: double.infinity,
                            color: Color(0xFFD8D8D8).withValues(alpha: 0.92),
                            padding: const EdgeInsets.fromLTRB(18, 18, 18, 26),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'hair_treatsalon@gmail.com',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: _FooterColumn(
                                        title: 'Despre noi',
                                        items: [
                                          'Politica de',
                                          'confidențialitate',
                                          'Cum comand',
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: _FooterColumn(
                                        title: 'Drochia',
                                        items: [
                                          '+37369141478',
                                          'Luni-vineri 09:00 | 17:00',
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.facebook,
                                      size: 12,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      size: 12,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.play_circle_outline,
                                      size: 12,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.circle_outlined,
                                      size: 12,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 8,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: softWhite,
                        size: 18,
                      ),
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

class _VerticalSalonText extends StatelessWidget {
  const _VerticalSalonText();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontFamily: 'Judson',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFF4A2A12),
      height: 1.35,
    );

    return const Column(
      children: [
        Text('S', style: style),
        Text('A', style: style),
        Text('L', style: style),
        Text('O', style: style),
        Text('N', style: style),
      ],
    );
  }
}

class _CategoryItem {
  final String title;
  final String imagePath;
  final Widget page;

  const _CategoryItem({
    required this.title,
    required this.imagePath,
    required this.page,
  });
}

class _CategoryCard extends StatelessWidget {
  final _CategoryItem item;

  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => item.page));
      },
      child: SizedBox(
        width: 104,
        child: Column(
          children: [
            Container(
              height: 82,
              width: 104,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item.imagePath,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  Container(color: Colors.white.withValues(alpha: 0.08)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Judson',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A2A12),
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
    );
  }
}

class _SpecialistButtonData {
  final String title;

  const _SpecialistButtonData({required this.title});
}

class _SpecialistButton extends StatelessWidget {
  final _SpecialistButtonData data;

  const _SpecialistButton({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SpecialistPage(title: data.title)),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFF1F1F1).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(1),
        ),
        child: Text(
          data.title,
          style: const TextStyle(
            fontFamily: 'Judson',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A2A12),
          ),
        ),
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 9, color: Colors.black87),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(e),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryDetailsPage extends StatelessWidget {
  final String title;

  const CategoryDetailsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final procedures = {
      'KERATIN': ['Keratină clasică', 'Botox capilar', 'Reconstrucție fir'],
      'NAILS': ['Manichiură clasică', 'Gel', 'Întreținere'],
      'HEAD SPA': ['Relax head spa', 'Tratament scalp', 'Pachet deluxe'],
      'MASSAGE': ['Masaj relaxare', 'Masaj spate', 'Masaj complet'],
      'SAMPHON': ['Șampon profesional', 'Îngrijire păr', 'Set cadou'],
      'VOUCHER': [
        'Voucher 500 MDL',
        'Voucher 1000 MDL',
        'Voucher personalizat',
      ],
    };

    final items = procedures[title] ?? ['Procedura 1', 'Procedura 2'];

    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2A12),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Judson',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Proceduri disponibile',
              style: const TextStyle(
                fontFamily: 'Judson',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A2A12),
              ),
            ),
            const SizedBox(height: 20),
            ...items.map(
              (item) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item,
                  style: const TextStyle(
                    fontFamily: 'Judson',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A2A12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialistPage extends StatelessWidget {
  final String title;

  const SpecialistPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2A12),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Judson',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Pagina specialistului $title',
          style: const TextStyle(
            fontFamily: 'Judson',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A2A12),
          ),
        ),
      ),
    );
  }
}
