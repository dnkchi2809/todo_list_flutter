import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DatePickerDemo extends StatefulWidget {
  const DatePickerDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<DatePickerDemo> {
  final TextEditingController taskDeadlineController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  
  @override
  void initState() {
    final DateTime today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(today);
    taskDeadlineController.text = formattedDate;

    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        taskDeadlineController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFormField(
          controller: taskDeadlineController,
          decoration: const InputDecoration(
            label: Text('Deadline'),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}
