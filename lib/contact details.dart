import 'package:contacts/database/database.dart';
import 'package:flutter/material.dart';
import 'database/database.dart';
import 'model/model.dart';

class ContactDetails extends StatefulWidget {
  Contact? contact;

  ContactDetails(this.contact, {Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.contact!.name!;
    numberController.text = widget.contact!.number!;
    urlController.text = widget.contact!.url!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      'Contacts Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 120,
                  child: widget.contact!.url!.isEmpty ? Icon(
                    Icons.person,
                    size: 180,
                  ) : null,
                  backgroundImage: NetworkImage(widget.contact!.url!,),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                  controller: nameController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Number',
                  ),
                  controller: numberController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                  ),
                  controller: urlController,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Sava Contact',
                            ),
                            content: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                'Are you sure you want to save this contact ?',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (widget.contact!.id! != null) {
                                    await ContactProvider.instance.update(
                                        Contact(
                                            id: widget.contact!.id,
                                            name: nameController.text,
                                            number: numberController.text,
                                            url: urlController.text));
                                  }
                                  setState(() {});
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ), //saveButton
                SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Delete Contact',
                          ),
                          content: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                              'Are you sure you want to delete this contact ?',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (widget.contact!.id! != null) {
                                  await ContactProvider.instance
                                      .delete(widget.contact!.id!);
                                }
                                setState(() {});
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ), //DeleteButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
