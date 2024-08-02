

import 'package:crud/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
        children: [
          Text("Interns Details",style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),),
           
        ],
      )
      ),
      body: SingleChildScrollView(
        child: Container(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Name",style: TextStyle(color: Colors.black,fontSize:18,fontWeight: FontWeight.bold ),),
              SizedBox(height: 10,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(height: 30,),
              Text("Qualification",style: TextStyle(color: Colors.black,fontSize:18,fontWeight: FontWeight.bold ),),
              SizedBox(height: 10,),
              TextField(
                controller: qualificationController,
                decoration: InputDecoration(
                  hintText: "12th/Bachelore's Degree",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(height: 20,),
              Text("Skill You Have",style: TextStyle(color: Colors.black,fontSize:18,fontWeight: FontWeight.bold ),),
              SizedBox(height: 10,),
              TextField(
                controller: skillController,
                decoration: InputDecoration(
                  hintText: "Flutter,React,CSS",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(height:20),
              ElevatedButton(onPressed: () async{
                    String Id = randomAlphaNumeric(10);
                Map<String,dynamic> employeeinfo = {
                  "Name": nameController.text.toString(),
                  "Qualification": qualificationController.text.toString(),
                  "id" : Id,
                  "Skill You Have" :skillController.text.toString()
                };
                await DataBaseMethods().addEmployeeDetails(employeeinfo,Id).then((value){
                  Fluttertoast.showToast(
          msg: "Employee details has been adsded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
            );
                });
              }, child: Text("Add"))
              
          
            ],
          ),
        ),),
      ),
    );
  }
}