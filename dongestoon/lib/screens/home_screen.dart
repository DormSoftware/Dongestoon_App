import 'dart:ui';
import 'package:dongestoon/bloc/Home/home_cubit.dart';
import 'package:dongestoon/models/expense.dart';
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
  User user = User(id: "id", name: "name", rank: 0);
  var itemSelected = false;
  int? selectedIndex;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _onItemFocus(int index) {
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (BuildContext context, state) {
          if (state is UserLoginSuccess) {
            user = state.user;
            itemSelected = false;
          } else if (state is SelectNotification) {
            itemSelected = true;
            selectedIndex = state.index;
          }
        },
        builder: (context, state) {
          return mainHomeScreen();
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
                  /*SizedBox(
                    height: 150,
                    child: ScrollSnapList(
                      reverse: true,
                      itemSize: 185,
                      onItemFocus: _onItemFocus,
                      itemCount: tempExpenseList.length,
                      key: sslKey,
                      itemBuilder: (context, index) {
                        return NotificationItem(
                          expense: tempExpenseList[index],
                        );
                      },
                    ),
                  ),*/
                ],
              ),
              const SizedBox(
                height: 130,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 6, bottom: 6),
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
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          itemSelected
              ? GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().fetchUserData();
                  },
                  child: generateBlurredImage(),
                )
              : const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: itemSelected ? 100 : 210,
              ),
              itemSelected
                  ? selectedNotificationItem(tempExpenseList[selectedIndex!])
                  : SizedBox(
                      height: 400,
                      child: ScrollSnapList(
                        reverse: true,
                        itemSize: 185,
                        onItemFocus: _onItemFocus,
                        itemCount: tempExpenseList.length,
                        key: sslKey,
                        itemBuilder: (context, index) {
                          return NotificationItem(
                            expense: tempExpenseList[index],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectedNotificationItem(Expense expense) {
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 225,
                height: 360,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 20, 18, 24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            endIndent: 10.0,
                            thickness: 0.5,
                          ),
                        ),
                        Text(
                          expense.user.name,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 169, 233, 242),
                              fontWeight: FontWeight.bold),
                        ),
                        const Expanded(
                          child: Divider(
                            indent: 10.0,
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(45), // Image radius
              child: Image.asset('assets/images/blank-profile.jpg',
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget generateBlurredImage() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 9.0, sigmaY: 9.0),
      child: Container(
        //you can change opacity with color here(I used black) for background.
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
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
