import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';

import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/pages/home_page.dart';
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:be_bold/ui/widgets/info_pages/delete_button.dart';
import 'package:be_bold/ui/widgets/info_pages/description_box.dart';
import 'package:be_bold/ui/widgets/info_pages/edit_save_button.dart';
import 'package:be_bold/ui/widgets/info_pages/first_last_name_box.dart';
import 'package:be_bold/ui/widgets/info_pages/notes_box.dart';
import 'package:be_bold/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserInfoPage extends StatefulWidget {
  final UserModel? userModel;
  final bool isExisting;
  const UserInfoPage({Key? key, this.userModel, required this.isExisting})
      : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late TextEditingController notesController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;

  late FocusNode notesNode;
  late bool editPressed;
  UserStatus userStatus = UserStatus.witnessed;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editPressed = !widget.isExisting;
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    notesController = TextEditingController();
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    notesNode = FocusNode();
    if (widget.userModel != null) {
      firstNameController.text = widget.userModel?.firstName ?? "";
      lastNameController.text = widget.userModel?.lastName ?? "";

      notesController.text = widget.userModel?.notes ?? "";

      userStatus = widget.userModel?.userStatus ?? UserStatus.witnessed;
    }
  }

  bool _saveInfo() {
    if (formKey.currentState?.validate() ?? false) {
      try {
        UserModel user = UserModel(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: "",
            phone: "",
            address: "",
            userId: "",
            city: "",
            state: "",
            subscribeToNewsletter: false,
            userStatus: userStatus,
            creationDate: widget.userModel != null
                ? widget.userModel?.creationDate
                : DateTime.now(),
            zipcode: "",
            notes: notesController.text);
        BlocProvider.of<LivesChangedBloc>(context)
            .add(LivesChangedEventAddLive(model: user));
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
          title: "Notes",
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          showLogout: false,
        ),
        backgroundColor: Colors.grey[200],
        body: Form(
          key: formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    v_space_m,
                    Row(
                      children: [
                        DeleteButton(onTap: (){}),
                        const Spacer(flex:1),
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
                            }),
                      ],
                    ),
                    const DescriptionBox(),
                    FirstLastNameBox(
                        editPressed: editPressed,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        firstNameNode: firstNameNode,
                        lastNameNode: lastNameNode),
                    SizedBox(
                        height: 300,
                        child: NotesBox(
                            editPressed: editPressed,
                            notesController: notesController,
                            height: double.infinity,
                            notesNode: notesNode)),
                    Row(children: [
                      IconButton(
                          icon: userStatus == UserStatus.accepted
                              ? const Icon(
                                  Icons.check_circle,
                                  color: darkBlueColor1,
                                )
                              : const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            setState(() {
                              userStatus = (userStatus == UserStatus.witnessed ||
                                      userStatus == UserStatus.na)
                                  ? UserStatus.accepted
                                  : UserStatus.witnessed;
                            });
                          }),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                          child: Text(
                              "Does this person accept Jesus as their Savior?")),
                    ]),
                    
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
