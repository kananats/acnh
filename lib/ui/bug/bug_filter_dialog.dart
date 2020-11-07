part of 'bug_list_page.dart';

class BugFilterDialog extends StatefulWidget {
  @override
  _BugFilterDialogState createState() => _BugFilterDialogState();
}

class _BugFilterDialogState extends State<BugFilterDialog>
    with BlocProviderMixin {
  BugFilterCondition _condition;

  @override
  void initState() {
    super.initState();

    _condition = bugBloc.state.condition.copy();
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
                  _hemisphereToggle,
                  SizedBox(height: 12),
                  _availabilityToggle,
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: [
                      _hideCaughtChip,
                      _hideDonatedChip,
                      _hideAllYearChip,
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          bugBloc.add(SetConditionBugEvent(_condition));
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

  Widget get _hemisphereToggle => Row(
        children: [
          SizedBox(
            width: 120,
            child: Text("Hemisphere"),
          ),
          SizedBox(
            height: 24,
            child: ToggleButtons(
              children: [
                Text("North"),
                Text("South"),
              ],
              isSelected: [
                _condition.isNorth,
                !_condition.isNorth,
              ],
              onPressed: (index) => setState(
                () => _condition.isNorth = index == 0,
              ),
            ),
          ),
        ],
      );

  Widget get _availabilityToggle => Row(
        children: [
          SizedBox(
            width: 120,
            child: Text("Available"),
          ),
          SizedBox(
            height: 24,
            child: ToggleButtons(
              children: [
                Text("All"),
                Text("Now"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Text("This month"),
                ),
              ],
              isSelected: [
                _condition.availability == AvailabilityEnum.all,
                _condition.availability == AvailabilityEnum.now,
                _condition.availability == AvailabilityEnum.thisMonth,
              ],
              onPressed: (index) => setState(
                () => _condition.availability = AvailabilityEnum.values[index],
              ),
            ),
          ),
        ],
      );

  Widget get _hideCaughtChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: _condition.hideCaught,
        onSelected: (hideCaught) => setState(
          () => _condition.hideCaught = hideCaught,
        ),
        label: Text("Hide Caught"),
      );

  Widget get _hideDonatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: _condition.hideDonated,
        onSelected: (hideDonated) => setState(
          () => _condition.hideDonated = hideDonated,
        ),
        label: Text("Hide Donated"),
      );

  Widget get _hideAllYearChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: _condition.hideAllYear,
        onSelected: (hideAllYear) => setState(
          () => _condition.hideAllYear = hideAllYear,
        ),
        label: Text("Hide All Year"),
      );
}
