import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/mbg_background.dart';

/// Model Pesan Chat
class ChatMessageModel {
  final String text;
  final String time;
  final bool isFromSeller; // true = Penjual (kanan), false = Pembeli/Amba (kiri)

  ChatMessageModel({
    required this.text,
    required this.time,
    required this.isFromSeller,
  });
}

/// Model Item Chat untuk Daftar Percakapan
class ChatItemData {
  final String name;
  final String username;
  String lastMessage;
  String time;
  final String avatar;
  final bool isOnline;
  bool isUnread;
  final List<ChatMessageModel> messages;

  ChatItemData({
    required this.name,
    required this.username,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    required this.isOnline,
    required this.isUnread,
    required this.messages,
  });
}

/// Custom ShapeBorder untuk Speech Bubble Chat dengan Ekor Segitiga Asli & Drop Shadow Presisi Figma (Persis Pembeli)
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
      // Bubble Pembeli (Kiri): Ekor di pojok kiri-bawah menunjuk ke bawah-kiri
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
      path.lineTo(rect.left, rect.bottom);
      path.lineTo(bLeft, bBottom - 6);
      path.lineTo(bLeft, bTop + r);
      path.arcToPoint(Offset(bLeft + r, bTop), radius: Radius.circular(r));
      path.close();
    } else {
      // Bubble Penjual (Kanan): Ekor di pojok kanan-bawah menunjuk ke bawah-kanan
      final bLeft = rect.left;
      final bRight = rect.right - tw;
      final bTop = rect.top;
      final bBottom = rect.bottom - th;

      path.moveTo(bLeft + r, bTop);
      path.lineTo(bRight - r, bTop);
      path.arcToPoint(Offset(bRight, bTop + r), radius: Radius.circular(r));
      path.lineTo(bRight, bBottom - 6);
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

/// Halaman Utama Tab Chat Penjual - Alur & Desain Persis dengan Tab Chat Pembeli
class PenjualChatScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PenjualChatScreen({super.key, this.onBack});

  @override
  State<PenjualChatScreen> createState() => _PenjualChatScreenState();
}

class _PenjualChatScreenState extends State<PenjualChatScreen> {
  int _selectedChatFilterIndex = 0; // 0 = Semua, 1 = Belum Dibaca
  final TextEditingController _chatSearchController = TextEditingController();
  String _chatSearchQuery = '';

