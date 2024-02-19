import 'package:dongestoon/block/home/home_cubit.dart';
import 'package:dongestoon/helper/connect_to_backend.dart';
import 'package:dongestoon/models/group.dart';
import 'package:dongestoon/models/user.dart';
import 'package:dongestoon/temp_data.dart';
import 'package:dongestoon/widget/group_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:glass/glass.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../widget/notification_item.dart';

//todo sliver listview
//todo font vaziri
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user = User(
      id: "id",
      name: "name",
      rank: 0,
      userName: '',
      lastName: '',
      email: '',
      password: '');
  var isSelected = false;
  int? selectedIndex;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  var dur = const Duration(milliseconds: 1000);
  var connection = BackendConnection();

  @override
  void initState() {
    super.initState();
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
                          icon: const Icon(
                            Icons.light_mode_outlined,
                          ),
                        ),
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
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                var user = User(
                                    userName: "مهدی",
                                    name: "مهدی",
                                    lastName: "مظاهری",
                                    email: "mahdiM@gmail.com",
                                    password: "1234");
                                var test = await connection.register(user);
                                print(test.body);
                                print(test.statusCode);
                              },
                              icon:
                                  const Icon(Icons.insert_drive_file_outlined),
                            ),
                            IconButton(
                              onPressed: () async {
                                var test =
                                    await connection.login("userName", "pass");
                                print(test.body);
                                print(test.statusCode);
                              },
                              icon: const Icon(Icons.login),
                            ),
                            IconButton(
                              onPressed: () async {
                                var group = Group(name: "اتاق ۱۱۴", userList: [
                                  "d6ba23a1-9823-4ab3-aeb8-01f1c257a429"//admin
                                      "7e5e9ed0-5f26-4caa-a8a1-34399acbc4bd"//mobin
                                      "5bf60df2-9823-417f-b071-62a5fa9ec1f5"//mahdi
                                ]);
                                var test = await connection.addGroup(group);
                                print(test.body);
                                print(test.statusCode);
                              },
                              icon: const Icon(Icons.group_add),
                            ),
                          ],
                        ),
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
                              return groupItem(tempGroupList[index],context);
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
                //color: Colors.blue,
                curve: Curves.easeOutCirc,
                duration: const Duration(milliseconds: 900),
                height: isSelected ? 100 : 210,
              ),
              AnimatedContainer(
                //color: Colors.red,
                curve: Curves.linear,
                transformAlignment: Alignment.center,
                duration: Duration(milliseconds: isSelected ? 100 : 600),
                height: isSelected ? 500 : 130,
                width: isSelected ? 400 : MediaQuery.of(context).size.width,
                child: FlutterCarousel(
                  options: CarouselOptions(
                    height: 500.0,
                    showIndicator: false,
                    disableCenter: true,
                    // decrease
                    viewportFraction: isSelected ? 2 : 0.6,
                    //height: MediaQuery.of(context).size.height * 0.45,
                    slideIndicator: const CircularSlideIndicator(),
                  ),
                  items: tempExpenseList.map((e) {
                    return NotificationItem(
                      expense: /*isSelected ? tempExpenseList[selectedIndex!] :*/
                          e,
                      index: selectedIndex ?? -1,
                    );
                  }).toList(),
                  /*ScrollSnapList(
                  itemSize: isSelected ? 235 : 200,
                  onItemFocus: _onItemFocus,
                  itemCount: */ /*isSelected ? 1 : */ /*tempExpenseList.length,
                  curve: Curves.linear,
                  margin: const EdgeInsets.only(
                      // left: isSelected ? 50 : 0,
                      ),
                  key: sslKey,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      expense: isSelected
                          ? tempExpenseList[selectedIndex!]
                          : tempExpenseList[index],
                    );
                  },
                ),*/
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget generateBlurredImage() {
    return Container().asGlass(tintColor: Colors.black26, frosted: false);
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
