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
  @override
  void initState() {
    super.initState();

    fishBloc.add(InitializeFishEvent());
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<FishBloc, FishState>(
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
                      child: TextField(
                        onChanged: (value) => fishBloc.add(
                          FilterFishEvent(
                            condition: fishBloc.condition..search = value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _body(context, state),
            ],
          ),
        ),
      );

  Future<void> _showFilterDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishFilterDialog(),
    );

    setState(() {});
  }

  Future<void> _showDownloadDialog(BuildContext context) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          FishDownloadDialog(),
    );

    setState(() {});
  }

  Widget _body(BuildContext context, FishState state) {
    if (state is SuccessFishState)
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
    return Expanded(
      child: Center(
        child: Text("Please download first"),
      ),
    );
  }
}
