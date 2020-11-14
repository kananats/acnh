part of 'fossil_list_page.dart';

class FossilFilterDialog extends StatefulWidget {
  @override
  _FossilFilterDialogState createState() => _FossilFilterDialogState();
}

class _FossilFilterDialogState extends State<FossilFilterDialog>
    with BlocProviderMixin {
  FossilFilterCondition _condition;

  @override
  void initState() {
    super.initState();

    _condition = fossilBloc.state.condition.copy();
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
                          fossilBloc.add(SetConditionFossilEvent(_condition));
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
