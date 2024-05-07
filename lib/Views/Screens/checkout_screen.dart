import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Constants/constants.dart';
import 'package:smart_pharmacy/Core/offline%20DataBase/allowed_medicines.dart';
import 'package:smart_pharmacy/Views/Screens/success_checkout_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
    String _selectedLocation = 'Office';
    String?_cashDelivery ='cash on delivery' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'CheckOut',fontWeight: FontWeight.bold,),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: '${myCart.length} items in your Cart',color: Colors.grey,),
                                      Column(
                                        children: [
                                          CustomText(text: 'Total',color: Colors.grey,),
                                                              CustomText(text: '${priceTotal.toString()}LE',fontWeight: FontWeight.w600,),
              
                                        ],
                                      ),
              
                 
              
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomText(text: 'Delivery Address',fontWeight: FontWeight.w800,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(value: 'home', groupValue: _selectedLocation, onChanged: (String? value){
                          setState(() {
                            _selectedLocation=value! ;
                          });
                        }),
                        CustomText(text: 'Home'),
                        IconButton(onPressed: (){}, icon: Icon(Icons.edit_location_alt_outlined))
                      ],
                    ),
                    Center(child: CustomText(text: '(205) 555-024 \n 1786 Wheeler Bridge',maxLines: 2,),)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(value: 'office', groupValue: _selectedLocation, onChanged: (String? value){
                          setState(() {
                            _selectedLocation=value! ;
                          });
                        }),
                        CustomText(text: 'Office'),
                        IconButton(onPressed: (){}, icon: Icon(Icons.edit_location_alt_outlined))
                      ],
                    ),
                    Center(child: CustomText(text: '(205) 555-024 \n 1786 w Dallas St underfield ',maxLines: 2,),)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
            ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(text: 'Cash On Delivery',fontWeight: FontWeight.bold,),
                                  Radio(value: 'cash on delivery', groupValue: _cashDelivery, onChanged: (String ?value){
                                    setState(() {
                                      _cashDelivery=value!;
                                      
                                    });
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                             padding: const EdgeInsets.all(25.0),
                             child: ElevatedButton(
                              onPressed: (){
                             Navigator.push(context,  MaterialPageRoute(builder: (context)=>SuccessCheckoutScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: LinearBorder(), backgroundColor:greenColor,
                                  foregroundColor: Colors.white,
                                  fixedSize: Size(MediaQuery.of(context).size.width*.80, MediaQuery.of(context).size.height*.072)),
                              child: CustomText(text: 
                                 'Pay Now',color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold,
                              )),
                           ),
          ],
        ),
      ),
    );
  }
}