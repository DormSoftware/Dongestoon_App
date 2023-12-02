import 'package:dongestoon/bloc/home/home_cubit.dart';
import 'package:dongestoon/models/user.dart';
import 'package:dongestoon/temp_data.dart';
import 'package:dongestoon/widget/group_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../widget/notification_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User user;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  void _onItemFocus(int index) {
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (BuildContext context, state) {
          if (state is UserLoginSuccess) {}
        },
        builder: (context, state) {
          if (state is UserLoginSuccess) {
            user = state.user;
            return mainHomeScreen();
          }
          return Container();
        },
      ),
    );
  }

  Widget mainHomeScreen() {
    Widget background() {
      return Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 282,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              height: double.maxFinite,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          background(),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.light_mode_outlined))
                      ],
                    ),
                  ),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(40), // Image radius
                      child: Image.asset('assets/images/blank-profile.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    getLevel(user.rank!),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 150,
                    child: ScrollSnapList(
                      initialIndex: 3,
                      reverse: true,
                      itemSize: 35,
                      onItemFocus: _onItemFocus,
                      itemCount: tempExpenseList.length,
                      key: sslKey,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              sslKey.currentState!.focusToItem(index);
                            },
                            child: notificationItem(tempExpenseList[index]));
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical:2),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "گروه هات",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(

                              itemCount: tempGroupList.length,
                              itemBuilder: (context, index) {
                                return groupItem(tempGroupList[index]);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String getLevel(int value) {
    switch (value) {
      case 0:
        return "مادر خرج اعظم";
      default:
        return "";
    }
  }
}