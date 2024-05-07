class MedicineModel {
  String name ;
  double price ;
  String image ;
  double couponDiscount ;
  double shipping ;
  bool haveDiscount ;
  double quantity ;

  MedicineModel({
    required this .name,
    required this.price,
    this.image ='images/placeholdermedicine.png',
    this.couponDiscount=0.0,
    this.shipping=0.0,
    this .haveDiscount =false,
    this .quantity =1 

  });
}