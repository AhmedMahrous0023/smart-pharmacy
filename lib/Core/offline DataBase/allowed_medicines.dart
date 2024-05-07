
import 'package:smart_pharmacy/Models/medicine_model.dart';

List<MedicineModel>allowedMedicines=[
  MedicineModel(name: 'congestal', price: 19.00),
    MedicineModel(name: 'panadol', price: 9.00,couponDiscount: 10.00,haveDiscount: true),
  MedicineModel(name: 'comtrics', price: 16.00),
  MedicineModel(name: 'voltarine', price: 19.00),
  MedicineModel(name: 'concor', price: 19.00),
  MedicineModel(name: 'bronchkim', price: 19.00),
  MedicineModel(name: 'asophortine', price: 19.00),
  MedicineModel(name: 'sugar free gold', price: 25.00),



];

List<MedicineModel>myCart=[];
  double priceTotal=0.0 ;

 late List<MedicineModel?>filteredList ;
