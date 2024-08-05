import 'package:flutter/material.dart';
import 'package:studentdetails/const/style.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails(
      {Key? key,
      required this.name,
      required this.email,
      required this.mobile,
      required this.className,
      required this.DoB,
      required this.gender})
      : super(key: key);

  String name = "";
  String email = "";
  String mobile = "";
  String className = "";
  String DoB = "";
  String gender = '';

  //call function
  void call() async {
    Uri url = Uri(scheme: 'tel', path: '$mobile');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Can't launch call";
    }
  }

  //mail function

  void mail() async {
    Uri url = Uri(scheme: 'mailto', path: "$email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Can't launch mail";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(80),bottomLeft:Radius.circular(80)),
                    color: Colors.amber,
                  ),
                ),
                Center(child: Text("Enquiry Form")),

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.only(top:10 ),
                  height:350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Name",style: boldStyle,),
                          Text("Mail Id",style: boldStyle,),
                          Text("Mobile No.",style: boldStyle,),
                          Text("Class Name",style: boldStyle,),
                          Text("DOB",style: boldStyle,),
                          Text("Gender",style: boldStyle,)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(":" ,style: lightStyle,),
                          Text(":",style: lightStyle,),
                          Text(":",style: lightStyle,),
                          Text(":",style: lightStyle,),
                          Text(":",style: lightStyle,),
                          Text(":",style: lightStyle,)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width:160,
                              child: Text(name,style: lightStyle,)),
                          InkWell(
                            onTap: ()=>mail(),
                            child: Container(
                                width:160,
                                child: Text(email,style: lightStyle,)),
                          ),
                          InkWell(
                            onTap: ()=>call(),
                              child: Text(mobile,style: lightStyle,)),
                          Text(className,style: lightStyle,),
                          Text(DoB,style: lightStyle,),
                          Text(gender,style: lightStyle,)
                        ],
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      )
    );
  }
}
