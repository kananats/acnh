import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/time/time_event.dart';
import 'package:intl/intl.dart';

import 'package:acnh/bloc/time/time_bloc.dart';
import 'package:acnh/bloc/time/time_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<TimeBloc, TimeState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: ListView(
            children: [
              ListTile(
                title: Text("Date"),
                trailing: TextButton(
                  onPressed: () => _showDatePicker(context, state),
                  child: Text(
                    DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                        .format(state.dateTime ?? DateTime.now()),
                  ),
                ),
              ),
              ListTile(
                title: Text("Time"),
                trailing: TextButton(
                  onPressed: () => _showTimePicker(context, state),
                  child: Text(
                    DateFormat(DateFormat.HOUR24_MINUTE_SECOND)
                        .format(state.dateTime),
                  ),
                ),
              ),
              ListTile(
                title: Text("Freeze"),
                trailing: Switch(
                  value: state is PauseTimeState,
                  onChanged: (value) => timeBloc.add(
                    value ? PauseTimeEvent() : PlayTimeEvent(),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => timeBloc.add(ResetTimeEvent()),
                  child: Text("Reset"),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      );

  Future<void> _showDatePicker(BuildContext context, TimeState state) async {
    var newDateTime = await showDatePicker(
      context: context,
      initialDate: state.dateTime,
      firstDate: DateTime(1000, 1, 1),
      lastDate: DateTime(3000, 1, 1),
    );

    if (newDateTime != null) {
      var dateTime = state.dateTime.toLocal();
      dateTime = DateTime(
        newDateTime.year,
        newDateTime.month,
        newDateTime.day,
        dateTime.hour,
        dateTime.minute,
      );

      timeBloc.add(PauseTimeEvent()..dateTime = dateTime);
    }
  }

  Future<void> _showTimePicker(BuildContext context, TimeState state) async {
    var time = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: state.dateTime.hour,
        minute: state.dateTime.minute,
      ),
    );

    if (time != null) {
      var dateTime = state.dateTime.toLocal();
      dateTime = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        time.hour,
        time.minute,
      );

      timeBloc.add(PauseTimeEvent()..dateTime = dateTime);
    }
  }
}
