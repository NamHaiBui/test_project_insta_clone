import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDateView extends StatelessWidget {
  final DateTime datetime;
  const PostDateView({super.key, required this.datetime});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMMM, yyyy, hh:mm a');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        formatter.format(datetime),
      ),
    );
  }
}
