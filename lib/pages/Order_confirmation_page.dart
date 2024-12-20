import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Make sure to include the Lottie package in your pubspec.yaml

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset('asset/order.json'), // Lottie Animation
              SizedBox(height: 30),
              AnimatedText(
                text: 'Food Order Placed!',
                duration: Duration(seconds: 3),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Thank you for your order! Your delicious food is on the way.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Hero(
                tag: 'backToHome', // Hero Animation for the button
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Back to Home'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushNamed(context, '/homepage'); // Adjust the route according to your app
                },
                child: Text('Return to Homepage'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  final String text;
  final Duration duration;

  AnimatedText({required this.text, this.duration = const Duration(seconds: 2)});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TextStyle> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = TextStyleTween(
      begin: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
      end: TextStyle(fontSize: 28, color: Colors.deepPurple, fontWeight: FontWeight.bold),
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: _animation.value,
    );
  }
}
