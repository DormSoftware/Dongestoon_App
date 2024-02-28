
import 'package:dongestoon/screens/group_screen.dart';
import 'package:flutter/material.dart';

import '../models/group.dart';

Widget groupItem(Group group, BuildContext context) {
  return InkWell(
    onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupScreen()));},
    child: Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        height: 80,
        width: 360,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 18, 24),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: const Alignment(-.2, 0),
                    image: AssetImage('assets/images/group${group.profilePic}.png'),
                    /*Image.asset('assets/images/blank-profile.jpg'),*/
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              group.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "بدهی : ${group.totalCost}",
                    style: TextStyle(color: Colors.red.shade400, fontSize: 11),
                  ),
                  Text(
                    "طلی : ${group.totalCost}",
                    style: const TextStyle(color: Colors.green, fontSize: 11),
                  ),
                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(icon: const Icon(Icons.chevron_right_outlined),onPressed: (){},),
            )

          ],
        ),
      ),
    ),
  );
}
