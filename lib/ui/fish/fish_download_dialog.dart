import 'package:acnh/bloc/fish_bloc.dart';
import 'package:acnh/bloc/fish_event.dart';
import 'package:acnh/bloc/fish_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FishDownloadDialog extends StatefulWidget {
  @override
  _FishDownloadDialogState createState() => _FishDownloadDialogState();
}

class _FishDownloadDialogState extends State<FishDownloadDialog>
    with FishBlocProviderMixin {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<FishBloc, FishState>(
                builder: (context, state) {
                  if (state is DownloadingFishState)
                    return _downloadingState(state);
                  else if (state is SuccessFishState)
                    return _successState(context);
                  else if (state is FailedFishState)
                    return _failedState(context);
                  return _defaultState(context);
                },
              ),
            ),
          ),
        ),
      );

  Widget _defaultState(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Download Fish Data?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => fishBloc.add(DownloadFishEvent()),
                child: Text("Download"),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
            ],
          )
        ],
      );

  Widget _downloadingState(DownloadingFishState state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text("Downloading ${state.count} of ${state.total}..."),
        ],
      );

  Widget _successState(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Download Complete"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => fishBloc.add(DownloadFishEvent()),
                child: Text("Download Again"),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Close"),
              ),
            ],
          )
        ],
      );

  Widget _failedState(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Download failed. Try again?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => fishBloc.add(DownloadFishEvent()),
                child: Text("Download"),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
            ],
          )
        ],
      );
}