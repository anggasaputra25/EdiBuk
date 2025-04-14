import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: Colors.black12),
          ),
          child: IconButton(
            icon: Icon(CupertinoIcons.bell, color: Colors.grey.shade400),
            onPressed: () {},
            iconSize: 24,
            padding: EdgeInsets.zero,
          ),
        ),
        Positioned(
          top: 14,
          right: 14,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Color(0xFF6467F6),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
