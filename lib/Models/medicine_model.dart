class MedicineModel {
  String name ;
  double price ;
  String image ;
  double couponDiscount ;
  double shipping ;
  bool haveDiscount ;
  double quantity ;
  int? _id;

  int? get id => _id; 

  set id(int? value) {
    _id = value; 
  }

  MedicineModel({
    required this .name,
    required this.price,
    this.image ='images/placeholdermedicine.png',
    this.couponDiscount=0.0,
    this.shipping=0.0,
    this .haveDiscount =false,
    this .quantity =1 

  });

 factory MedicineModel.fromMap(Map<String, dynamic> data) => MedicineModel(
  name: data['name'] as String,
  price: (data['price'] as num?)?.toDouble() ?? 0.0, // Handle null price
  couponDiscount: (data['coupon discount'] as num?)?.toDouble() ?? 0.0,
  shipping: (data['shipping'] as num?)?.toDouble() ?? 0.0,
  haveDiscount: data['have discount'] as bool??false ,
  quantity: (data['quantity'] as num?)?.toDouble() ?? 1.0, // Handle null quantity
);

 Map<String, dynamic> toMap() => {
    'name': name,
    'price': price,
    'image': image,
    'couponDiscount': couponDiscount,
    'shipping': shipping,
    'haveDiscount': haveDiscount ? 1 : 0, // Convert bool to int (1 for true, 0 for false)
    'quantity': quantity,
  };

}