import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/fish_bloc.dart';
import 'package:acnh/bloc/fish_event.dart';
import 'package:acnh/bloc/fish_state.dart';
import 'package:acnh/ui/common/my_drawer.dart';
import 'package:acnh/ui/fish/fish_download_dialog.dart';
import 'package:acnh/ui/fish/fish_filter_condition.dart';
import 'package:acnh/ui/fish/fish_filter_dialog.dart';
import 'package:acnh/ui/fish/fish_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FishPage extends StatefulWidget {
  @override
  _FishPageState createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> with BlocProviderMixin {
  FishFilterCondition _condition = FishFilterCondition();

  @override
  void initState() {
    super.initState();

    fishBloc.add(InitializeFishEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                    child: TextField(),
                  ),
                ],
              ),
            ),
            BlocBuilder<FishBloc, FishState>(
              builder: (context, state) {
                if (state is SuccessFishState)
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(12),
                      itemCount: state.fishs.length,
                      itemBuilder: (context, index) =>
                          FishItem(fish: state.fishs[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                    ),
                  );
                return Expanded(
                  child: Center(
                    child: Text("Please download first"),
                  ),
                );
              },
            )
          ],
        ),
      );

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishDownloadDialog(),
    );

    setState(() {});
  }

  Future<void> _showFilterDialog(BuildContext context) async {
    var condition = await showGeneralDialog<FishFilterCondition>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishFilterDialog(),
    );

    if (condition != null)
      setState(
        () => _condition = condition,
      );
  }
}
