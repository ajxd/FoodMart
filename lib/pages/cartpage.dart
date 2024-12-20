import 'package:flutter/material.dart';
import 'package:foodmart/model/cart.dart';
import 'package:foodmart/model/culinarycreation.dart';
import 'checkout_page.dart'; // Import the CheckoutPage

class CartPage extends StatefulWidget {
  final Cart cart;

  CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              if (widget.cart.items.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Clear Cart"),
                      content: Text("Are you sure you want to clear the cart?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text("Clear"),
                          onPressed: () {
                            setState(() {
                              widget.cart.clearCart();
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: widget.cart.items.isEmpty
          ? Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
          : buildCartList(),
      bottomNavigationBar: widget.cart.items.isNotEmpty ? buildBottomBar() : null,
    );
  }

  Widget buildCartList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.cart.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.cart.items.values.elementAt(index);
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.fastfood),
            title: Text(item.creation.title),
            subtitle: Text("\$${item.creation.costEstimation.toStringAsFixed(2)} x ${item.quantity}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      widget.cart.removeItem(item.creation.creationId);
                    });
                  },
                ),
                Text("${item.quantity}"),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      widget.cart.addItem(item.creation);
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBottomBar() {
    return BottomAppBar(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: \$${widget.cart.getTotalPrice().toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage(cart: widget.cart)),
                );
              },
              child: Text(
                "Proceed to Checkout",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
            ),
            )],
        ),
      ),
    );
  }
}
