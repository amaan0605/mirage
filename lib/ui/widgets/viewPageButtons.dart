import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewPageButtons extends StatefulWidget {
  ViewPageButtons({
    @required this.onpressed,
    @required this.icon,
  });

  Icon icon;
  Function onpressed = () {};

  @override
  _ViewPageButtonsState createState() => _ViewPageButtonsState();
}

class _ViewPageButtonsState extends State<ViewPageButtons> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onpressed,
      icon: widget.icon,
    );
  }
}
