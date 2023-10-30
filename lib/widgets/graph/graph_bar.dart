import 'package:flutter/material.dart';

class GraphBar extends StatefulWidget {
  const GraphBar({super.key, required this.height});

  final double height;

  @override
  State<StatefulWidget> createState() {
    return _GraphBar();
  }
}

class _GraphBar extends State<GraphBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.height * 150,
      width: 30,
      color: Colors.blue[300],
      duration: const Duration(milliseconds: 700),
    );
  }
}
