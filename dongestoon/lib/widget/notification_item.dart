import 'dart:ui';
import 'package:dongestoon/bloc/Home/home_cubit.dart';
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
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is UserLoginSuccess){
          isSelected = false;
        }
        else if (state is SelectNotification) {
          isSelected = true;
        }
      },
      child: Stack(
        children: [
          notificationItem(widget.expense),
        ],
      ),
    );
  }

  Widget notificationItem(Expense expense) {
    var itemWidth = isSelected ? 170.0 : 225.0;
    var itemHeight = isSelected ? 98.0 : 360.0;
    return GestureDetector(
      onTap: () {
        isSelected ? context.read<HomeCubit>().fetchUserData() :
        context.read<HomeCubit>().selectNotificationItem();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: itemWidth,
                    height: itemHeight,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 20, 18, 24),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expense.category,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                expense.amount % 10 == 0
                                    ? expense.amount.toInt().toString()
                                    : expense.amount.toString(),
                                style: const TextStyle(
                                    color: Colors.redAccent, fontSize: 13),
                              ),
                              Text(
                                getPassedTime(expense.date),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 63,
                  ),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(23), // Image radius
                      child: Image.asset('assets/images/blank-profile.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getPassedTime(DateTime date) {
    return "سه روز پیش";
  }
}
