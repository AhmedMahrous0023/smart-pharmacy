
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_pharmacy/Models/medicine_model.dart';




List<MedicineModel> medicines = [];

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<List<MedicineModel>> getMedicines() async {
  final snapshot = await firestore.collection('allowed_medicines').get();
 
  final medicineslist =await snapshot.docs.map((doc) => MedicineModel.fromMap(doc.data())).toList();
    
  medicines=medicineslist;
  print(medicines);
  return medicineslist ;

}

List<MedicineModel>myCart=[];
  double priceTotal=0.0 ;
  double totalDiscount =0.0 ;
  

 late List<MedicineModel?>filteredList ;
