part of 'villager_list_page.dart';

class VillagerDownloadDialog extends StatefulWidget {
  @override
  _VillagerDownloadDialogState createState() => _VillagerDownloadDialogState();
}

class _VillagerDownloadDialogState extends State<VillagerDownloadDialog>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<VillagerBloc, VillagerState>(
                builder: (context, state) {
                  if (state is DownloadingVillagerState)
                    return _downloadingState(state);
                  else if (state is ReadyVillagerState)
                    return _successState(context);
                  else if (state is FailedVillagerState)
                    return _failedState(context, state);
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
          Text("Download Villager Data?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => villagerBloc.add(DownloadVillagerEvent()),
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

  Widget _downloadingState(DownloadingVillagerState state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text(state.progressString),
        ],
      );

  Widget _successState(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Download Villager Images?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => villagerBloc.add(DownloadVillagerEvent()),
                child: Text("Download"),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Close"),
              ),
            ],
          )
        ],
      );

  Widget _failedState(BuildContext context, FailedVillagerState state) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("ERROR: " + state.error),
          Text("Download failed. Try again?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => villagerBloc.add(DownloadVillagerEvent()),
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
