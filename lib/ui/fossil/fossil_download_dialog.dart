part of 'fossil_list_page.dart';

class FossilDownloadDialog extends StatefulWidget {
  @override
  _FossilDownloadDialogState createState() => _FossilDownloadDialogState();
}

class _FossilDownloadDialogState extends State<FossilDownloadDialog>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<FossilBloc, FossilState>(
                builder: (context, state) {
                  if (state is DownloadingFossilState)
                    return _downloadingState(state);
                  else if (state is ReadyFossilState)
                    return _successState(context);
                  else if (state is FailedFossilState)
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
          Text("Download Fossil Data?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => fossilBloc.add(DownloadFossilEvent()),
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

  Widget _downloadingState(DownloadingFossilState state) => Column(
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
          Text("Download Fossil Images?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => fossilBloc.add(DownloadFossilEvent()),
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

  Widget _failedState(BuildContext context, FailedFossilState state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("ERROR: " + state.error),
          Text("Download failed. Try again?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => fossilBloc.add(DownloadFossilEvent()),
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
