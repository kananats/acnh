part of 'villager_list_page.dart';

class VillagerListItem extends StatefulWidget {
  final Villager villager;
  final bool isVisible;

  VillagerListItem({
    @required this.villager,
    this.isVisible,
  });

  @override
  _VillagerListItemState createState() => _VillagerListItemState();
}

class _VillagerListItemState extends State<VillagerListItem>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return Container();
    return Column(
      children: [
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue[300]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onLongPress: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VillagerDetailPage(
                  villager: widget.villager,
                ),
              ),
            ),
            child: ExpansionTile(
              leading: _icon(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _name(),
                  SizedBox(width: 6),
                  if (widget.villager.isResident) _badge("Resident"),
                  if (widget.villager.isFavorite) _badge("Favorite"),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _species(),
                  _personality(),
                  _birthday(),
                ],
              ),
              children: [
                ButtonBar(
                  children: [
                    _resident(),
                    _favorite(),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _icon() => Hero(
        tag: widget.villager,
        child: Image(
          width: 50,
          height: 50,
          image: widget.villager.iconPath != null
              ? FileImage(File(widget.villager.iconPath))
              : NetworkImage(widget.villager.iconUri),
        ),
      );

  Widget _name() => Flexible(
        child: Text(
          StringUtil.capitalize(
            widget.villager.name.of(settingBloc.state.setting.language),
          ),
          style: TextStyle(color: Colors.blue),
        ),
      );

  Widget _badge(String text) => Row(
        children: [
          Badge(text),
          SizedBox(width: 3),
        ],
      );

  Widget _species() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.pets,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(child: Text(widget.villager.species)),
        ],
      );

  Widget _personality() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(child: Text(widget.villager.personality)),
        ],
      );

  Widget _birthday() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.cake,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(child: Text(widget.villager.birthday)),
        ],
      );

  Widget _resident() => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.villager.isResident,
        onSelected: (isCaught) {
          widget.villager.isResident = !widget.villager.isResident;
          villagerBloc.add(UpdateVillagerEvent(widget.villager));
          setState(() {});
        },
        label: Text(
          "Resident",
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget _favorite() => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.villager.isFavorite,
        onSelected: (isDonated) {
          widget.villager.isFavorite = !widget.villager.isFavorite;
          villagerBloc.add(UpdateVillagerEvent(widget.villager));
          setState(() {});
        },
        label: Text(
          "Favorite",
          style: TextStyle(fontSize: 12),
        ),
      );
}
