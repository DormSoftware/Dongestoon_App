import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

Widget notificationItem(Expense expense) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              width: 170,
              height: 98,
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
                              ? expense.amount  .toInt().toString()
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
  );
}
String getPassedTime(DateTime date) {
  return "سه روز پیش";
}