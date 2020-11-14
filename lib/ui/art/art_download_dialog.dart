part of 'art_list_page.dart';

class ArtDownloadDialog extends StatefulWidget {
  @override
  _ArtDownloadDialogState createState() => _ArtDownloadDialogState();
}

class _ArtDownloadDialogState extends State<ArtDownloadDialog>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<ArtBloc, ArtState>(
                builder: (context, state) {
                  if (state is DownloadingArtState)
                    return _downloadingState(state);
                  else if (state is ReadyArtState)
                    return _successState(context);
                  else if (state is FailedArtState)
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
          Text("Download Art Data?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => artBloc.add(DownloadArtEvent()),
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

  Widget _downloadingState(DownloadingArtState state) => Column(
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
          Text("Download Art Images?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => artBloc.add(DownloadArtEvent()),
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

  Widget _failedState(BuildContext context, FailedArtState state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("ERROR: " + state.error),
          Text("Download failed. Try again?"),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => artBloc.add(DownloadArtEvent()),
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
