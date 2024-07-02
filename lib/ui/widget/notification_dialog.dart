import 'package:flutter/material.dart';

import 'common_button.dart';

class NotificationDialog extends StatelessWidget {
  final double? height;
  final String title;
  final String? descriptionText;
  final String? buttonText;
  final VoidCallback? onClickButton;
  final VoidCallback? onClose;
  final TextAlign? descriptionTextAlign;
  final Widget? button;
  final bool isShowCloseButton;
  final int? maxLength;

  const NotificationDialog({
    Key? key,
    this.height,
    required this.title,
    this.buttonText,
    this.onClickButton,
    this.descriptionText,
    this.onClose,
    this.descriptionTextAlign,
    this.button,
    this.isShowCloseButton = true,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: isShowCloseButton,
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onClose ??
                      () {
                        Navigator.pop(context);
                      },
                  customBorder: const CircleBorder(),
                  child: const Icon(Icons.close),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            Visibility(
              visible: descriptionText != null,
              child: buildDescriptionText(),
            ),
            const SizedBox(height: 4),
            button ??
                Visibility(
                  visible: buttonText != null,
                  child: CommonButton(
                    text: buttonText ?? '',
                    onTap: onClickButton ?? () {},
                  ),
                )
          ],
        ),
      ),
    );
  }

  Padding buildDescriptionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        descriptionText ?? '',
        textAlign: descriptionTextAlign,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        maxLines: maxLength ?? 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
