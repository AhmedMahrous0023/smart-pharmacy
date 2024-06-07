import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Core/Helper/cart_helper.dart';
import 'package:smart_pharmacy/Core/offline%20DataBase/allowed_medicines.dart';
import 'package:smart_pharmacy/Models/medicine_model.dart';
import 'package:smart_pharmacy/Views/Screens/checkout_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';
import 'package:smart_pharmacy/Views/Widgets/selector_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
 

  dialogue() {
    for (var element in myCart) {
      if (element.quantity == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const CustomText(
                    text: 'Are you sure you want to delete that item ?',
                    fontSize: 16,
                  ),
                  actions: [
                    // cancel button
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                    //yes button
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          deleteItem(element);
                        },
                        child: const Text('Yes')),
                  ],
                ));
      }
    }
  }

  deleteItem(MedicineModel medicineModel)async {
    setState(() {
      myCart.remove(medicineModel);
      priceTotal -= medicineModel.price * medicineModel.quantity;
    });
    await CartHelper().deleteCartItem(medicineModel.id!);
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (final item in myCart) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void decreaseQuantity(int index) {
    if (myCart[index].quantity > 0) {
      setState(() {
        myCart[index].quantity--;
        totalDiscount =
            calculateTotalDiscount(); 
        priceTotal = calculateTotalPrice(); 
        if (myCart[index].quantity == 0) {
          dialogue(); 
        }
      });

    }
  }

  double calculateTotalDiscount() {
    double discount = 0.0;
    
    return discount;
  }

  void increaseQuantity(int index) {
    setState(() {
      myCart[index].quantity++;
      totalDiscount = calculateTotalDiscount(); 
      priceTotal = calculateTotalPrice(); 
    });
  }

  @override
void initState() {
  super.initState();
  _fetchCartItems();
}

Future<void> _fetchCartItems() async {
  final cartItems = await CartHelper().getCartItems();
  
  setState(() {
    // myCart = cartItems; // Update your `myCart` state with fetched items
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Your Cart',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        child: myCart.isEmpty
            ? Center(child: Image.asset('images/emptycart.png'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                          text: '${myCart.length} items in your cart',
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )),
                            CustomText(
                              text: 'Add more',
                              fontSize: 16,
                            )
                          ],
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: myCart.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      myCart[index].image,
                                      width: 70,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                        text: myCart[index].name,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.purple,
                                      ),
                                      CustomText(
                                        text:
                                            '${myCart[index].price * myCart[index].quantity} LE',
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        foregroundColor: Colors.red,
                                        backgroundColor: const Color.fromARGB(
                                            255, 202, 198, 198),
                                        child: IconButton(
                                            onPressed: () {
                                              deleteItem(myCart[index]);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SelectorCart(
                                            text: myCart[index]
                                                .quantity
                                                .toString(),
                                            decrease: () {
                                              //
                                              decreaseQuantity(index);
                                            }
                    
                                            //
                                            ,
                                            incrrease: () {
                                              //
                                              increaseQuantity(index);
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 40),
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Payment Summary',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Order Total',
                                  color: Colors.grey,
                                ),
                                CustomText(text: '${priceTotal}')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Items Discount',
                                  color: Colors.grey,
                                ),
                                CustomText(text: '0.0')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'coupon Discount',
                                  color: Colors.grey,
                                ),
                                CustomText(text: '0.0')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Shipping',
                                  color: Colors.grey,
                                ),
                                CustomText(text: 'Free')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Total',
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: '${priceTotal}LE',
                                  fontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CheckOutScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: LinearBorder(),
                                    backgroundColor: greenColor,
                                    foregroundColor: Colors.white,
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width * .80,
                                        MediaQuery.of(context).size.height *
                                            .072)),
                                child: CustomText(
                                  text: 'Place Order',
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
