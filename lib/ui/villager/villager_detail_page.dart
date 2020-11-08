part of 'villager_list_page.dart';

class VillagerDetailPage extends StatefulWidget {
  final Villager villager;

  VillagerDetailPage({@required this.villager});

  @override
  _VillagerDetailPageState createState() => _VillagerDetailPageState();
}

class _VillagerDetailPageState extends State<VillagerDetailPage>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            StringUtil.capitalize(
              widget.villager.name.of(settingBloc.state.setting.language),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Container(
              child: SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Expanded(child: _icon()),
                    Expanded(child: _image()),
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                //_caughtChip,
                //_donatedChip,
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      );

  Widget _icon() => Hero(
        tag: widget.villager,
        child: Image(
          image: widget.villager.iconPath != null
              ? FileImage(File(widget.villager.iconPath))
              : NetworkImage(widget.villager.iconUri),
        ),
      );

  Widget _image() => Transform.scale(
        scale: 1.75,
        child: Image(
          image: widget.villager.iconPath != null
              ? FileImage(File(widget.villager.imagePath))
              : NetworkImage(widget.villager.imageUri),
        ),
      );

/*
  Widget get _caughtChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.villager.isCaught,
        onSelected: (isCaught) {
          widget.villager.isCaught = !widget.villager.isCaught;
          villagerBloc.add(UpdateVillagerEvent(widget.villager));
          setState(() {});
        },
        label: Text(
          "Caught",
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget get _donatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.villager.isDonated,
        onSelected: (isDonated) {
          widget.villager.isDonated = !widget.villager.isDonated;
          villagerBloc.add(UpdateVillagerEvent(widget.villager));
          setState(() {});
        },
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );*/
}
