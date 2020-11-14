import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/fossil/fossil_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dto/fossil.dart';
import 'package:acnh/dto/fossil_filter_condition.dart';
import 'package:acnh/ui/common/badge.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fossil_list_item.dart';
part 'fossil_download_dialog.dart';
part 'fossil_filter_dialog.dart';
part 'fossil_detail_page.dart';

class FossilListPage extends StatefulWidget {
  @override
  _FossilListPageState createState() => _FossilListPageState();
}

class _FossilListPageState extends State<FossilListPage>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingBloc, SettingState>(
        builder: (settingContext, settingState) =>
            BlocBuilder<FossilBloc, FossilState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Fossil"),
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

  Widget _searchTextField(FossilState state) => TextFormField(
        initialValue: state.condition?.keyword ?? "",
        onChanged: (value) => fossilBloc.add(
          SetConditionFossilEvent(
            state.condition..keyword = value,
          ),
        ),
      );

  Future<void> _showFilterDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FossilFilterDialog(),
    );
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FossilDownloadDialog(),
    );
  }

  Widget _body(BuildContext context, FossilState state) {
    if (state is ReadyFossilState)
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          itemCount: state.fossils.length,
          itemBuilder: (context, index) {
            var fossil = state.fossils[index];
            var name = fossil.name.USen.split(" ").first;
            var count = state.fossils
                .where((element) => element.name.USen.split(" ").first == name)
                .length;

            return FossilListItem(
              fossil: fossil,
              count: count,
              isVisible: state.isVisibles[index],
            );
          },
        ),
      );
    else if (state is DownloadingFossilState)
      return Container();
    else
      return Expanded(
        child: Center(
          child: Text("Please download first"),
        ),
      );
  }
}
