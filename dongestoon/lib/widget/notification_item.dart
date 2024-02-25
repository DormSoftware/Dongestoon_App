import 'package:delayed_display/delayed_display.dart';
import 'package:dongestoon/bloc/Home/home_cubit.dart';
import 'package:dongestoon/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/expense.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key, required this.expense, required this.index});

  final int index;
  final Expense expense;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool? isSelected;
 int? selectedIndex;
  //400
  var dur = const Duration(milliseconds: 300);

  @override
  void initState() {
    isSelected = false;
    context.read<HomeCubit>().fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is UserLoginSuccess) {
          isSelected = false;
        } else if (state is SelectNotification) {
          isSelected = true;
          selectedIndex = state.index;
        }
      },
      child: notificationItem(widget.expense),
    );
  }

  Widget notificationItem(Expense expense) {
    return GestureDetector(
      onTap: () {
        context
            .read<HomeCubit>()
            .selectNotificationItem(tempExpenseList.indexOf(widget.expense));
      },
      child: AnimatedPadding(
        duration: dur,
        padding: EdgeInsets.only(
          top: isSelected! ? 20.0 : 0.0,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //color: Colors.green,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: dur,
                            height: isSelected! ? 50 : 25,
                          ),
                          AnimatedContainer(
                            curve: Curves.easeInOutCirc,
                            duration: dur,
                            width: isSelected! ? 230 : 190,
                            height: isSelected! ? 350 : 98,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 20, 18, 24),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: isSelected!&&selectedIndex == widget.index
                                ? Stack(
                              children: [
                                DelayedDisplay(
                                  delay: const Duration(milliseconds: 190),
                                  slidingCurve: Curves.decelerate,
                                  child: selectedNotificationItem(expense),
                                ),
                              ],
                            )
                                : notSelectedItem(expense),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 63,
                ),
                AnimatedPadding(
                  duration: dur,
                  padding: EdgeInsets.only(left: isSelected! ? 60 : 60),
                  child: AnimatedContainer(
                    duration: dur,
                    curve: Curves.easeIn,
                    transformAlignment: Alignment.center,
                    width: isSelected! ? 100 : 50,
                    height: isSelected! ? 100 : 50,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        child: Image.asset(
                            'assets/images/avatar${expense.user.profileImage! + 1}.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedNotificationItem(Expense expense) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: dur,
                height: isSelected! ? 40.0 : 0.0,
              ),
              DelayedDisplay(
                delay: const Duration(milliseconds: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        endIndent: 16,
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
                        color: Colors.grey,
                        indent: 16.0,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DelayedDisplay(
                delay: const Duration(milliseconds: 40),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Flex(direction: Axis.vertical, children: [
                                  Text(
                                    "نام کالا",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey[600]),
                                  ),
                                ]),
                                Text(
                                  expense.name,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  "دسته بندی",
                                  style:
                                  TextStyle(fontSize: 10, color: Colors.grey[600]),
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
                      const SizedBox(
                        height: 16,
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 160),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Container(
                                    height: 85,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 40, 37, 44),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 40, 37, 44),
                                      ),
                                    ),
                                    //color: Color.fromARGB(255, 40, 37, 44),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 4),
                                height: 27,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 169, 233, 242),
                                  borderRadius: BorderRadius.circular(45),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 169, 233, 242),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "توضیحات",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DelayedDisplay(
                        delay: Duration(milliseconds: 200),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 85,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 40, 37, 44),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                onPressed: () {},
                                child: const Text(
                                  "پرداخت",
                                  style: TextStyle(color: Colors.white,fontSize: 12),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "قیمت",
                                  style:
                                  TextStyle(fontSize: 10, color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  expense.amount.toInt().toString(),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.redAccent),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget notSelectedItem(Expense expense) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            expense.category,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                expense.amount % 10 == 0
                    ? expense.amount.toInt().toString()
                    : expense.amount.toString(),
                style: const TextStyle(color: Colors.redAccent, fontSize: 13),
              ),
              Text(
                getPassedTime(expense.date),
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }

  String getPassedTime(DateTime date) {
    return "سه روز پیش";
  }
}
