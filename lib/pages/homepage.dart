import 'package:flutter/material.dart';
import 'package:foodmart/model/culinarycreation.dart';
import 'package:foodmart/model/cart.dart';
import 'package:foodmart/pages/cartpage.dart';
import 'package:foodmart/pages/details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'profile_page.dart';
import 'new_user_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final Cart cart = Cart(); // Create a Cart object
  List<CulinaryCreation> filteredCreations = [];
  List<CulinaryCreation> sampleCreations = [
    // Momos
    CulinaryCreation(
      creationId: "1",
      visualRepresentation: "asset/momo.jpeg",
      title: "Momos",
      costEstimation: 10,
      satisfactionIndex: 4.8,
      nutritionalDetails: NutritionalProfile(calories: "200", fats: "5g", carbs: "30g", proteins: "12g"),
      estimatedPreparationTime: "20 mins",
      culinaryNarrative: "Delicious Tibetan style dumplings filled with seasoned vegetables.",
      keyIngredients: ["Flour", "Cabbage", "Carrot", "Spices"],
      dietaryPreferences: DietaryPreferences(isVegetarian: true, isVegan: false, isGlutenFree: false),
      nutritionalInfo: "Rich in carbohydrates and proteins.",
    ),
    // Stir-Fry Noodles
    CulinaryCreation(
      creationId: "2",
      visualRepresentation: "asset/noodles.jpeg",
      title: "Stir-Fry Noodles",
      costEstimation: 15,
      satisfactionIndex: 4.7,
      nutritionalDetails: NutritionalProfile(calories: "300", fats: "10g", carbs: "40g", proteins: "8g"),
      estimatedPreparationTime: "15 mins",
      culinaryNarrative: "Savory stir-fried noodles with a mix of fresh vegetables and a hint of soy sauce.",
      keyIngredients: ["Noodles", "Bell Peppers", "Onions", "Soy Sauce"],
      dietaryPreferences: DietaryPreferences(isVegetarian: true, isVegan: true, isGlutenFree: false),
      nutritionalInfo: "Balanced meal with carbs and vegetables.",
    ),
    // Grilled Lamb Chops
    CulinaryCreation(
      creationId: "3",
      visualRepresentation: "asset/lamb.jpeg",
      title: "Grilled Lamb Chops",
      costEstimation: 20,
      satisfactionIndex: 4.9,
      nutritionalDetails: NutritionalProfile(calories: "400", fats: "20g", carbs: "5g", proteins: "30g"),
      estimatedPreparationTime: "30 mins",
      culinaryNarrative: "Juicy lamb chops grilled to perfection with a blend of aromatic herbs.",
      keyIngredients: ["Lamb", "Rosemary", "Thyme", "Garlic"],
      dietaryPreferences: DietaryPreferences(isVegetarian: false, isVegan: false, isGlutenFree: true),
      nutritionalInfo: "High in protein and fats.",
    ),
    // Blueberry Pancakes
    CulinaryCreation(
      creationId: "4",
      visualRepresentation: "asset/pancakes.jpeg",
      title: "Blueberry Pancakes",
      costEstimation: 12,
      satisfactionIndex: 4.6,
      nutritionalDetails: NutritionalProfile(calories: "280", fats: "8g", carbs: "45g", proteins: "6g"),
      estimatedPreparationTime: "10 mins",
      culinaryNarrative: "Fluffy pancakes filled with fresh blueberries, served with maple syrup.",
      keyIngredients: ["Flour", "Blueberries", "Eggs", "Milk"],
      dietaryPreferences: DietaryPreferences(isVegetarian: true, isVegan: false, isGlutenFree: false),
      nutritionalInfo: "Rich in carbohydrates, perfect for breakfast.",
    ),
    // Classic Margherita Pizza
    CulinaryCreation(
      creationId: "5",
      visualRepresentation: "asset/pizza.jpeg",
      title: "Margherita Pizza",
      costEstimation: 18,
      satisfactionIndex: 4.8,
      nutritionalDetails: NutritionalProfile(calories: "270", fats: "10g", carbs: "35g", proteins: "12g"),
      estimatedPreparationTime: "25 mins",
      culinaryNarrative: "Classic Italian pizza with fresh tomatoes, mozzarella cheese, and basil.",
      keyIngredients: ["Pizza Dough", "Tomatoes", "Mozzarella", "Basil"],
      dietaryPreferences: DietaryPreferences(isVegetarian: true, isVegan: false, isGlutenFree: false),
      nutritionalInfo: "A delightful blend of fresh ingredients.",
    ),
    // Grilled Salmon
    CulinaryCreation(
      creationId: "6",
      visualRepresentation: "asset/salmon.jpeg",
      title: "Grilled Salmon",
      costEstimation: 22,
      satisfactionIndex: 4.7,
      nutritionalDetails: NutritionalProfile(calories: "320", fats: "15g", carbs: "5g", proteins: "35g"),
      estimatedPreparationTime: "20 mins",
      culinaryNarrative: "Perfectly grilled salmon with a lemon-herb dressing.",
      keyIngredients: ["Salmon", "Lemon", "Herbs", "Olive Oil"],
      dietaryPreferences: DietaryPreferences(isVegetarian: false, isVegan: false, isGlutenFree: true),
      nutritionalInfo: "Rich in Omega-3 fatty acids and protein.",
    ),
    // Classic Beef Burger
    CulinaryCreation(
      creationId: "7",
      visualRepresentation: "asset/burger.jpeg",
      title: "Classic Beef Burger",
      costEstimation: 16,
      satisfactionIndex: 4.5,
      nutritionalDetails: NutritionalProfile(calories: "500", fats: "25g", carbs: "40g", proteins: "30g"),
      estimatedPreparationTime: "15 mins",
      culinaryNarrative: "Juicy beef patty with lettuce, tomato, and cheese in a toasted bun.",
      keyIngredients: ["Beef Patty", "Lettuce", "Tomato", "Cheese"],
      dietaryPreferences: DietaryPreferences(isVegetarian: false, isVegan: false, isGlutenFree: false),
      nutritionalInfo: "High in protein and flavor.",
    ),
    // Chicken Biryani
    CulinaryCreation(
      creationId: "8",
      visualRepresentation: "asset/biryani.jpg",
      title: "Chicken Biryani",
      costEstimation: 14,
      satisfactionIndex: 4.9,
      nutritionalDetails: NutritionalProfile(calories: "350", fats: "15g", carbs: "45g", proteins: "25g"),
      estimatedPreparationTime: "40 mins",
      culinaryNarrative: "Aromatic and flavorful traditional Indian rice dish with spiced chicken.",
      keyIngredients: ["Chicken", "Basmati Rice", "Spices", "Yogurt"],
      dietaryPreferences: DietaryPreferences(isVegetarian: false, isVegan: false, isGlutenFree: false),
      nutritionalInfo: "A delightful mix of spices and tender chicken.",
    ),
    // Vegan Chocolate Cake
    CulinaryCreation(
      creationId: "9",
      visualRepresentation: "asset/cake.jpeg",
      title: "Vegan Chocolate Cake",
      costEstimation: 20,
      satisfactionIndex: 4.6,
      nutritionalDetails: NutritionalProfile(calories: "300", fats: "12g", carbs: "45g", proteins: "5g"),
      estimatedPreparationTime: "60 mins",
      culinaryNarrative: "Rich and moist chocolate cake made with vegan ingredients.",
      keyIngredients: ["Flour", "Cocoa Powder", "Vegan Butter", "Almond Milk"],
      dietaryPreferences: DietaryPreferences(isVegetarian: true, isVegan: true, isGlutenFree: false),
      nutritionalInfo: "Decadent dessert without any animal products.",
    ),
    // Turkey and Avocado Wrap
    CulinaryCreation(
      creationId: "10",
      visualRepresentation: "asset/burger.jpeg",
      title: "Turkey and Avocado Wrap",
      costEstimation: 13,
      satisfactionIndex: 4.4,
      nutritionalDetails: NutritionalProfile(calories: "250", fats: "9g", carbs: "25g", proteins: "20g"),
      estimatedPreparationTime: "10 mins",
      culinaryNarrative: "Healthy wrap filled with turkey, avocado, and fresh veggies.",
      keyIngredients: ["Turkey", "Avocado", "Lettuce", "Tomato"],
      dietaryPreferences: DietaryPreferences(isVegetarian: false, isVegan: false, isGlutenFree: false),
      nutritionalInfo: "Perfect for a light and nutritious meal.",
    ),
  ];


  @override
  void initState() {
    super.initState();
    filteredCreations = sampleCreations;
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() => filteredCreations = sampleCreations);
      return;
    }
    List<CulinaryCreation> dummyListData = [];
    sampleCreations.forEach((item) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        dummyListData.add(item);
      }
    });
    setState(() => filteredCreations = dummyListData);
  }

  String _greetUser() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodMart Delights"),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(cart: cart))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              child: Text("Special Promotion!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Text("${_greetUser()}, ${widget.username}!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items: sampleCreations.map((creation) {
                return FoodItemCard(
                  creation: creation,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsPage(creation: creation, cart: cart),
                    ));
                  },
                );
              }).toList(),
            ),
            TextField(
              onChanged: (value) => filterSearchResults(value),
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search for food items",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: filteredCreations.length,
              itemBuilder: (BuildContext context, int index) {
                return FoodItemCard(
                  creation: filteredCreations[index],
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsPage(creation: filteredCreations[index], cart: cart),
                    ));
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 2) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(username: widget.username),
            ));
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class FoodItemCard extends StatefulWidget {
  final CulinaryCreation creation;
  final VoidCallback onTap;

  FoodItemCard({Key? key, required this.creation, required this.onTap}) : super(key: key);

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  bool isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => isPressed = false);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        transform: Matrix4.diagonal3Values(isPressed ? 0.95 : 1.0, isPressed ? 0.95 : 1.0, 1),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: Image.asset(widget.creation.visualRepresentation, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.creation.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${widget.creation.costEstimation.toStringAsFixed(2)}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        Icon(Icons.star, color: Colors.amber),
                        Text('${widget.creation.satisfactionIndex}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}