import 'package:flutter/material.dart';

class ExpandingCircleImage extends StatefulWidget {
  final String imagePath;

  const ExpandingCircleImage({super.key, required this.imagePath});

  @override
  // ignore: library_private_types_in_public_api
  _ExpandingCircleImageState createState() => _ExpandingCircleImageState();
}

class _ExpandingCircleImageState extends State<ExpandingCircleImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scale = Tween<double>(begin: 0.9, end: 1.5).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
              opacity: _opacity.value,
              child: ClipOval(
                child: Transform.scale(
                  scale: _scale.value,
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 140,
                  ),
                ),
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
