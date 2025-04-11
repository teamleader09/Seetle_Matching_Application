import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonWidgetType {
  tryItButton,
  notTryItButton,
  nowStart,
  nextString
}

class ButtonWidget extends StatefulWidget {
  final ButtonWidgetType btnType;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? textColor;
  final Color? fullColor;
  final bool? icon;
  final bool? size;

  const ButtonWidget({
    super.key,
    required this.btnType,
    required this.onPressed,
    required this.borderColor,
    required this.textColor,
    required this.fullColor,
    required this.icon,
    required this.size,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    String btnTitle;
    Widget? iconWidget;
    Widget? arrowIconWidget;

    switch (widget.btnType) {
      case ButtonWidgetType.tryItButton:
        btnTitle = tryItString.toString();
        break;
      case ButtonWidgetType.notTryItButton:
        btnTitle = notTryItString.toString();
        break;
      case ButtonWidgetType.nowStart:
        btnTitle = nowStart.toString();
        break;
      case ButtonWidgetType.nextString:
        btnTitle = nextString.toString();
        break;
      default:
        btnTitle = "unknown";
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: SizedBox(
            width: vw(context, 100),
            height: vh(context, 5.5),
            child: Container(
              decoration: BoxDecoration(
                color: widget.fullColor,
                border: Border.all(color: widget.borderColor!),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0XFF000000),
              textStyle: TextStyle(
                fontFamily: 'Onset-Regular',
                fontWeight: FontWeight.w500,
                fontSize: widget.size==true ? 30.sp : 40.sp,
              ),
            ),
            onPressed: widget.onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconWidget != null) ...[
                  iconWidget,
                  SizedBox(width: vMin(context, 1),)
                ],
                Text(
                  btnTitle,
                  style: TextStyle(color: widget.textColor!, fontFamily: 'Onset-Regular',),
                ),
                if (arrowIconWidget != null) ...[
                  SizedBox(width: vMin(context, 1),),
                  arrowIconWidget,
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
