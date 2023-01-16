import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubChildItem extends StatelessWidget {
  final String key1;
  final String value;
  final bool isDivider;
  final Color color;
  double width ;
   SubChildItem(this.key1, this.value, this.isDivider,[this.color = Colors.black,this.width=2.5]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
              width: MediaQuery.of(context).size.width / width,
              child: Text(
                key1,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                ': '+value,
                style: TextStyle(fontSize: 16, color: color),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
          ],
        ),
        isDivider
            ? const Divider(
          thickness: 1,
          indent: 5,
          endIndent: 5,

        )
            : const SizedBox(),
      ],
    );
  }
}