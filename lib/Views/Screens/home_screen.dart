import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_pharmacy/Core/offline%20DataBase/allowed_medicines.dart';
import 'package:smart_pharmacy/Models/medicine_model.dart';
import 'package:smart_pharmacy/Views/Screens/cart_screen.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_formfield.dart';
import 'package:smart_pharmacy/Views/Widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  addToCart(MedicineModel medicineModel){
    if(myCart.isEmpty){
setState(() {
    myCart.add(medicineModel);
    priceTotal+=medicineModel.price*medicineModel.quantity;
  });
    }else if (myCart.contains(medicineModel)){
      medicineModel.quantity+=1 ;
          priceTotal+=medicineModel.price*medicineModel.quantity;

    }
    else if (!(myCart.contains(medicineModel))){
      myCart.add(medicineModel);
          priceTotal+=medicineModel.price*medicineModel.quantity;

    }
    }

    
    
    

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.menu),
        ),
        centerTitle: true,
        title: Container(
          width: MediaQuery.of(context).size.width*.28,
          child: Stack(
            children: [
              Image.asset('images/logo 2.png',width: MediaQuery.of(context).size.width*.18,),
              Positioned(
                top: MediaQuery.of(context).size.height*.04,
                left: MediaQuery.of(context).size.width*.14,
                child: Image.asset('images/Logo (1).png',width: MediaQuery.of(context).size.width*.17,))
            ],
          ),
        ),
        actions: [
          GestureDetector (
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
            },
            child: Icon(Icons.shopping_cart_outlined)),
          Icon(Icons.notifications_none),
          SizedBox(width: MediaQuery.of(context).size.width*.05,)
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20,right: 30,left: 30,bottom: 10),
                child:GestureDetector(
                  onTap: (){
                    showSearch(context: context, delegate: Search());
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height*.06,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.search),
                          CustomText(text: 'Search For Pharmacy',color: Colors.grey,),
                        ],
                      ),
                    ),
                  ),
                ) ,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allowedMedicines.length,
                  itemBuilder: (context,index){
                    
                    
                  
                    return
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*.25,
                      height: MediaQuery.of(context).size.height*.10,
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(allowedMedicines[index].image,width: 60,),
                            SizedBox(width: MediaQuery.of(context).size.width*.09,),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: CustomText(text: allowedMedicines[index].name,fontWeight: FontWeight.w600,),
                                ),
                                Row(
                                  children: [
                                    CustomText(text: '${allowedMedicines[index].price.toString()}LE',color: Colors.red,fontSize: 15,fontWeight: FontWeight.w400,),
                                    Visibility(
                                      visible: allowedMedicines[index].haveDiscount,
                                      child: CustomText(text: '${allowedMedicines[index].couponDiscount+allowedMedicines[index].price}LE',decoration: TextDecoration.lineThrough,))
                                  ],
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: ()=>addToCart(allowedMedicines[index]),
                              child: Container(
                                height: MediaQuery.of(context).size.height*.05,
                                width: MediaQuery.of(context).size.width*.15,
                                child: Card(
                                  elevation: 1,
                                                                color: Colors.grey[200],
                              
                                  
                                  child: Icon(Icons.add_shopping_cart_outlined,size: 25,color: Colors.green,),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
  );}),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query='';
      }, icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
    
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.all(35.0),
        child: Card(
        child: Row(
          children: [
            Image.asset(filteredList[index]!.image,width: 80,),
                            SizedBox(width: MediaQuery.of(context).size.width*.04,),
            Column(
              children: [
                CustomText(text: filteredList![index]!.name!),
                Row(
                  children: [
                    CustomText(text: '${filteredList[index]!.price.toString()}LE',color: Colors.red,),
                    Visibility(
                      visible: filteredList[index]!.haveDiscount,
                      child: CustomText(text: '${filteredList[index]!.couponDiscount+filteredList[index]!.price}LE',color: Colors.grey,decoration: TextDecoration.lineThrough,))
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
    if (query==''){
       return ListView.builder(
      itemCount: allowedMedicines.length,
      itemBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: (){
            showResults(context);
          },
          child: Card(
            child: Row(
              children: [
                Image.asset(allowedMedicines[index].image,width: 60,),
                SizedBox(width: MediaQuery.of(context).size.width*.04,),
                CustomText(text: allowedMedicines[index].name),
              ],
            ),
          ),
        ),
      ));
    }else{
      filteredList=allowedMedicines.where((element) => element.name.startsWith(query)).toList();
      return ListView.builder(
      itemCount: filteredList!.length,
      itemBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: (){
            showResults(context);
          },
          child: Card(
            child: Row(
              children: [
                Image.asset(filteredList![index]!.image!,width: 60,),
                SizedBox(width: MediaQuery.of(context).size.width*.04,),
                CustomText(text: filteredList![index]!.name),
              ],
            ),
          ),
        ),
      ));

    }
   
    
  }
  
}