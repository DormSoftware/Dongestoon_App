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
  var isSelected = false;
  int? selectedIndex;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  var dur = const Duration(milliseconds: 1000);

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
            isSelected = false;
          } else if (state is SelectNotification) {
            isSelected = true;
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
                      child: Image.asset('assets/images/avatar1.png',
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
          isSelected
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
              AnimatedContainer(
                duration: dur,
                height: isSelected ? 100 : 210,
              ),
              AnimatedContainer(
                curve: Curves.ease,
                transformAlignment: Alignment.center,
                duration: Duration(milliseconds: 1300),
                height: isSelected ? 500 : 140,
                width: isSelected ? 400 : MediaQuery.of(context).size.width,
                child: ScrollSnapList(
                  itemSize: isSelected ? 235 :  185,
                  onItemFocus: _onItemFocus,
                  itemCount: isSelected ? 1 : tempExpenseList.length,
                  //dynamicItemSize: true,
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(
                   // left: isSelected ? 50 : 0,
                  ),
                  key: sslKey,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      expense: isSelected ? tempExpenseList[selectedIndex!] : tempExpenseList[index],
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
                height: 45,
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
                            color: Colors.grey,
                            endIndent: 14.0,
                            thickness: 0.1,
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
                            color: Colors.grey,
                            indent: 14.0,
                            thickness: 0.1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "نام کالا",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600]),
                              ),
                              Text(
                                expense.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "دسته بندی",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[600]),
                              ),
                              Text(
                                expense.category,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
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
