import 'dart:io';

import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/art/art_bloc.dart';
import 'package:acnh/bloc/setting/setting_bloc.dart';
import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/dto/art.dart';
import 'package:acnh/dto/art_filter_condition.dart';
import 'package:acnh/ui/common/badge.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'art_list_item.dart';
part 'art_download_dialog.dart';
part 'art_filter_dialog.dart';
part 'art_detail_page.dart';

class ArtListPage extends StatefulWidget {
  @override
  _ArtListPageState createState() => _ArtListPageState();
}

class _ArtListPageState extends State<ArtListPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingBloc, SettingState>(
        builder: (settingContext, settingState) =>
            BlocBuilder<ArtBloc, ArtState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Art"),
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

  Widget _searchTextField(ArtState state) => TextFormField(
        initialValue: state.condition?.keyword ?? "",
        onChanged: (value) => artBloc.add(
          SetConditionArtEvent(
            state.condition..keyword = value,
          ),
        ),
      );

  Future<void> _showFilterDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ArtFilterDialog(),
    );
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          ArtDownloadDialog(),
    );
  }

  Widget _body(BuildContext context, ArtState state) {
    if (state is ReadyArtState)
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          itemCount: state.arts.length,
          itemBuilder: (context, index) => ArtListItem(
            art: state.arts[index],
            isVisible: state.isVisibles[index],
          ),
        ),
      );
    else if (state is DownloadingArtState)
      return Container();
    else
      return Expanded(
        child: Center(
          child: Text("Please download first"),
        ),
      );
  }
}
