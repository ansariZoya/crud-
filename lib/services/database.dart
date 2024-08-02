

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{
  Future addEmployeeDetails(Map<String,dynamic> employeeinfo,String id) async {
   return  await FirebaseFirestore.instance.collection("Emplyee").doc(id).set(employeeinfo);
  }

  Future<Stream<QuerySnapshot>> getEmployeedetails() async{
   return await FirebaseFirestore.instance.collection("Emplyee").snapshots();
  }

  Future updateEmployeeDetails(String id, Map<String,dynamic> updateInfo) async{
    return await FirebaseFirestore.instance.collection("Emplyee").doc(id).update(updateInfo);
  }

  Future deleteEmployeeDetails(String id) async {
    return await FirebaseFirestore.instance.collection("Emplyee").doc(id);
  }
}