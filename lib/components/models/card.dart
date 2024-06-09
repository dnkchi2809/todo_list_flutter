import 'package:flutter/material.dart';
import 'package:todo_list_flutter/const.dart';

import '../../hook/color_from_status.dart';

class CardComponent extends StatelessWidget{
  final String cardTitle;
  final Status status;
  final String recentUpdateDate;

  const CardComponent({
    super.key,
    required this.cardTitle,
    required this.status,
    required this.recentUpdateDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(width: 1, color: Colors.grey),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //CardTitle
          Text(
              cardTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colorFromStatus(status),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),),
                padding: const EdgeInsets.all(5),
                child: Text(status.name),
              ),
              const SizedBox(width: 10,),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white38,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),),
                padding: const EdgeInsets.all(5),
                child: Text(recentUpdateDate),
              )
            ],
          )
        ],
      ),
    );
  }
}