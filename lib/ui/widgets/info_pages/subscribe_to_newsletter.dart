import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class NewsletterSubscriptionBox extends StatelessWidget {
  final bool editPressed;
  final bool subscribed;
  final Function onTap;
  const NewsletterSubscriptionBox(
      {super.key,
      required this.editPressed,
      required this.subscribed,
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
              const Icon(
                FontAwesome.newspaper,
                color: Color.fromRGBO(66, 66, 66, 1),
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
                    const Text("Newsletter Status", style: personalInfoTextStyle),
                    const Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                      onTap: editPressed
                          ? () {
                              onTap(subscribed);
                            }
                          : null,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: subscribed
                                ? Colors.greenAccent
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                              subscribed
                                  ? "Subscribed"
                                  : "Subscribe",
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
