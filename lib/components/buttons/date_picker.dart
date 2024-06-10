import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerDemo extends StatefulWidget {
  const DatePickerDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<DatePickerDemo> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFormField(
          initialValue: "${selectedDate.toLocal()}".split(' ')[0],
          decoration: const InputDecoration(
            label: Text('Deadline'),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(),
          ),
          onTap: () => _selectDate(context),
        ),
        // Text("${selectedDate.toLocal()}".split(' ')[0]),
        // const SizedBox(
        //   height: 20.0,
        // ),
        // ElevatedButton(
        //   onPressed: () => _selectDate(context),
        //   child: const Text('Select date'),
        // ),
      ],
    );
  }
}
