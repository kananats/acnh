import 'package:acnh/bloc/bloc.dart';
import 'package:acnh/bloc/fish_event.dart';
import 'package:acnh/ui/fish/fish_filter_condition.dart';
import 'package:flutter/material.dart';

class FishFilterDialog extends StatefulWidget {
  @override
  _FishFilterDialogState createState() => _FishFilterDialogState();
}

class _FishFilterDialogState extends State<FishFilterDialog>
    with BlocProviderMixin {
  FishFilterCondition _condition;

  @override
  void initState() {
    super.initState();

    _condition = fishBloc.condition;
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
                          fishBloc.add(FilterFishEvent(condition: _condition));
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
                _condition.availability == AvailabilityEnum.month,
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

enum AvailabilityEnum {
  all,
  now,
  month,
}
