import 'package:flutter/material.dart';

import 'views/listPage.dart';

class splashPage extends StatefulWidget {
  final String nameValue;
  splashPage({this.nameValue="",});

  @override
  State<splashPage> createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late String _name;
  @override
  void initState() {
    super.initState();
    _name = widget.nameValue;

    new Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => listPage()),
        ));

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(begin: Offset(0, 0.0), end: Offset(0, -2))
        .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
        reverseCurve: Curves.easeInOutBack));
  }
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child:SlideTransition(
              position: _offsetAnimation,
              child: Text(
                "HAZIRLIYORUZZZZ $_name\n 1 SN ... ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )
        ));
  }
}