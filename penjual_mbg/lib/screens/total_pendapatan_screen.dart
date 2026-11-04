import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';
import '../widgets/penjual_capsule_header.dart';
import 'dompet_seller_screen.dart';

class TotalPendapatanScreen extends StatefulWidget {
  const TotalPendapatanScreen({super.key});

  @override
  State<TotalPendapatanScreen> createState() => _TotalPendapatanScreenState();
}

class _TotalPendapatanScreenState extends State<TotalPendapatanScreen> {
  // Exact colors from Total Pendapatan card in penjual_home_screen.dart
  static const Color textBrown = Color(0xFF3E270A);

  static const Color greenFilter = Color(0xFF94D2A3);
  static const Color greenText = Color(0xFF285912);
  static const Color greenBadge = Color(0xFF61CB63);

  static const Color blueText = Color(0xFF122858);
  static const Color blueBadge = Color(0xFF61A6CB);
  static const List<Color> blueLinearProdukTerlaris = [
    Color(0xFFB7E3F1),
    Color(0xFF8EBAD5),
  ];

  static const Color goldBadge = Color(0xFFBE9C5F);

  // Exact Linear gold gradient from Total Pendapatan card in penjual_home_screen.dart
  static const List<Color> goldLinearTotalPendapatan = [
    Color(0xFFE8C27E),
    Color(0xFFD6AE68),
  ];

  static const List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const List<int> _years = [
    2022,
    2023,
    2024,
    2025,
    2026,
    2027,
    2028,
  ];

  DateTime _selectedDate = DateTime(2026, 10, 1);
  int _selectedMonthIndex = 9; // 0-indexed (9 = Oktober)
  int _selectedYear = 2026;

  // Dynamic revenue generator based on selected date/month/year matching Figma values
  String get _harianAmount {
    if (_selectedDate.year == 2026 && _selectedDate.month == 10) {
      if (_selectedDate.day == 1) return 'Rp740.000';
      if (_selectedDate.day == 2) return 'Rp670.000';
      if (_selectedDate.day == 9) return 'Rp820.000';
    }
    final base = 740000 + ((_selectedDate.day * 13500) % 250000);
    return _formatCurrency(base);
  }

  String get _bulananAmount {
    if (_selectedMonthIndex == 9) {
      // Oktober
      return 'Rp7.706.000';
    }
    final base = 7706000 + ((_selectedMonthIndex * 215000) % 850000);
    return _formatCurrency(base);
  }

  String get _tahunanAmount {
    if (_selectedYear == 2024) {
      return 'Rp12.000.000';
    }
    if (_selectedYear == 2026) {
      return 'Rp15.000.000';
    }
    final base = 12000000 + (((_selectedYear - 2022) * 1500000) % 6000000);
    return _formatCurrency(base);
  }

