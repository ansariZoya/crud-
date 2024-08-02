

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/pages/employee.dart';
import 'package:crud/services/database.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  
  TextEditingController nameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  @override

  Stream?  EmployeeStream;
  getOntheLoad() async{
   EmployeeStream = await DataBaseMethods().getEmployeedetails();
   setState(() {
     
   });
  }
   @override
  void initState(){
    getOntheLoad();
   super.initState();
  }
  Widget allEmployeeDetails(){
    return StreamBuilder(
      stream: EmployeeStream,
      builder: (context, AsyncSnapshot  snapshot){
      return snapshot.hasData? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context,index){
        DocumentSnapshot ds = snapshot.data.docs[index];
        return 
        Material(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                 
                  children: [
                    Text("Name: "+ds["Name"],style: TextStyle(fontSize:20,color: Colors.blue),),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        //
                        EditEmployeedetails(ds["id"]);
                      },
                      child: Icon(Icons.edit)),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: ()async{
                              await DataBaseMethods().deleteEmployeeDetails(ds["id"]);
                        },
                        child: Icon(Icons.delete))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Qualification: "+ds["Qualification"],style: TextStyle(fontSize:20,color: Colors.orange) ),
                    
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("skill you have: "+ds["Skill You Have"],style: TextStyle(fontSize:20,color: Colors.orange) ),
                   
                  ],
                ),
                

              ],
            ),
          ),
        );
      }): Container();
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> EmployeePage()));
      },child: Icon(Icons.add),),
      appBar: AppBar(title: Row(
        children: [
          Text("CRUD APP",style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),),
            Text("(Bright Infonet)",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),),
      body: Container(child: Column(
        children: [
          Expanded(child: allEmployeeDetails()),
        ],
      )),
    );
  }
  Future EditEmployeedetails(String id) => showDialog(context: context, builder: (context)=> AlertDialog(
    content: Container(
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel)),
                SizedBox(width: 20,)
                ,Text("Edit",
                style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),
                Text("Details",
                style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold))
            ],
          ),
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
                Map<String,dynamic> updateInfo = {
                  "Name": nameController.text,
                  "Qualification": qualificationController.text,
                  "Skill You Have":skillController.text
                }; await DataBaseMethods().updateEmployeeDetails(id, updateInfo).then((value){
                  Navigator.pop(context);
                });
              }
              , child: Text("Update"))
              
          
            ],
          
          
        
        ),
      ),
    )
  ));
}