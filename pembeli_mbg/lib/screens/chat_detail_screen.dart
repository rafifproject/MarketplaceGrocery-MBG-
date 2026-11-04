import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mbg_background.dart';

class ChatMessageModel {
  final String text;
  final String time;
  final bool isFromUser;

  ChatMessageModel({
    required this.text,
    required this.time,
    required this.isFromUser,
  });
}

/// Custom ShapeBorder untuk Speech Bubble Chat dengan Ekor Segitiga (Tail) & Drop Shadow Presisi Figma
class SpeechBubbleShape extends ShapeBorder {
  final bool isUser;
  final double radius;
  final double tailWidth;
  final double tailHeight;

  const SpeechBubbleShape({
    required this.isUser,
    this.radius = 12.0,
    this.tailWidth = 6.0,
    this.tailHeight = 7.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final r = radius;
    final tw = tailWidth;
    final th = tailHeight;

    if (!isUser) {
      // Bubble Toko (Kiri): Ekor di pojok kiri-bawah menunjuk ke bawah-kiri
      final bLeft = rect.left + tw;
      final bRight = rect.right;
      final bTop = rect.top;
      final bBottom = rect.bottom - th;

      path.moveTo(bLeft + r, bTop);
      path.lineTo(bRight - r, bTop);
      path.arcToPoint(Offset(bRight, bTop + r), radius: Radius.circular(r));
      path.lineTo(bRight, bBottom - r);
      path.arcToPoint(Offset(bRight - r, bBottom), radius: Radius.circular(r));
      path.lineTo(bLeft + 14, bBottom);
      // Ujung ekor menonjol ke kiri-bawah
      path.lineTo(rect.left, rect.bottom);
      path.lineTo(bLeft, bBottom - 6);
      path.lineTo(bLeft, bTop + r);
      path.arcToPoint(Offset(bLeft + r, bTop), radius: Radius.circular(r));
      path.close();
    } else {
      // Bubble User (Kanan): Ekor di pojok kanan-bawah menunjuk ke bawah-kanan
      final bLeft = rect.left;
      final bRight = rect.right - tw;
      final bTop = rect.top;
      final bBottom = rect.bottom - th;

      path.moveTo(bLeft + r, bTop);
      path.lineTo(bRight - r, bTop);
      path.arcToPoint(Offset(bRight, bTop + r), radius: Radius.circular(r));
      path.lineTo(bRight, bBottom - 6);
      // Ujung ekor menonjol ke kanan-bawah
      path.lineTo(rect.right, rect.bottom);
      path.lineTo(bRight - 14, bBottom);
      path.lineTo(bLeft + r, bBottom);
      path.arcToPoint(Offset(bLeft, bBottom - r), radius: Radius.circular(r));
      path.lineTo(bLeft, bTop + r);
      path.arcToPoint(Offset(bLeft + r, bTop), radius: Radius.circular(r));
      path.close();
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}

class ChatDetailScreen extends StatefulWidget {
  final String storeName;
  final String avatar;
  final bool isUnread;
  final VoidCallback? onChatRead;

  const ChatDetailScreen({
    super.key,
    required this.storeName,
    required this.avatar,
    this.isUnread = false,
    this.onChatRead,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _sizeAnimation;
  bool _showUnreadBadge = false;
  Timer? _unreadTimer;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessageModel> _messages;

  @override
  void initState() {
    super.initState();
    _showUnreadBadge = widget.isUnread;

    // Load initial messages according to store
    if (widget.storeName.toLowerCase().contains('putri')) {
      _messages = [
        ChatMessageModel(
          text: 'Halo kak! 👋 Terima kasih telah berbelanja di toko sayur kami!',
          time: '10.13',
          isFromUser: false,
        ),
      ];
    } else {
      _messages = [
        ChatMessageModel(
          text:
              'Halo kak! 👋 Stok daging segar hari ini ready : Iga Sapi Backribs, Fresh Beef Ribeye Steak, Daging Sapi Wagyu A5, Beef Sirloin Steak 1953, dan Daging Sapi Yoshinoya Beef Slice. Ada yang bisa Mas Rusdi bantu?',
          time: '11.13',
          isFromUser: false,
        ),
        ChatMessageModel(
          text: 'Mas, Iga Sapi Backribsnya bisa kirim ke daerah Reuleut?',
          time: '11.14',
          isFromUser: true,
        ),
        ChatMessageModel(
          text: 'Bisa banget kak! mau dipotong sekalian?',
          time: '11.15',
          isFromUser: false,
        ),
        ChatMessageModel(
          text: 'Boleh, Mas',
          time: '11.16',
          isFromUser: true,
        ),
      ];
    }

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOut,
      ),
    );

    _sizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeInOutCubic,
      ),
    );

    // Animasi: Ketika chat dibuka, tulisan "Belum dibaca" muncul sepersekian detik,
    // lalu menghilang otomatis dan pesan di bawahnya naik ke atas dengan animasi halus.
    if (_showUnreadBadge) {
      _unreadTimer = Timer(const Duration(milliseconds: 1200), () {
        if (mounted) {
          _animController.forward().then((_) {
            if (mounted) {
              setState(() {
                _showUnreadBadge = false;
              });
              widget.onChatRead?.call();
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _unreadTimer?.cancel();
    _animController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      _messages.add(
        ChatMessageModel(
          text: text,
          time: timeStr,
          isFromUser: true,
        ),
      );
    });

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MbgBackground(
        child: Column(
          children: [
            // Rektanggel Header Putih Presisi Figma (Membungkus Tombol Navigasi & Green Card Toko dengan Rounded Bottom 24 & Drop Shadow)
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.20),
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. Top Bar Navigasi (Back & Home)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tombol Back Melingkar / Icon Hijau Sesuai Figma
                          GestureDetector(
                            onTap: () {
                              if (widget.isUnread) {
                                widget.onChatRead?.call();
                              }
                              Navigator.pop(context);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Image.asset(
                              'assets/images/kategori_back_arrow.png',
                              width: 22,
                              height: 18,
                              fit: BoxFit.contain,
                              color: const Color(0xFF586A0E),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.undo_rounded,
                                color: Color(0xFF586A0E),
                                size: 22,
                              ),
                            ),
                          ),

                          // Tombol Home Asli Presisi Figma Asset
                          GestureDetector(
                            onTap: () {
                              if (widget.isUnread) {
                                widget.onChatRead?.call();
                              }
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Image.asset(
                              'assets/images/icon_chat_home.png',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  CustomPaint(
                                size: const Size(24, 24),
                                painter: const _ChatHomeIconPainter(
                                  color: Color(0xFF586A0E),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // 2. Header Card Hijau Toko (Avatar, Nama Toko, Online)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF86B386),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Avatar Lingkaran dengan border putih
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(widget.avatar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Nama Toko & Status Online
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.storeName,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Online',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w400,
                                    height: 1.15,
                                  ),
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
            ),

            const SizedBox(height: 12),

            // 3. Chip Tanggal "Hari ini" Sesuai Mockup Figma
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EDE8),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                      offset: Offset(0, 2),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Text(
                  'Hari ini',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF7E9789),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // 4. Badge "Belum dibaca" dengan animasi menghilang otomatis & pergerakan chat ke atas
            if (_showUnreadBadge)
              SizeTransition(
                sizeFactor: _sizeAnimation,
                axisAlignment: 0.0,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9ED8BF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Belum dibaca',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 8),

            // 5. Daftar Bubble Chat Ber-Ekor & Drop Shadow Presisi Figma (Ukuran Pas Sesuai Teks)
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildChatBubble(msg);
                },
              ),
            ),

            // 6. Bottom Input Box & Tombol Kirim Presisi Ukuran Figma
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 14.0),
                child: Row(
                  children: [
                    // Field Input "Ketik pesan"
                    Expanded(
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.14),
                              offset: Offset(0, 3),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: _messageController,
                          onSubmitted: (_) => _sendMessage(),
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            color: const Color(0xFF1E293B),
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'Ketik pesan',
                            hintStyle: GoogleFonts.inter(
                              color: const Color(0xFF9E9E9E),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Tombol Kirim Hijau
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: 46,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A852),
                          borderRadius: BorderRadius.circular(14.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.18),
                              offset: Offset(0, 3),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bubble Chat dengan Ekor Segitiga Asli, Drop Shadow Tegas, Font Inter Presisi Figma, dan Kolom Pas Sesuai Teks (Wrap Content)
  Widget _buildChatBubble(ChatMessageModel msg) {
    final isUser = msg.isFromUser;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: SpeechBubbleShape(isUser: isUser),
            shadows: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.18),
                offset: Offset(0, 3.5),
                blurRadius: 5.0,
              ),
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                offset: Offset(0, 1.5),
                blurRadius: 2.5,
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(
            isUser ? 12.0 : 18.0,
            9.0,
            isUser ? 18.0 : 12.0,
            9.0,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.67,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg.text,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                    height: 1.32,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  msg.time,
                  style: GoogleFonts.inter(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF94A3B8),
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// CustomPainter untuk Icon Home Berbentuk Rumah Melengkung dengan Pintu Busur (Arched Door) Sesuai Figma
class _ChatHomeIconPainter extends CustomPainter {
  final Color color;

  const _ChatHomeIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeW = size.width * 0.095;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Garis luar rumah: puncak segitiga melengkung, atap miring, dinding tegak, lantai bawah
    final housePath = Path();
    housePath.moveTo(w * 0.16, h * 0.86);
    housePath.lineTo(w * 0.16, h * 0.44);
    housePath.lineTo(w * 0.50, h * 0.15);
    housePath.lineTo(w * 0.84, h * 0.44);
    housePath.lineTo(w * 0.84, h * 0.86);
    housePath.close();

    canvas.drawPath(housePath, paint);

    // Pintu lengkung busur (arched doorway) di tengah bawah
    final doorPath = Path();
    doorPath.moveTo(w * 0.38, h * 0.86);
    doorPath.lineTo(w * 0.38, h * 0.58);
    doorPath.arcToPoint(
      Offset(w * 0.62, h * 0.58),
      radius: Radius.circular(w * 0.12),
    );
    doorPath.lineTo(w * 0.62, h * 0.86);

    canvas.drawPath(doorPath, paint);
  }

  @override
  bool shouldRepaint(covariant _ChatHomeIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

