part of 'art_list_page.dart';

class ArtFilterDialog extends StatefulWidget {
  @override
  _ArtFilterDialogState createState() => _ArtFilterDialogState();
}

class _ArtFilterDialogState extends State<ArtFilterDialog>
    with BlocProviderMixin {
  ArtFilterCondition _condition;

  @override
  void initState() {
    super.initState();

    _condition = artBloc.state.condition.copy();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: [
                      _hideDonatedChip,
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          artBloc.add(SetConditionArtEvent(_condition));
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                      RaisedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancel"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget get _hideDonatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: _condition.hideDonated,
        onSelected: (hideDonated) => setState(
          () => _condition.hideDonated = hideDonated,
        ),
        label: Text("Hide Donated"),
      );
}
