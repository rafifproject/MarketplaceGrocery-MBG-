import 'package:flutter/material.dart';

class GoogleAccountSheet extends StatelessWidget {
  final VoidCallback onSelectRusdi;

  const GoogleAccountSheet({
    super.key,
    required this.onSelectRusdi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFDADCE0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Header: Google Logo + "Login dengan Google" + Close icon
            Row(
              children: [
                Image.asset(
                  'assets/images/google_logo.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Login dengan Google',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5F6368),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Color(0xFF5F6368),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Title: Pilih akun
            const Text(
              'Pilih akun',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202124),
              ),
            ),
            const SizedBox(height: 3),

            // Subtitle: untuk melanjutkan ke My Big Grocery
            Row(
              children: const [
                Text(
                  'untuk melanjutkan ke ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5F6368),
                  ),
                ),
                Text(
                  'My Big Grocery',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF01A852),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFE8EAED)),
            const SizedBox(height: 8),

            // Account: Rusdidaging23 (Akun Penjual)
            InkWell(
              onTap: onSelectRusdi,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/avatar_rusdi.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Rusdidaging23',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF202124),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'rusdidaging23@gmail.com',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF5F6368),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Divider(height: 1, color: Color(0xFFE8EAED)),
            const SizedBox(height: 12),

            // Footer disclaimer
            const Text(
              'Untuk melanjutkan, Google akan membagikan nama, alamat email, dan foto profil Anda kepada My Big Grocery.',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF5F6368),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
