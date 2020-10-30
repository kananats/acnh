import 'package:acnh/fish/fish_filter_condition.dart';
import 'package:flutter/material.dart';

class FishFilter extends StatefulWidget {
  @override
  _FishFilterState createState() => _FishFilterState();
}

class _FishFilterState extends State<FishFilter> {
  final FishFilterCondition _condition = FishFilterCondition();

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
                        onPressed: () {},
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
                _condition.isNorthernHemisphere,
                !_condition.isNorthernHemisphere,
              ],
              onPressed: (index) => setState(
                () => _condition.isNorthernHemisphere = index == 0,
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
