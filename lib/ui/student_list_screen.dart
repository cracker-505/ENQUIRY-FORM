import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:studentdetails/const/style.dart';
import 'package:studentdetails/toast/toastmessage.dart';
import 'package:studentdetails/ui/registration_student.dart';
import 'package:studentdetails/ui/student_details.dart';
import 'package:firebase_database/firebase_database.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final fetch = FirebaseDatabase.instance.ref('Student_Details');
  TextEditingController searchFilter = TextEditingController();
  TextEditingController editController = TextEditingController();
  String MyKey = 'my_data';
  Map<String, dynamic> getd = {};
  var color = Colors.white;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("Student List Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 3,
                  color: Colors.blue,
                ))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    controller: searchFilter,
                    decoration: InputDecoration(
                        hintText: 'search', border: InputBorder.none),
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: FirebaseAnimatedList(
                  query: fetch,
                  shrinkWrap: true,
                  defaultChild: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          child: Text(
                            'Loading......',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (context, DataSnapshot, animation, index) {
                    final indexNumber = index + 1;
                    final name = DataSnapshot.child('name').value.toString();
                    final email = DataSnapshot.child('email').value.toString();
                    final mobile =
                        DataSnapshot.child('mobile').value.toString();
                    final className =
                        DataSnapshot.child('classV').value.toString();
                    final DoB = DataSnapshot.child('DoB').value.toString();
                    final gender =
                        DataSnapshot.child('selectGender').value.toString();
                    if (searchFilter.text.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new StudentDetails(
                                                    name: name,
                                                    email: email,
                                                    mobile: mobile,
                                                    className: className,
                                                    DoB: DoB,
                                                    gender: gender)));
                                  },
                                  leading: CircleAvatar(
                                    radius: 18,
                                    child: Text("${indexNumber}"),
                                  ),
                                  title: Container(
                                    height: 20,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      email,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  trailing: Container(
                                    child: InkWell(
                                      onTap: () {
                                              fetch
                                                  .child(DataSnapshot.child('id')
                                                      .value
                                                      .toString())
                                                  .remove()
                                                  .then((value) {
                                                ToastMessage().toastMsg(
                                                    "${name} details has been remove");
                                              });
                                            },
                                        child: Icon(Icons.delete,color: blueColor,size: 32,)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchFilter.text.toLowerCase())) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            new StudentDetails(
                                                name: name,
                                                email: email,
                                                mobile: mobile,
                                                className: className,
                                                DoB: DoB,
                                                gender: gender)));
                                  },
                                  leading: CircleAvatar(
                                    radius: 18,
                                    child: Text("${indexNumber}"),
                                  ),
                                  title: Container(
                                    height: 20,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      email,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  trailing: Container(
                                    child: InkWell(
                                        onTap: () {
                                          fetch
                                              .child(DataSnapshot.child('id')
                                              .value
                                              .toString())
                                              .remove()
                                              .then((value) {
                                            ToastMessage().toastMsg(
                                                "${name} details has been remove");
                                          });
                                        },
                                        child: Icon(Icons.delete,color: blueColor,size: 32,)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            //removeData();
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()));
        },
      ),
    );
  }
}
