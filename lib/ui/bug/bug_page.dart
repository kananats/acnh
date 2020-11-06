import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/bug/bug_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dto/availability.dart';
import 'package:acnh/dto/bug.dart';
import 'package:acnh/dto/bug_filter_condition.dart';
import 'package:acnh/ui/common/badge.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bug_item.dart';
part 'bug_download_dialog.dart';
part 'bug_filter_dialog.dart';

class BugPage extends StatefulWidget {
  @override
  _BugPageState createState() => _BugPageState();
}

class _BugPageState extends State<BugPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingBloc, SettingState>(
        builder: (settingContext, settingState) =>
            BlocBuilder<BugBloc, BugState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Bug"),
              actions: [
                GestureDetector(
                  child: Icon(Icons.cloud_download),
                  onTap: () => _showDownloadDialog(context),
                ),
                SizedBox(width: 18),
                GestureDetector(
                  child: Icon(Icons.article),
                  onTap: () => _showFilterDialog(context),
                ),
                SizedBox(width: 18),
              ],
            ),
            drawer: MyDrawer(),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 12),
                      Expanded(
                        child: _searchTextField(state),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                _body(context, state),
              ],
            ),
          ),
        ),
      );

  Widget _searchTextField(BugState state) => TextFormField(
        initialValue: state.condition?.keyword ?? "",
        onChanged: (value) => bugBloc.add(
          SetConditionBugEvent(
            state.condition..keyword = value,
          ),
        ),
      );

  Future<void> _showFilterDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          BugFilterDialog(),
    );
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          BugDownloadDialog(),
    );
  }

  Widget _body(BuildContext context, BugState state) {
    if (state is ReadyBugState)
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          itemCount: state.bugs.length,
          itemBuilder: (context, index) => BugItem(
            bug: state.bugs[index],
            isVisible: state.isVisibles[index],
          ),
        ),
      );
    else if (state is DownloadingBugState)
      return Container();
    else
      return Expanded(
        child: Center(
          child: Text("Please download first"),
        ),
      );
  }
}
