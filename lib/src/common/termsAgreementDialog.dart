import 'package:flutter/material.dart';
import 'package:seetle/src/utils/index.dart';

class TermsAgreementDialog extends StatelessWidget {
  final String content;
  final String buttonText;
  final VoidCallback onAgree;

  const TermsAgreementDialog({
    super.key,
    required this.content,
    required this.buttonText,
    required this.onAgree,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: vhh(context, 5),),
            const Divider(height: 1),
            SizedBox(height: vhh(context, 2),),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                onAgree();
              },
              child:  Container(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
