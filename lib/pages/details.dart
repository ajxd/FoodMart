import 'package:flutter/material.dart';
import 'package:foodmart/model/culinarycreation.dart';
import 'package:foodmart/model/cart.dart';
import 'package:foodmart/pages/cartpage.dart';

class DetailsPage extends StatelessWidget {
  final CulinaryCreation creation;
  final Cart cart;

  DetailsPage({Key? key, required this.creation, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(creation.title),
        backgroundColor: Colors.lightGreen, // Enhanced color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(creation.visualRepresentation), // Carousel for images
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                creation.culinaryNarrative,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Divider(),
            DetailSection(creation: creation),
            Divider(),
            // Placeholder for user reviews
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("User Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            // Mock review list
            ...List.generate(5, (index) => UserReviewWidget()),
          ],
        ),
      ),
      floatingActionButton: AnimatedAddToCartButton(creation: creation, cart: cart),
    );
  }
}

class ImageCarousel extends StatelessWidget {
  final String imagePath;
  ImageCarousel(this.imagePath);

  @override
  Widget build(BuildContext context) {

    return Image.asset(
      imagePath,
      width: double.infinity,
      height: 250.0,
      fit: BoxFit.cover,
    );
  }
}

class DetailSection extends StatelessWidget {
  final CulinaryCreation creation;
  DetailSection({required this.creation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailWidget("Preparation Time", creation.estimatedPreparationTime),
          detailWidget("Nutritional Info", creation.nutritionalInfo),
          detailWidget("Calories", creation.nutritionalDetails.calories),
          detailWidget("Fats", creation.nutritionalDetails.fats),
          detailWidget("Carbs", creation.nutritionalDetails.carbs),
          detailWidget("Proteins", creation.nutritionalDetails.proteins),
          detailWidget("Satisfaction Index", "${creation.satisfactionIndex} stars"),
          detailWidget("Key Ingredients", creation.keyIngredients.join(", ")),

        ],
      ),
    );
  }

  Widget detailWidget(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text("$title: ", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(detail),
          ),
        ],
      ),
    );
  }
}

class AnimatedAddToCartButton extends StatelessWidget {
  final CulinaryCreation creation;
  final Cart cart;

  AnimatedAddToCartButton({required this.creation, required this.cart});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        cart.addItem(creation);
        Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(cart: cart)));
      },
      label: Text("Add to Cart", style: TextStyle(color: Colors.white)),
      icon: Icon(Icons.add_shopping_cart, color: Colors.white),
      backgroundColor: Colors.green,
    );
  }
}

class UserReviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder widget for user reviews
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text("Great taste! Loved it.", style: TextStyle(fontSize: 16)),
    );
  }
}
