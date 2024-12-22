import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_alarm_clock/app/data/models/alarm_info.dart';

class AlarmEditSheet extends StatefulWidget {
  final AlarmInfo alarmInfo;
  final Function(AlarmInfo) onSave;

  AlarmEditSheet({required this.alarmInfo, required this.onSave});

  @override
  _AlarmEditSheetState createState() => _AlarmEditSheetState();
}

class _AlarmEditSheetState extends State<AlarmEditSheet> {
  late DateTime _selectedTime;
  late String _title;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.alarmInfo.alarmDateTime!;
    _title = widget.alarmInfo.title!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Edit Alarm', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: TextEditingController(text: _title),
            onChanged: (value) => _title = value,
          ),
          TextButton(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(_selectedTime),
              );
              if (pickedTime != null) {
                setState(() {
                  _selectedTime = DateTime(
                    _selectedTime.year,
                    _selectedTime.month,
                    _selectedTime.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                });
              }
            },
            child: Text('Select Time: ${DateFormat('hh:mm a').format(_selectedTime)}'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onSave(AlarmInfo(
                id: widget.alarmInfo.id,
                alarmDateTime: _selectedTime,
                title: _title,
                gradientColorIndex: widget.alarmInfo.gradientColorIndex,
              ));
              Navigator.pop(context);
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