  String _formatCurrency(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i > 0) {
        buffer.write('.');
      }
    }
    return 'Rp${buffer.toString().split('').reversed.join('')}';
  }

  // --- PICKER 1: CUSTOM FIGMA CALENDAR DIALOG (HARIAN) ---
  Future<void> _pickDate() async {
    DateTime tempDate = _selectedDate;

    final picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final daysInMonth =
                DateUtils.getDaysInMonth(tempDate.year, tempDate.month);
            // 1st of month: 1=Mon, ..., 7=Sun. In Indonesia 'Sen' is Monday, 'Min' is Sunday.
            final firstWeekday =
                DateTime(tempDate.year, tempDate.month, 1).weekday; // 1..7
            final offset = firstWeekday - 1; // 0..6 (0=Sen, 6=Min)

            const weekDays = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- HEADER BANNER MATCHING FIGMA IMAGE 1 ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: goldLinearTotalPendapatan,
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left: Selected date (e.g. "9 Oktober 2026")
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${tempDate.day} ${_monthNames[tempDate.month - 1]} ${tempDate.year}',
                                style: GoogleFonts.plusJakartaSans(
                                  color: textBrown,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Right: Month and Year (e.g. "Oktober 2026")
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${_monthNames[tempDate.month - 1]} ${tempDate.year}',
                                style: GoogleFonts.plusJakartaSans(
                                  color: textBrown,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // --- BODY: WEEKDAYS & DAYS GRID ---
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Weekday headers
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: weekDays.map((d) {
                              return SizedBox(
                                width: 38,
                                child: Text(
                                  d,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 12),

                          // Days Grid
                          ...List.generate(
                              ((daysInMonth + offset) / 7).ceil(), (rowIndex) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(7, (colIndex) {
                                  final dayNumber =
                                      rowIndex * 7 + colIndex - offset + 1;
                                  if (dayNumber < 1 ||
                                      dayNumber > daysInMonth) {
                                    return const SizedBox(
                                        width: 38, height: 38);
                                  }

                                  final isSelected =
                                      dayNumber == tempDate.day;

                                  return InkWell(
                                    onTap: () {
                                      setDialogState(() {
                                        tempDate = DateTime(tempDate.year,
                                            tempDate.month, dayNumber);
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(19),
                                    child: Container(
                                      width: 38,
                                      height: 38,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? goldBadge
                                            : Colors.transparent,
                                      ),
                                      child: Text(
                                        '$dayNumber',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15,
                                          fontWeight: isSelected
                                              ? FontWeight.w800
                                              : FontWeight.w600,
                                          color: const Color(0xFF1A1A1A),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }),

                          const SizedBox(height: 16),

                          // Bottom right "Lihat" button matching Figma Image 1
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(dialogContext, tempDate);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: goldBadge,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Lihat',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: textBrown,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
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
          },
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // --- PICKER 2: 12 MONTHS BOTTOM SHEET PICKER (BULANAN) ---
  void _pickMonth() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top drag handle bar
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Text(
                  'Pilih Bulan',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: greenText,
                  ),
                ),
                const SizedBox(height: 12),
                // Scrollable list of 12 months
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 340),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _monthNames.length,
                    itemBuilder: (context, index) {
                      final month = _monthNames[index];
                      final isSelected = index == _selectedMonthIndex;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedMonthIndex = index;
                          });
                          Navigator.pop(ctx);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? greenBadge
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            month,
                            style: GoogleFonts.plusJakartaSans(
                              color: isSelected ? Colors.white : greenText,
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- PICKER 3: YEARS BOTTOM SHEET PICKER (TAHUNAN) ---
  void _pickYear() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top drag handle bar
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Text(
                  'Pilih Tahun',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: blueText,
                  ),
                ),
                const SizedBox(height: 12),
                // Scrollable list of years
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 280),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _years.length,
                    itemBuilder: (context, index) {
                      final year = _years[index];
                      final isSelected = year == _selectedYear;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedYear = year;
                          });
                          Navigator.pop(ctx);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? blueBadge : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '$year',
                            style: GoogleFonts.plusJakartaSans(
                              color: isSelected ? Colors.white : blueText,
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final harianBadgeText =
        '${_selectedDate.day} ${_monthNames[_selectedDate.month - 1]} ${_selectedDate.year}';
    final bulananBadgeText = _monthNames[_selectedMonthIndex];
    final tahunanBadgeText = '$_selectedYear';

    return Scaffold(
      body: MbgBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 1. Header Capsule matching Total Pendapatan gold gradient
              PenjualCapsuleHeader(
                title: 'Total Pendapatan',
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: goldLinearTotalPendapatan,
                ),
                textColor: textBrown,
                arrowColor: textBrown,
                height: 45,
                fontSize: 18,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                onBack: () => Navigator.pop(context),
              ),

              // 2. Scrollable Body
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(22, 6, 22, 24),
                  children: [
                    // --- SECTION 1: HARIAN ---
                    _buildFilterButton(
                      label: 'Harian',
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: goldLinearTotalPendapatan,
                      ),
                      textColor: textBrown,
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: 10),
                    _buildRevenueCard(
                      badgeText: harianBadgeText,
                      badgeBgColor: goldBadge,
                      badgeTextColor: textBrown,
                      gradientBegin: Alignment.topLeft,
                      gradientEnd: Alignment.bottomRight,
                      cardGradient: goldLinearTotalPendapatan,
                      amountText: _harianAmount,
                      textColor: textBrown,
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: 22),

                    // --- SECTION 2: BULANAN ---
                    _buildFilterButton(
                      label: 'Bulanan',
                      bgColor: greenFilter,
                      textColor: greenText,
                      onTap: _pickMonth,
                    ),
                    const SizedBox(height: 10),
                    _buildRevenueCard(
                      badgeText: bulananBadgeText,
                      badgeBgColor: greenBadge,
                      badgeTextColor: greenText,
                      gradientBegin: Alignment.topCenter,
                      gradientEnd: Alignment.bottomCenter,
                      gradientStops: const [0.0, 1.0],
                      cardGradient: const [
                        Color(0xFF9FC89F), // Atas 0%
                        Color(0xFF75B175), // Bawah 100%
                      ],
                      amountText: _bulananAmount,
                      textColor: greenText,
                      onTap: _pickMonth,
                    ),
                    const SizedBox(height: 22),

                    // --- SECTION 3: TAHUNAN ---
                    _buildFilterButton(
                      label: 'Tahunan',
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: blueLinearProdukTerlaris,
                      ),
                      textColor: blueText,
                      onTap: _pickYear,
                    ),
                    const SizedBox(height: 10),
                    _buildRevenueCard(
                      badgeText: tahunanBadgeText,
                      badgeBgColor: blueBadge,
                      badgeTextColor: blueText,
                      gradientBegin: Alignment.topLeft,
                      gradientEnd: Alignment.bottomRight,
                      cardGradient: blueLinearProdukTerlaris,
                      amountText: _tahunanAmount,
                      textColor: blueText,
                      onTap: _pickYear,
                    ),
                    const SizedBox(height: 32),

                    // --- SECTION 4: DOMPET SELLER ---
                    _buildDompetSellerCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dropdown Filter Button Pill (e.g. "Harian v", "Bulanan v", "Tahunan v")
  /// Fits content tightly (hug content) and stays pinned to the left edge
  Widget _buildFilterButton({
    required String label,
    Color? bgColor,
    Gradient? gradient,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 4, 8, 4),
            decoration: BoxDecoration(
              color: gradient == null ? bgColor : null,
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  blurRadius: 3,
                  offset: Offset(0, 1.5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 3),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Revenue Card (Harian / Bulanan / Tahunan) with exact Figma height of 98px
  /// Amount spans from edge-to-edge with 4-6px balanced space on left and right
  Widget _buildRevenueCard({
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeTextColor,
    List<Color>? cardGradient,
    Color? cardColor,
    required String amountText,
    required Color textColor,
    required VoidCallback onTap,
    Alignment gradientBegin = Alignment.topLeft,
    Alignment gradientEnd = Alignment.bottomRight,
    List<double>? gradientStops,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 98,
          padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            gradient: cardColor == null && cardGradient != null
                ? LinearGradient(
                    begin: gradientBegin,
                    end: gradientEnd,
                    stops: gradientStops,
                    colors: cardGradient,
                  )
                : null,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.14),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge Pill fits text width tightly at top-left with slight offset
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 2),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    badgeText,
                    style: GoogleFonts.plusJakartaSans(
                      color: badgeTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ),

              // Currency Amount spanning edge-to-edge, perfectly balanced with 4-6px margins
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: amountText,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                              letterSpacing: -1.0,
                              height: 1.0,
                            ),
                          ),
                          TextSpan(
                            text: ',00',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                              letterSpacing: -0.5,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dompet Seller Card with "Tarik Dana" Button - Exact Figma Height 98px
  /// Title spans edge-to-edge, perfectly balanced with 4-6px side margins
  Widget _buildDompetSellerCard() {
    return Container(
      width: double.infinity,
      height: 98,
      padding: const EdgeInsets.fromLTRB(6, 12, 6, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: goldLinearTotalPendapatan,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.14),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bold Title spanning edge-to-edge, perfectly balanced with 4-6px margins
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  'Dompet Seller',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: textBrown,
                    letterSpacing: -1.0,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ),

          // "Tarik Dana" Pill Button fits content tightly at bottom-right edge
          Align(
            alignment: Alignment.bottomRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DompetSellerScreen(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: goldBadge,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        blurRadius: 3,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: Text(
                    'Tarik Dana',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: textBrown,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
