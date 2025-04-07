import 'package:flutter/material.dart';
import 'package:seetle/src/translate/jp.dart';
import 'package:seetle/src/utils/index.dart';
import 'package:seetle/src/constants/app_styles.dart';

class WhooSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: vhh(context, 5),
            left: vMin(context, 3),
            right: vMin(context, 3)),
        height: vhh(context, 85),
        decoration: const BoxDecoration(
          color: kColorBlack,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInviteCard(),
            const SizedBox(height: 24),
            _buildMenuItem(Icons.person, account),
            _buildMenuItem(Icons.visibility_off, ghostMode),
            _buildMenuItem(Icons.lock, privacySettings),
            _buildMenuItem(Icons.info_outline, about),
            _buildMenuItem(Icons.help_outline, question),
            _buildMenuItem(Icons.map, mapOption),
            _buildMenuItem(Icons.mail_outline, help),
            const SizedBox(height: 32),
            Text(
              whoIcon,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildIconsRow(),
            const SizedBox(height: 8),
            Text(
              whoOpenDoor,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.indigo],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("さらに友達を追加する",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text("友達をwhooに招待してPOPSを増やそう",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.group, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: TextStyle(color: Colors.white)),
      onTap: () {}, // Add navigation or actions here
    );
  }

  Widget _buildIconsRow() {
    return Row(
      children: [
        _buildUnLockedIcon(),
        const SizedBox(width: 12),
        _buildLockedIcon(),
        const SizedBox(width: 12),
        _buildLockedIcon(),
        const SizedBox(width: 12),
        _buildLockedIcon(),
      ],
    );
  }

  Widget _buildUnlockIcon(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(assetPath, width: 40, height: 40),
    );
  }

  Widget _buildLockedIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.lock, color: Colors.white54, size: 40),
    );
  }

  Widget _buildUnLockedIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.face_unlock_outlined, color: Colors.white54, size: 40),
    );
  }
}
