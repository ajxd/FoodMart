import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'login_page.dart'; // Make sure to import the LoginPage here

class IntroLoadingPage extends StatefulWidget {
  @override
  _IntroLoadingPageState createState() => _IntroLoadingPageState();
}

class _IntroLoadingPageState extends State<IntroLoadingPage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.elasticOut,
    );

    _navigateToLogin();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation!,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello, welcome to',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'FOOD MART',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
