import 'package:flutter/material.dart';

class ListDashBoardContent extends StatelessWidget {
  final String listName;
  final String totalCartList;
  const ListDashBoardContent({
    super.key,
    required this.listName,
    required this.totalCartList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(
          height: 5,
        ),
        Text("\$${totalCartList}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
      ],
    );
  }
}
