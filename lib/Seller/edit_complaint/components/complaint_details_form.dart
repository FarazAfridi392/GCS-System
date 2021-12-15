
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/components/default_button.dart';
import 'package:e_shop/models/address.dart';
import 'package:e_shop/models/complaints.dart';
import 'package:e_shop/services/database/user_database_helper.dart';
import 'package:e_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:string_validator/string_validator.dart';
import '../../../constants.dart';

class ComplaintDetailsForm extends StatefulWidget {
  final Complaint complaintToEdit;
  ComplaintDetailsForm({
    Key key,
    this.complaintToEdit,
  }) : super(key: key);

  @override
  _ComplaintDetailsFormState createState() => _ComplaintDetailsFormState();
}

class _ComplaintDetailsFormState extends State<ComplaintDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleFieldController = TextEditingController();

  final TextEditingController receiverFieldController = TextEditingController();

  final TextEditingController reason =
      TextEditingController();

  

  final TextEditingController address = TextEditingController();

  

  final TextEditingController phoneFieldController = TextEditingController();

  @override
  void dispose() {
    titleFieldController.dispose();
    receiverFieldController.dispose();
    reason.dispose();
    
    address.dispose();
    
    phoneFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          buildTitleField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReceiverField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressLine1Field(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressLine2Field(),
          SizedBox(height: getProportionateScreenHeight(30)),
          
          buildPhoneField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Save Complaint",
            press: widget.complaintToEdit == null
                ? saveNewComplaintButtonCallback
                : saveEditedComplaintButtonCallback,
          ),
        ],
      ),
    );
    if (widget.complaintToEdit != null) {
      titleFieldController.text = widget.complaintToEdit.title;
      receiverFieldController.text = widget.complaintToEdit.receiver;
      reason.text = widget.complaintToEdit.reason;
      
      address.text = widget.complaintToEdit.address;
      
      phoneFieldController.text = widget.complaintToEdit.phone;
    }
    return form;
  }

  Widget buildTitleField() {
    return TextFormField(
      controller: titleFieldController,
      keyboardType: TextInputType.name,
      maxLength: 20,
      decoration: InputDecoration(
        hintText: "Enter a title for complaint",
        labelText: "Title",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (titleFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildReceiverField() {
    return TextFormField(
      controller: receiverFieldController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "Enter Full Name of Receiver",
        labelText: "Receiver Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (receiverFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildAddressLine1Field() {
    return TextFormField(
      controller: reason,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        hintText: "Enter Reason for your return",
        labelText: "Reason for Return",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (reason.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildAddressLine2Field() {
    return TextFormField(
      controller: address,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        hintText: "Enter Address",
        labelText: "Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (address.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  

  Widget buildPhoneField() {
    return TextFormField(
      controller: phoneFieldController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "Enter Phone Number",
        labelText: "Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (phoneFieldController.text.isEmpty) {
          return FIELD_REQUIRED_MSG;
        } else if (phoneFieldController.text.length != 10) {
          return "Only 10 Digits";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> saveNewComplaintButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final Complaint newComplaint = generateComplaintObject();
      bool status = false;
      String snackbarMessage;
      try {
        status =
            await UserDatabaseHelper().addComplaintForCurrentUser(newComplaint);
            // await UserDatabaseHelper().addComplaint(newComplaint);
        if (status == true) {
          snackbarMessage = "Complaint saved successfully";
        } else {
          throw "Coundn't save the address due to unknown reason";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = "Something went wrong";
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = "Something went wrong";
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }
  }

  Future<void> saveEditedComplaintButtonCallback() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final Complaint newComplaint =
          generateComplaintObject(id: widget.complaintToEdit.id);

      bool status = false;
      String snackbarMessage;
      try {
        status =
            await UserDatabaseHelper().updateComplaintForCurrentUser(newComplaint);
        if (status == true) {
          snackbarMessage = "Complaint updated successfully";
        } else {
          throw "Couldn't update address due to unknown reason";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = "Something went wrong";
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = "Something went wrong";
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }
  }

  Complaint generateComplaintObject({String id}) {
    return Complaint(
      id: id,
      title: titleFieldController.text,
      receiver: receiverFieldController.text,
      reason: reason.text,
      address: address.text,
      
      phone: phoneFieldController.text,
    );
  }
}
