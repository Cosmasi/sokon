import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokon/providers/cartProvider.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:sokon/tools/app_tools.dart';
import 'package:sokon/usersScreen/homeScreen.dart';

import 'cartScreen.dart';


class AddProducts extends StatefulWidget {
  static const String id = "addProducts";
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  List<DropdownMenuItem<String>> _dropDownQuantity;

  String _selectedQuantity;

  List<String> quantityList = List();

  Map<int, File> imageMap = Map();

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDescController = TextEditingController();

  DateTime time = DateTime.now();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    quantityList = List.from(localQuantity);
    _dropDownQuantity = buildGetDropDownQuantity(quantityList);
    _selectedQuantity = _dropDownQuantity[0].value;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Add Products"),
          elevation: 0.0,
          actions: [
            Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Icon(Icons.shopping_cart, size: 35.0),
                  ),
                ),
                Positioned(
                  top: 5.0,
                  child: CircleAvatar(
                    radius: 10.0,
                    backgroundColor: Colors.red,
                    child: Text(
                      cart.items.length == 0 ? "0" : "${cart.items.length}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10.0),

              productTextField(
                controller: productTitleController,
                boxColor: Colors.white,
                textTitle: "Product name", 
                texHint: "Enter Product name",
              ),

              SizedBox(height: 10.0),

              productTextField(
                controller: productDescController,
                boxColor: Colors.white,
                textTitle: "Product Description",
                texHint: "Enter Product Description",
                height: 180.0,
                maxlines: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  productDropDown(
                    textTitle: "Quantity",
                    selectedItem: _selectedQuantity,
                    dropDownItems: _dropDownQuantity,
                    changeDropDownItems: changedDropDownQuantity,
                  ),
                ],
              ),
              appButton(
                buttonText: 'Add Products To the Cart',
                icon: Icons.add, size: 30.0, color: Colors.green,
                buttonPadding: 15.0,
                buttoncolor: Colors.black,
                btnColor: Colors.white,
                onBtnclick: () {
                  addNewProduct(context);
                  clearInputData();
                  Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Product added to the cart'),
                  ));
                },
              ),
              SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }

  void changedDropDownQuantity(String selectedSize) {
    setState(() {
      _selectedQuantity = selectedSize;
      print(selectedSize);
    });
  }

  void addNewProduct(context){
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.addToCart(
      time.toIso8601String(), 
      productTitleController.text, 
    );
  }

  void clearInputData(){
    setState(() {
      productTitleController.clear();
      productDescController.clear();
    });
  }

}