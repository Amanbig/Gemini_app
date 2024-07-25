import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Parts extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function? func;
  final Color? color1;
  final Color? color2;

  Parts({Key? key, required this.title, required this.icon, this.func,required this.color1,required this.color2}) : super(key: key);

  @override
  _PartsState createState() => _PartsState();
}

class _PartsState extends State<Parts> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(begin: widget.color1, end: widget.color2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          if (widget.func != null) {
            widget.func!();
          }
        },
        onTapDown: (_) {
          _controller.forward();
        },
        onTapUp: (_) {
          _controller.reverse();
        },
        onTapCancel: () {
          _controller.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(24),
                color: _colorAnimation.value,
                border: Border.all(
                  color: Colors.white,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Icon(
                        widget.icon,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
