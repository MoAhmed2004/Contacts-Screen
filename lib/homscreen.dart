import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  static const routeName = "Home";

  @override
  State<Home> createState() => HomeState();
}
class Contact {
   String name;
   String phone;
   bool visible;

  Contact({required this.name, required this.phone, required this.visible});
}

class HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
   TextEditingController nameController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
  List<Contact> contacts = [
  ];

  void addContact() {
    if (formKey.currentState!.validate()) {
      setState(() {
        contacts.add(Contact(
          name: nameController.text,
          phone: phoneController.text,
          visible: true,
        ));
        nameController.clear();
        phoneController.clear();
      });
    }
  }

  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Center(child: Text('Contacts Screen', style: TextStyle(color:Colors.white ),)),
        backgroundColor: Colors.blue,
      ),
      body: Visibility(
        visible: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(

                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(Icons.edit, color: Colors.blue),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(Icons.phone, color: Colors.blue),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addContact,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Add', style: TextStyle(color: Colors.black)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(25),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Column(
                                  children: [
                                    Text('Name: ${contacts[index].name}',style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text('Phone: ${contacts[index].phone}',style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteContact(index),

                              ),
                                ],
                            ),
                          ]
                            ),
                        )
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}