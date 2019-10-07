import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContact;
  bool _userEdited=false;
  
  final _nameController = TextEditingController(), _emailController = TextEditingController(), 
        _phoneController = TextEditingController();
  final _nameFocus = FocusNode();
  @override
  void initState() async{
    super.initState();
    
    if(widget.contact == null){
      _editedContact = Contact();
    }
    else{
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
      
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedContact.name??"Novo contato"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedContact.name!=null && _editedContact.name.isNotEmpty){
            Navigator.pop(context,_editedContact );
          }else{
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, 
                          image: DecorationImage(
                            image: _editedContact.img != null ? FileImage(File(_editedContact.img)) : Icon(Icons.person)
                          )
                        ),
                      ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nome"
              ),
              onChanged: (text){
                _userEdited=true;
                setState(() {
                  _editedContact.name=text;
                });
              },
              focusNode: _nameFocus,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email"
              ),
              onChanged: (text){
                _userEdited=true;
                _editedContact.email=text; 
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone"
              ),
              onChanged: (text){
                _userEdited=true;
                _editedContact.phone=text; 
              },
              keyboardType: TextInputType.phone,
            )
          ],
        ),
      ),
    );
  }
}