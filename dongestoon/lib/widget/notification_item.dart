
import 'package:dongestoon/bloc/Home/home_cubit.dart';
import 'package:dongestoon/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/expense.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key, required this.expense});

  final Expense expense;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool? isSelected;
  var dur = const Duration(milliseconds: 400);

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
          top: isSelected! ? 35.0 : 0.0,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: dur,
                          height: isSelected! ? 50 : 25,
                        ),
                        AnimatedContainer(
                          curve: Curves.easeInOutCirc,
                          duration: dur,
                          width: isSelected! ? 240 : 200,
                          height: isSelected! ? 360 : 98,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 20, 18, 24),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: isSelected!
                                ? selectedNotificationItem(expense)
                                : notSelectedItem(expense),
                          ),
                        ),
                      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: dur,
          height: isSelected! ? 40.0 : 0.0,
        ),
        /*Row(
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
        const SizedBox(
          height: 20.0,
        ),
        AnimatedPadding(
          duration: dur,
          padding: EdgeInsets.symmetric(horizontal: isSelected! ? 18 : 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "نام کالا",
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
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
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
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
        ),*/
      ],
    );
  }

  Widget notSelectedItem(Expense expense) {
    return Row(
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
    );
  }

  String getPassedTime(DateTime date) {
    return "سه روز پیش";
  }
}
