import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Core/Helper/cart_helper.dart';
import 'package:smart_pharmacy/Core/Service/auth_service.dart';
import 'package:smart_pharmacy/Core/offline%20DataBase/allowed_medicines.dart';
import 'package:smart_pharmacy/Models/medicine_model.dart';
import 'package:smart_pharmacy/Views/Screens/cart_screen.dart';
import 'package:smart_pharmacy/Views/Screens/login_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _uniqueIdCounter = 0;

  int generateUniqueId() {
    _uniqueIdCounter++;
    return _uniqueIdCounter;
  }

  void addToCart(MedicineModel medicineModel) async {
    if (myCart.isEmpty) {
      setState(() {
        myCart.add(medicineModel);
        if (medicineModel.id == null) {
          medicineModel.id = generateUniqueId(); // Generate ID if null
        } // Increment and assign a unique ID

        medicineModel.quantity++;
        priceTotal = medicineModel.price * medicineModel.quantity;
      });
      await CartHelper().insertCartItem(medicineModel);
    } else if (myCart.contains(medicineModel)) {
      setState(() {
        medicineModel = myCart.firstWhere((item) => item == medicineModel);
        medicineModel.quantity++;
        priceTotal = calculateTotalPrice(); // Calculate total after update
      });
      await CartHelper().updateCartItemQuantity(
          medicineModel.id == null ? generateUniqueId() : medicineModel.id!,
          medicineModel.quantity.toInt()); // Update quantity in DB
    } else {
      setState(() {
        myCart.add(medicineModel);
        medicineModel.quantity++; // Increment quantity here
        priceTotal = calculateTotalPrice(); // Calculate total after update
      });
      await CartHelper().insertCartItem(medicineModel); // Insert new item in DB
    }
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (final item in myCart) {
      total += item.price * item.quantity;
    }
    return total;
  }

  String _userEmail = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userEmail = user.email!;
      _userName = user.displayName ?? ''; // Use default if not provided
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            width: MediaQuery.of(context).size.width * .60,
            child: Stack(
              children: [
                Image.asset(
                  'images/logo 2.png',
                  width: MediaQuery.of(context).size.width * .18,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .04,
                  left: MediaQuery.of(context).size.width * .14,
                  child: CustomText(
                    text: 'Smart Pharmacy',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Icon(Icons.shopping_cart_outlined)),
            Icon(Icons.notifications_none),
            SizedBox(
              width: MediaQuery.of(context).size.width * .05,
            )
          ],
        ),
        drawer: Drawer(
          elevation: 5,
          width: MediaQuery.of(context).size.width * .50,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 3, color: Colors.green),color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromARGB(255, 193, 183, 208),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'We',
                            color: Colors.blue,
                          ),
                          CustomText(
                            text: 'lc',
                            color: Colors.amber,
                          ),
                          CustomText(text: 'ome'),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage:
                          AssetImage('images/person-placeholder.jpg'),
                    ),
                    CustomText(text: ' $_userName',color: Colors.indigo,fontWeight: FontWeight.w800,),
                    CustomText(text:'Email: $_userEmail',fontSize: 14,color: Colors.indigo,),
                  ],
                ),
                Card(
                  color: Colors.blueGrey,
                  child: TextButton(
                    child: CustomText(text: 'Sign Out',color: Colors.white,),
                    onPressed: () async {
                      await AuthService.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 30, left: 30, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: Search());
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .06,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.search),
                          CustomText(
                            text: 'Search For Pharmacy',
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 1.1,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: getMedicines(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: medicines.length,
                              itemBuilder: (context, index) {
                                final medicine = medicines[index];
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    height: MediaQuery.of(context).size.height *
                                        .10,
                                    child: Card(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            medicine.image,
                                            width: 60,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .09,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: CustomText(
                                                  text: medicine.name,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    text:
                                                        '${medicine.price.toString()}LE',
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  Visibility(
                                                      visible:
                                                          medicine.haveDiscount,
                                                      child: CustomText(
                                                        text:
                                                            '${medicine.couponDiscount + medicine.price}LE',
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                addToCart(medicines[index]),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .15,
                                              child: Card(
                                                elevation: 1,
                                                color: Colors.grey[200],
                                                child: Icon(
                                                  Icons
                                                      .add_shopping_cart_outlined,
                                                  size: 25,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })),
            ]),
          ),
        ));
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(35.0),
              child: Card(
                child: Row(
                  children: [
                    Image.asset(
                      filteredList[index]!.image,
                      width: 80,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .04,
                    ),
                    Column(
                      children: [
                        CustomText(text: filteredList![index]!.name!),
                        Row(
                          children: [
                            CustomText(
                              text:
                                  '${filteredList[index]!.price.toString()}LE',
                              color: Colors.red,
                            ),
                            Visibility(
                                visible: filteredList[index]!.haveDiscount,
                                child: CustomText(
                                  text:
                                      '${filteredList[index]!.couponDiscount + filteredList[index]!.price}LE',
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return ListView.builder(
          itemCount: medicines.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    showResults(context);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Image.asset(
                          medicines[index].image,
                          width: 60,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .04,
                        ),
                        CustomText(text: medicines[index].name),
                      ],
                    ),
                  ),
                ),
              ));
    } else {
      filteredList =
          medicines.where((element) => element.name.startsWith(query)).toList();
      return ListView.builder(
          itemCount: filteredList!.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    showResults(context);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Image.asset(
                          filteredList![index]!.image!,
                          width: 60,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .04,
                        ),
                        CustomText(text: filteredList![index]!.name),
                      ],
                    ),
                  ),
                ),
              ));
    }
  }
}
