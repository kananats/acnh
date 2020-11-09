import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/villager/villager_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/dto/villager.dart';
import 'package:acnh/dto/villager_filter_condition.dart';
import 'package:acnh/ui/common/badge.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'villager_list_item.dart';
part 'villager_download_dialog.dart';
part 'villager_filter_dialog.dart';
part 'villager_detail_page.dart';

class VillagerListPage extends StatefulWidget {
  @override
  _VillagerListPageState createState() => _VillagerListPageState();
}

class _VillagerListPageState extends State<VillagerListPage>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingBloc, SettingState>(
        builder: (settingContext, settingState) =>
            BlocBuilder<VillagerBloc, VillagerState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Villager"),
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

  Widget _searchTextField(VillagerState state) => TextFormField(
        initialValue: state.condition?.keyword ?? "",
        onChanged: (value) => villagerBloc.add(
          SetConditionVillagerEvent(
            state.condition..keyword = value,
          ),
        ),
      );

  Future<void> _showFilterDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          VillagerFilterDialog(),
    );
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          VillagerDownloadDialog(),
    );
  }

  Widget _body(BuildContext context, VillagerState state) {
    if (state is ReadyVillagerState)
      return Expanded(
        child: ListView.builder(
          addAutomaticKeepAlives: false,
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          itemCount: state.villagers.length,
          itemBuilder: (context, index) => VillagerListItem(
            villager: state.villagers[index],
            isVisible: state.isVisibles[index],
          ),
        ),
      );
    else if (state is DownloadingVillagerState)
      return Container();
    else
      return Expanded(
        child: Center(
          child: Text("Please download first"),
        ),
      );
  }
}
