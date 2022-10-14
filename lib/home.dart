import 'package:contacts/database/database.dart';
import 'package:contacts/model/model.dart';
import 'package:flutter/material.dart';

import 'contact details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<Contact> contactList = [];

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: FutureBuilder<List<Contact>>(
            future: ContactProvider.instance.getBooks(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
              if (snapshot.hasData) {
                contactList = snapshot.data!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          'My Contacts',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 14.0,
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            Contact contact = contactList[index];
                            return Center(
                              child: ListTile(
                                subtitle: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      child: contact.url!.isEmpty ? Icon(
                                              Icons.person,
                                              size: 50,
                                            ) : null,
                                      backgroundImage: NetworkImage(contact.url!,),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${contact.name!}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      contact.number!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  await Navigator.of(context).push(
                                   await MaterialPageRoute(
                                      builder: (
                                        BuildContext context,
                                      ) =>
                                          ContactDetails(
                                        contact,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                            );
                          },
                          itemCount: contactList.length,
                        ),
                      ),
                    )
                  ],
                );
              }
              return Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () async {
            nameController.clear();
            numberController.clear();
            urlController.clear();
            await showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
              ),
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    height: 260,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Contact Name',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: numberController,
                              decoration: InputDecoration(
                                hintText: 'Contact Number',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: urlController,
                              decoration: InputDecoration(
                                hintText: 'Contact URL',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  setState(
                                    () {
                                      ContactProvider.instance.insert(
                                        Contact(
                                          name: nameController.text,
                                          number: numberController.text,
                                          url: urlController.text,
                                        ),
                                      );
                                    },
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'ADD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
