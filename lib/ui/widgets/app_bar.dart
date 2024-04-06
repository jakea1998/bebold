import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final String? title;
  final bool? showLogout;
  final PreferredSizeWidget? bottom;
  const AppBar1({Key? key, required this.leading, this.title,this.showLogout = true, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: darkBlueColor1,
      leading: leading,
      centerTitle: true,
      actions: [
        showLogout?? true ? BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.userStatus == UserStatus.loaded &&
                (state.userExists ?? false)) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        BlocProvider.of<UserBloc>(context).add(
                            UserEventLogoutUser(
                                livesChangedBloc:
                                    BlocProvider.of<LivesChangedBloc>(
                                        context)));
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ) : Container()
      ],
      bottom: bottom != null ? bottom : null,
      title: title == null
          ? const Text(
              "BE BOLD",
              style: TextStyle(color: Colors.white),
            )
          : Text(
              title ?? "",
              style: const TextStyle(color: Colors.white),
            ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      title != null ? const Size.fromHeight(85) : const Size.fromHeight(55);
}
