import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class WitnessBox extends StatelessWidget {
  final bool editPressed;
  final UserStatus userStatus;
  final Function onTap;
  const WitnessBox(
      {super.key,
      required this.editPressed,
      required this.userStatus,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0,
      child: SizedBox(
        height: 75,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                FontAwesome.cross_solid,
                color: const Color.fromRGBO(66, 66, 66, 1) ?? Colors.grey,
                size: 22,
              ),
              h_space_m,
              Expanded(
                child: /* editPressed
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
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
                                      onTap(userStatus);
                                      
                                      
                                    }),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Expanded(
                                    child: Text(
                                        "Does this person accept Jesus as their Savior?")),
                              ]),
                            ),
                          ),
                        ],
                      )
                    : */
                    Row(
                  children: [
                    const Text("Witness Status", style: personalInfoTextStyle),
                    const Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                      onTap: editPressed
                          ? () {
                              onTap(userStatus);
                            }
                          : null,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: userStatus == UserStatus.accepted
                                ? Colors.greenAccent
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                              userStatus == UserStatus.accepted
                                  ? "Accepted"
                                  : "Witnessed",
                              style: personalInfoTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
