import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

class EHSeparator extends StatefulWidget {
  final SeparatorArgsInfo info;
  final SeparatorController controller;

  const EHSeparator({Key? key, required this.info, required this.controller}) : super(key: key);

  @override
  State<EHSeparator> createState() => _EHSeparatorState();
}

class _EHSeparatorState extends State<EHSeparator> {
  late double dividerWidth;
  late double dividerHeight;

  @override
  void initState() {
    super.initState();
    dividerWidth = widget.info.isHorizontalSeparator ? double.infinity : widget.info.size / 5;
    dividerHeight = widget.info.isHorizontalSeparator ? widget.info.size / 5 : double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            dividerWidth *= 5;
            dividerHeight *= 5;
          });
        },
        onExit: (event) {
          setState(() {
            dividerWidth /= 5;
            dividerHeight /= 5;
          });
        },
        cursor: widget.info.isHorizontalSeparator ? SystemMouseCursors.resizeRow : SystemMouseCursors.resizeColumn,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          width: widget.info.isHorizontalSeparator ? double.infinity : widget.info.size,
          height: widget.info.isHorizontalSeparator ? widget.info.size : double.infinity,
          child: Center(
            child: Container(
              height: dividerHeight,
              width: dividerWidth,
              color: widget.info.color,
            ),
          ),
        ),
      ),
      onPanDown: (details) => widget.controller.onPanStart(details),
      onPanUpdate: (details) => widget.controller.onPanUpdate(details, context),
      onPanEnd: (details) => widget.controller.onPanEnd(details),
      onDoubleTap: () => widget.controller.onDoubleTap(),
    );
  }
}
