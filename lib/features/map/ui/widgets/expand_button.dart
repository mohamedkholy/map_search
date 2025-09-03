import 'package:flutter/material.dart';
import 'package:map_search/core/theming/my_colors.dart';

class ExpandButton extends StatelessWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool arrowUp;
  const ExpandButton({
    super.key,
    required this.onArrowClick,
    this.padding,
    this.margin,
    this.arrowUp = false,
  });

  final VoidCallback onArrowClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onArrowClick,
      child: Container(
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Icon(
          arrowUp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
