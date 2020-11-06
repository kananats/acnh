import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/fish/fish_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dto/availability.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/dto/fish_filter_condition.dart';
import 'package:acnh/ui/common/badge.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fish_item.dart';
part 'fish_download_dialog.dart';
part 'fish_filter_dialog.dart';

class FishPage extends StatefulWidget {
  @override
  _FishPageState createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingBloc, SettingState>(
        builder: (settingContext, settingState) =>
            BlocBuilder<FishBloc, FishState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Fish"),
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

  Widget _searchTextField(FishState state) => TextFormField(
        initialValue: state.condition?.keyword ?? "",
        onChanged: (value) => fishBloc.add(
          SetConditionFishEvent(
            state.condition..keyword = value,
          ),
        ),
      );

  Future<void> _showFilterDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishFilterDialog(),
    );
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishDownloadDialog(),
    );
  }

  Widget _body(BuildContext context, FishState state) {
    if (state is ReadyFishState)
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          itemCount: state.fishs.length,
          itemBuilder: (context, index) => FishItem(
            fish: state.fishs[index],
            isVisible: state.isVisibles[index],
          ),
        ),
      );
    else if (state is DownloadingFishState)
      return Container();
    else
      return Expanded(
        child: Center(
          child: Text("Please download first"),
        ),
      );
  }
}
