import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        drawer: MyDrawer(),
        body: BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
          if (state is ReadySettingState)
            return ListView(
              children: [
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "Language Settings",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                _language(state),
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "Date Settings",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                _date(context, state),
                _time(context, state),
                _freeze(state),
                _reset,
                SizedBox(height: 8),
                Divider(),
                SizedBox(height: 8),
              ],
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        }),
      );

  Widget get _reset => Center(
        child: ElevatedButton(
          onPressed: () => settingBloc.add(ResetTimeSettingEvent()),
          child: Text("Reset"),
        ),
      );

  Widget _language(SettingState state) => ListTile(
        title: Text("Language"),
        trailing: DropdownButton<LanguageEnum>(
          value: state.setting.language,
          onChanged: (value) => settingBloc.add(
            SetLanguageSettingEvent()..language = value,
          ),
          items: LanguageEnum.values
              .map(
                (value) => DropdownMenuItem<LanguageEnum>(
                  child: Text(value.name),
                  value: value,
                ),
              )
              .toList(),
        ),
      );

  Widget _freeze(SettingState state) => ListTile(
        title: Text("Freeze"),
        trailing: Switch(
          value: state.setting.isFreezed,
          onChanged: (value) => settingBloc.add(
            ToggleFreezeSettingEvent(),
          ),
        ),
      );

  Widget _time(BuildContext context, SettingState state) => ListTile(
        title: Text("Time"),
        trailing: TextButton(
          onPressed: () => _showTimePicker(context, state),
          child: Text(
            DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(state.dateTime),
          ),
        ),
      );

  Widget _date(BuildContext context, SettingState state) => ListTile(
        title: Text("Date"),
        trailing: TextButton(
          onPressed: () => _showDatePicker(context, state),
          child: Text(
            DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                .format(state.dateTime ?? DateTime.now()),
          ),
        ),
      );

  Future<void> _showDatePicker(BuildContext context, SettingState state) async {
    var date = await showDatePicker(
      context: context,
      initialDate: state.dateTime,
      firstDate: DateTime(1000, 1, 1),
      lastDate: DateTime(3000, 1, 1),
    );

    if (date != null) settingBloc.add(SetDateSettingEvent()..date = date);
  }

  Future<void> _showTimePicker(BuildContext context, SettingState state) async {
    var time = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: state.dateTime.hour,
        minute: state.dateTime.minute,
      ),
    );

    if (time != null) settingBloc.add(SetTimeSettingEvent()..time = time);
  }
}