  // Data Chat Penjual dengan Pembeli Amba (Sesuai Mockup & Asset)
  final List<ChatItemData> _chatItems = [
    ChatItemData(
      name: 'Amba',
      username: '@ambalohya56',
      lastMessage: 'Mas, Iga Sapi Backripsnya bisa kirim ke daerah Reuleut',
      time: '11.16',
      avatar: 'assets/images/avatar_amba.png',
      isOnline: true,
      isUnread: true,
      messages: [
        ChatMessageModel(
          text: 'Mas, Iga Sapi Backripsnya bisa kirim ke daerah Reuleut?',
          time: '11.14',
          isFromSeller: false,
        ),
        ChatMessageModel(
          text: 'Bisa banget kak! mau dipotong sekalian?',
          time: '11.15',
          isFromSeller: true,
        ),
        ChatMessageModel(
          text: 'Boleh, Mas',
          time: '11.16',
          isFromSeller: false,
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _chatSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredChats = _chatItems.where((chat) {
      if (_selectedChatFilterIndex == 1 && !chat.isUnread) {
        return false;
      }
      if (_chatSearchQuery.isNotEmpty) {
        final query = _chatSearchQuery.toLowerCase();
        return chat.name.toLowerCase().contains(query) ||
            chat.username.toLowerCase().contains(query) ||
            chat.lastMessage.toLowerCase().contains(query);
      }
      return true;
    }).toList();

    return MbgBackground(
      child: Column(
        children: [
          // 1. Rektanggel Header Putih (Meliputi Title "Chat" & Search Bar dengan Rounded Bottom & Drop Shadow Sesuai Mockup)
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),

                  // Judul "Chat" Hijau Sage dengan Font Baloo Tammudu 2 & Drop Shadow Sesuai Mockup
                  const Text(
                    'Chat',
                    style: TextStyle(
                      fontFamily: 'Baloo Tammudu 2',
                      fontSize: 64.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF7DA37D),
                      letterSpacing: -0.5,
                      height: 0.95,
                      shadows: [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          offset: Offset(0, 4),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Search Bar: Input box dengan Stroke #E0AA54 & Tombol Search Gold
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        // Input box "Cari nama toko" dengan border #E0AA54 & drop shadow
                        Expanded(
                          child: Container(
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE0AA54),
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.12),
                                  offset: Offset(0, 3),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: _chatSearchController,
                              onChanged: (value) {
                                setState(() {
                                  _chatSearchQuery = value;
                                });
                              },
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF334155),
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                hintText: 'Cari nama toko',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Tombol Search Gold dengan Icon & Text "Search"
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0AA54),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.20),
                                  offset: Offset(0, 4),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: Colors.white,
                                  size: 19,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Search',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 2. Kategori Filter Tabs: "Semua" & "Belum Dibaca" (Persis Pembeli dengan Padding Horizontal 48)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tab "Semua"
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedChatFilterIndex = 0;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Semua',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: _selectedChatFilterIndex == 0
                              ? const Color(0xFF6DA06D)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        height: 2.2,
                        width: 48,
                        decoration: BoxDecoration(
                          color: _selectedChatFilterIndex == 0
                              ? const Color(0xFF6DA06D)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab "Belum Dibaca"
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedChatFilterIndex = 1;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Belum Dibaca',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: _selectedChatFilterIndex == 1
                              ? const Color(0xFF6DA06D)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        height: 2.2,
                        width: 84,
                        decoration: BoxDecoration(
                          color: _selectedChatFilterIndex == 1
                              ? const Color(0xFF6DA06D)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // 3. Daftar Chat Items dengan White Card + Drop Shadow
          Expanded(
            child: filteredChats.isEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 36),
                      Image.asset(
                        'assets/images/ic_chat_empty.png',
                        width: 74,
                        height: 92,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        _selectedChatFilterIndex == 1
                            ? 'Ups! tidak ada pesan yang belum dibaca'
                            : _chatSearchQuery.trim().isNotEmpty
                                ? 'Ups! tidak ada pesan ditemukan'
                                : 'Ups! belum ada pesan',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF222222),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 4, bottom: 95),
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final item = filteredChats[index];
                      return _buildChatCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// Card Item Chat Persis Figma (Avatar dengan status online, Nama Pembeli, Username, Last Message, Time)
  Widget _buildChatCard(ChatItemData item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PenjualChatDetailScreen(
              chatItem: item,
              onChatRead: () {
                setState(() {
                  item.isUnread = false;
                });
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar Lingkaran dengan Status Online Hijau
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(item.avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (item.isOnline)
                  Positioned(
                    top: 1,
                    right: 1,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E676),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Info Pembeli: Nama, Username, dan Pesan Terakhir
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6DA06D),
                          height: 1.2,
                        ),
                      ),
                      const Spacer(),
                      // Waktu di pojok kanan atas
                      Text(
                        item.time,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.username,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF86B386),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF64748B),
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

/// Halaman Detail Chat (Room) Penjual - Mengikuti Alur & Desain ChatDetailScreen Pembeli 100%
class PenjualChatDetailScreen extends StatefulWidget {
  final ChatItemData chatItem;
  final VoidCallback? onChatRead;

  const PenjualChatDetailScreen({
    super.key,
    required this.chatItem,
    this.onChatRead,
  });

  @override
  State<PenjualChatDetailScreen> createState() =>
      _PenjualChatDetailScreenState();
}

class _PenjualChatDetailScreenState extends State<PenjualChatDetailScreen>
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
    _showUnreadBadge = widget.chatItem.isUnread;
    _messages = List<ChatMessageModel>.from(widget.chatItem.messages);

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

    // Animasi Alur Persis Pembeli:
    // Ketika chat dibuka, tulisan "Belum dibaca" muncul sepersekian detik,
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

    final newMsg = ChatMessageModel(
      text: text,
      time: timeStr,
      isFromSeller: true,
    );

    setState(() {
      _messages.add(newMsg);
      widget.chatItem.messages.add(newMsg);
      widget.chatItem.lastMessage = text;
      widget.chatItem.time = timeStr;
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
            // 1. Rektanggel Header Putih Presisi Figma (Membungkus Tombol Navigasi & Green Card Pembeli dengan Rounded Bottom 24 & Drop Shadow)
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
                      // Top Bar Navigasi (Back & Home)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tombol Back Melingkar / Icon Hijau Sesuai Figma
                          GestureDetector(
                            onTap: () {
                              if (widget.chatItem.isUnread) {
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
                              if (widget.chatItem.isUnread) {
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
                                  const Icon(
                                Icons.home_rounded,
                                color: Color(0xFF586A0E),
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // Header Card Hijau Pembeli (Avatar Amba, Nama Amba, Online)
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
                                  image: AssetImage(widget.chatItem.avatar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Nama Pembeli & Status Online
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.chatItem.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Online',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5,
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

            // 2. Chip Tanggal "Hari ini" Sesuai Mockup Figma
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 4.0),
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
                child: const Text(
                  'Hari ini',
                  style: TextStyle(
                    color: Color(0xFF7E9789),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // 3. Badge "Belum dibaca" dengan animasi menghilang otomatis & pergerakan chat ke atas
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
                        child: const Text(
                          'Belum dibaca',
                          style: TextStyle(
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

            // 4. Daftar Bubble Chat Ber-Ekor & Drop Shadow Presisi Figma (Ukuran Pas Sesuai Teks)
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildChatBubble(msg);
                },
              ),
            ),

            // 5. Bottom Input Box & Tombol Kirim Presisi Ukuran Figma
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
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF1E293B),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'Ketik pesan',
                            hintStyle: TextStyle(
                              color: Color(0xFF9E9E9E),
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
                        width: 50,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A852),
                          borderRadius: BorderRadius.circular(16.0),
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
                          size: 22,
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

  // Bubble Chat dengan Ekor Segitiga Asli, Drop Shadow Tegas, dan Kolom Pas Sesuai Teks (Wrap Content)
  Widget _buildChatBubble(ChatMessageModel msg) {
    final isSeller = msg.isFromSeller; // true = penjual di kanan, false = pembeli di kiri
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: Align(
        alignment: isSeller ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: SpeechBubbleShape(isUser: isSeller),
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
            isSeller ? 12.0 : 18.0,
            9.0,
            isSeller ? 18.0 : 12.0,
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
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                    height: 1.32,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  msg.time,
                  style: const TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF94A3B8),
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
