import 'package:flutter/material.dart';
import 'package:seetle/src/constants/app_styles.dart';
import 'package:seetle/src/translate/jp.dart';
import 'package:seetle/src/utils/index.dart';

class AddFriendBottomSheet extends StatefulWidget {
  const AddFriendBottomSheet({super.key});

  @override
  State<AddFriendBottomSheet> createState() => _AddFriendBottomSheetState();
}

class _AddFriendBottomSheetState extends State<AddFriendBottomSheet> {
  bool isApplyingSelected = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: vhh(context, 5),
            left: vMin(context, 3),
            right: vMin(context, 3)),
        height: vhh(context, 95),
        decoration: const BoxDecoration(
          color: kColorBlack,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(left: 0, top: 0), // You can adjust this value
              child: Text(
                addFriend,
                style: TextStyle(
                  color: kColorWhite,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuItem(Icons.qr_code, addQRCode),
            const SizedBox(height: 15),
            _buildMenuItem(Icons.edit_square, addID),
            const SizedBox(height: 32),
            Container(
              height: vhh(context, 5),
              decoration: BoxDecoration(
                color: kColorLightGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildTabButton(applying, isApplyingSelected, () {
                    setState(() => isApplyingSelected = true);
                  }),
                  _buildTabButton(pending, !isApplyingSelected, () {
                    setState(() => isApplyingSelected = false);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: const Text(
                noUser,
                style: TextStyle(
                  color: kColorWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _buildIconItem(icon),
      title: Text(label, style: TextStyle(color: Colors.white)),
      onTap: () {}, // Add navigation or actions here
    );
  }

  Widget _buildIconItem(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 40),
    );
  }

  Widget _buildTabButton(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: vhh(context, 4.7),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Color(0xFF222222),
            borderRadius: selected ? BorderRadius.circular(15) : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : const Color(0xFF666666),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
