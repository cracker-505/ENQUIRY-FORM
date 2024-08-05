import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:studentdetails/toast/toastmessage.dart';
import 'package:studentdetails/ui/student_list_screen.dart';
import '../button/RoundButton.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Student_Details');

  Map<String, dynamic> std_details = {};
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final EmailController = TextEditingController();
  final NumController = TextEditingController();
  var classValue;
  var gender;
  var num;
  var namee;
  String MyKey = 'my_data';
  DateTime currentDate= DateTime.now();
  String selectedDoB = "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";
  datePicker(context) async{
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if(userSelectedDate == null){
      return;
    }
    else{
      setState(() {
        currentDate = userSelectedDate;
        selectedDoB = "${currentDate.day}/${currentDate.month}/${currentDate.year}";
      });
    }
  }
  bool loading = false;
  @override
  void initState(){
   super.initState();
   nameController.clear();
   EmailController.clear();
   NumController.clear();
   selectedDoB.isEmpty;
  }
  Future<void> saveData(Map<String, dynamic> std_details) async {
    final jsonData = jsonEncode(std_details);
   // await prefs.setString(MyKey, jsonData);
  }
  Future<void> getData(Map<String, dynamic> getd) async {
   //var jsonString = prefs.getString(MyKey) ?? '{}';
   setState(() {
    // getd = jsonDecode(jsonString);
   });
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:Text("Student Registraion Screen"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Student Name",
                      focusColor: Colors.deepPurple,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Student Name";
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: EmailController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Student Email Adress",
                      hoverColor: Colors.deepPurple,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if((value!.isEmpty)){
                        return "Enter Student Email";
                      }
                      if(value == RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(EmailController.text.toString())){
                        return 'valid mail';
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: NumController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Student Mobile No.",
                      focusColor: Colors.deepPurple,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Student Mobile Number";
                      }
                      if(value.length !=10) {
                        return "Enter 10 digit mobile number";
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                        label: Text("Class",style:  TextStyle(fontSize:20)),
                        prefixIcon:Icon(Icons.adb_rounded),
                      ),
                      value: classValue,
                      items:["X","XI","XII"].map(
                              (classValue) => DropdownMenuItem(
                                value: classValue,
                              child: Text(classValue)
                          )).toList(),
                      onChanged: (value){
                        setState(() {
                          classValue = value;
                        });
                      },
                      validator: (value) => value == null ? 'Select Student Class' : null,
                      ),
                  const SizedBox(height: 20,),

                  const SizedBox(height: 20,),
                  Row(
                      children: [
                        const Center(
                          child: Text(
                            "Date Of Birth : ",
                            style: const TextStyle(fontSize:16),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text("${currentDate.day}/${currentDate.month}/${currentDate.year}",
                          style: const TextStyle(fontSize:16,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 30,),
                        ElevatedButton(
                            onPressed: (){
                              datePicker(context);
                            },
                            child:Icon(Icons.calendar_month),
                        ),

                      ]),
                  const SizedBox(height: 20,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      label: Text("Gender"),
                      prefixIcon: Icon(Icons.accessibility_new_outlined)
                    ),
                      value: gender,
                      items: ["Male" ,"Female","Trans"].map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                  child: Text(gender))).toList(),
                      onChanged: (value){
                      setState(() {
                        gender  = value;
                      });
                      },
                      validator: (value) => value == null ? 'Select Student Gender' : null,
                      ),
                  const SizedBox(height: 60,),
                  RoundButton(
                    title: "Submit",
                    loading: loading,
                    onTap: ()async {
                      setState(() {
                        loading = false;
                      });
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        
                       String id = DateTime.now().millisecondsSinceEpoch.toString();
                       await ref.child(id).set(
                            {
                              'id': id.toString(),
                              'name': nameController.text.toString(),
                              'email': EmailController.text.toString(),
                              'mobile': NumController.text.toString(),
                              'DoB': selectedDoB.toString(),
                              'classV': classValue.toString(),
                              'selectGender': gender.toString(),
                            }
                        ).then((value) async{
                          setState(() {
                            loading = false;
                            nameController.clear();
                            EmailController.clear();
                            NumController.clear();
                            selectedDoB.isEmpty;
                          });
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentList()));
                          ToastMessage().toastMsg("Record has Submited");
                       });
                      };
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}