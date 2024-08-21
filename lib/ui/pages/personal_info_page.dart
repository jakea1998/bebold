import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart' as model;
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:be_bold/ui/widgets/info_pages/address_box.dart';
import 'package:be_bold/ui/widgets/info_pages/edit_save_button.dart';
import 'package:be_bold/ui/widgets/info_pages/email_box.dart';
import 'package:be_bold/ui/widgets/info_pages/first_last_name_box.dart';
import 'package:be_bold/ui/widgets/info_pages/notes_box.dart';
import 'package:be_bold/ui/widgets/info_pages/phone_box.dart';
import 'package:be_bold/ui/widgets/info_pages/subscribe_to_newsletter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipController;
  late TextEditingController notesController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode emailNode;
  late FocusNode phoneNode;
  late FocusNode addressNode;
  late FocusNode cityNode;
  late FocusNode stateNode;
  late FocusNode zipNode;
  late FocusNode notesNode;
  bool signUpForNewsLetter = false;
  bool editPressed = false;
  model.UserStatus userStatus = model.UserStatus.na;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.firstName ??
            "");
    lastNameController = TextEditingController(
        text:
            BlocProvider.of<UserBloc>(context).state.userModel?.lastName ?? "");

    emailController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.email ?? "");
    phoneController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.phone ?? "");
    addressController = TextEditingController(
        text:
            BlocProvider.of<UserBloc>(context).state.userModel?.address ?? "");
    cityController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.city ?? "");
    stateController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.state ?? "");
    zipController = TextEditingController(
        text:
            BlocProvider.of<UserBloc>(context).state.userModel?.zipcode ?? "");
    notesController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.notes ?? "");
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    phoneNode = FocusNode();
    addressNode = FocusNode();
    cityNode = FocusNode();
    stateNode = FocusNode();
    zipNode = FocusNode();
    notesNode = FocusNode();
    signUpForNewsLetter = BlocProvider.of<UserBloc>(context)
            .state
            .userModel
            ?.subscribeToNewsletter ??
        false;
  }

  bool _saveInfo() {
    if (formKey.currentState?.validate() ?? false) {
      try {
        model.UserModel user = model.UserModel(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            phone: phoneController.text,
            address: addressController.text,
            userId:
                BlocProvider.of<UserBloc>(context).state.userModel?.userId ??
                    "",
            city: cityController.text,
            state: stateController.text,
            subscribeToNewsletter: signUpForNewsLetter,
            userStatus: userStatus,
            zipcode: zipController.text,
            creationDate: BlocProvider.of<UserBloc>(context)
                    .state
                    .userModel
                    ?.creationDate ??
                DateTime.now(),
            notes: notesController.text);
        BlocProvider.of<UserBloc>(context)
            .add(UserEventCreateUser(userModel: user));
      } catch (e) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(
          showLogout: false,
          title: "Personal Information",
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      backgroundColor: Colors.grey[200],
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      EditSaveButton(
                          editPressed: editPressed,
                          onTap: () {
                            if (editPressed) {
                              EasyLoading.show(status: 'Saving...');
                              final result = _saveInfo();
                              if (result) {
                                EasyLoading.dismiss();
                                
                                setState(() {
                                  editPressed = false;
                                });
                              } else {
                                EasyLoading.dismiss();
                                EasyLoading.showError(
                                    "Error saving user information.",
                                    dismissOnTap: true);
                              }
                            } else {
                              setState(() {
                                editPressed = true;
                              });
                            }
                          })
                    ],
                  ),
                  FirstLastNameBox(
                      editPressed: editPressed,
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      firstNameNode: firstNameNode,
                      lastNameNode: lastNameNode),
                  AddressBox(
                      editPressed: editPressed,
                      addressNode: addressNode,
                      cityNode: cityNode,
                      stateNode: stateNode,
                      addressController: addressController,
                      cityController: cityController,
                      stateController: stateController),
                  PhoneBox(
                      editPressed: editPressed,
                      phoneNode: phoneNode,
                      phoneController: phoneController),
                  EmailBox(email: emailController.text),
                  NotesBox(notesController: notesController,notesNode: notesNode,editPressed: editPressed,height: 150,),
                  
                  NewsletterSubscriptionBox(editPressed: editPressed, subscribed: signUpForNewsLetter, onTap: (subscribe){
                    setState(() {
                      signUpForNewsLetter = !subscribe;
                    });
                  })
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
