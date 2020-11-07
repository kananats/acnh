import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/sea/sea_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dto/availability.dart';
import 'package:acnh/dto/sea.dart';
import 'package:acnh/dto/sea_filter_condition.dart';
import 'package:acnh/ui/common/badge.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sea_list_item.dart';
part 'sea_download_dialog.dart';
part 'sea_filter_dialog.dart';
part 'sea_detail_page.dart';

class SeaListPage extends StatefulWidget {
  @override
  _SeaListPageState createState() => _SeaListPageState();
}

class _SeaListPageState extends State<SeaListPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingBloc, SettingState>(
        builder: (settingContext, settingState) =>
            BlocBuilder<SeaBloc, SeaState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Sea Creatures"),
              actions: [
                GestureDetector(
                  child: Icon(Icons.cloud_download),
                  onTap: () => _showDownloadDialog(context),
                ),
                SizedBox(width: 18),
                GestureDetector(
                  child: Icon(Icons.tune),
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

  Widget _searchTextField(SeaState state) => TextFormField(
        initialValue: state.condition?.keyword ?? "",
        onChanged: (value) => seaBloc.add(
          SetConditionSeaEvent(
            state.condition..keyword = value,
          ),
        ),
      );

  Future<void> _showFilterDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          SeaFilterDialog(),
    );
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          SeaDownloadDialog(),
    );
  }

  Widget _body(BuildContext context, SeaState state) {
    if (state is ReadySeaState)
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          itemCount: state.seas.length,
          itemBuilder: (context, index) => SeaListItem(
            sea: state.seas[index],
            isVisible: state.isVisibles[index],
          ),
        ),
      );
    else if (state is DownloadingSeaState)
      return Container();
    else
      return Expanded(
        child: Center(
          child: Text("Please download first"),
        ),
      );
  }
}
