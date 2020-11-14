part of 'villager_list_page.dart';

class VillagerFilterDialog extends StatefulWidget {
  @override
  _VillagerFilterDialogState createState() => _VillagerFilterDialogState();
}

class _VillagerFilterDialogState extends State<VillagerFilterDialog>
    with BlocProviderMixin {
  VillagerFilterCondition _condition;

  @override
  void initState() {
    super.initState();

    _condition = villagerBloc.state.condition.copy();
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
                  _species,
                  _personality,
                  SizedBox(height: 12),
                  _residentToggle,
                  SizedBox(height: 12),
                  _favoriteToggle,
                  SizedBox(height: 12),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          villagerBloc
                              .add(SetConditionVillagerEvent(_condition));
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

  Widget get _species => Row(
        children: [
          SizedBox(
            width: 120,
            child: Text("Species"),
          ),
          IntrinsicHeight(
            child: DropdownButton<SpeciesEnum>(
              value: _condition.species,
              onChanged: (value) => setState(
                () => _condition.species = value,
              ),
              items: SpeciesEnum.values
                  .map(
                    (value) => DropdownMenuItem<SpeciesEnum>(
                      child: Text(value.name),
                      value: value,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );

  Widget get _personality => Row(
        children: [
          SizedBox(
            width: 120,
            child: Text("Personality"),
          ),
          IntrinsicHeight(
            child: DropdownButton<PersonalityEnum>(
              value: _condition.personality,
              onChanged: (value) => setState(
                () => _condition.personality = value,
              ),
              items: PersonalityEnum.values
                  .map(
                    (value) => DropdownMenuItem<PersonalityEnum>(
                      child: Text(value.name),
                      value: value,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );

  Widget get _residentToggle => Row(
        children: [
          SizedBox(
            width: 120,
            child: Text("Resident"),
          ),
          SizedBox(
            height: 24,
            child: ToggleButtons(
              children: [
                Text("All"),
                Text("Only"),
                Text("None"),
              ],
              isSelected: [
                _condition.residentSelection == SelectionEnum.all,
                _condition.residentSelection == SelectionEnum.only,
                _condition.residentSelection == SelectionEnum.none,
              ],
              onPressed: (index) => setState(
                () =>
                    _condition.residentSelection = SelectionEnum.values[index],
              ),
            ),
          ),
        ],
      );

  Widget get _favoriteToggle => Row(
        children: [
          SizedBox(
            width: 120,
            child: Text("Favorite"),
          ),
          SizedBox(
            height: 24,
            child: ToggleButtons(
              children: [
                Text("All"),
                Text("Only"),
                Text("None"),
              ],
              isSelected: [
                _condition.favoriteSelection == SelectionEnum.all,
                _condition.favoriteSelection == SelectionEnum.only,
                _condition.favoriteSelection == SelectionEnum.none,
              ],
              onPressed: (index) => setState(
                () =>
                    _condition.favoriteSelection = SelectionEnum.values[index],
              ),
            ),
          ),
        ],
      );
}
