// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  double? size;
  double? iconSize;
  Function onChange;
  Color? backgroundColor;
  Color? iconColor;
  Color? borderColor;
  IconData? icon;
  bool isChecked;

  CustomCheckbox({
    Key? key,
    this.size,
    this.iconSize,
    required this.onChange,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.borderColor,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChange(isChecked);
        });
      },
      child: AnimatedContainer(
        height: widget.size ?? 25,
        width: widget.size ?? 25,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: isChecked
              ? widget.backgroundColor ?? Colors.blue
              : Colors.transparent,
          border: Border.all(
            color: widget.borderColor ?? const Color(0xffcc9900),
          ),
        ),
        child: isChecked
            ? Icon(
                widget.icon ?? Icons.check,
                color: widget.iconColor ?? Colors.white,
                size: widget.iconSize ?? 15,
              )
            : null,
      ),
    );
  }
}
