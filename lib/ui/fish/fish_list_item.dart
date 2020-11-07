part of 'fish_list_page.dart';

class FishListItem extends StatefulWidget {
  final Fish fish;
  final bool isVisible;

  FishListItem({
    @required this.fish,
    this.isVisible,
  });

  @override
  _FishListItemState createState() => _FishListItemState();
}

class _FishListItemState extends State<FishListItem> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        firstCurve: Curves.fastOutSlowIn,
        sizeCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.isVisible
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Column(
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
                    builder: (context) => FishDetailPage(
                      fish: widget.fish,
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
                      if (widget.fish.availability.isAvailableNow(
                        settingBloc.state.dateTime,
                        fishBloc.state.condition.isNorth,
                      ))
                        _badge("Now"),
                      if (widget.fish.isCaught) _badge("Caught"),
                      if (widget.fish.isDonated) _badge("Donated"),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _location(),
                      _availableMonth(),
                      _availableTime(),
                      _shadow(),
                    ],
                  ),
                  children: [
                    ButtonBar(
                      children: [
                        _caught(),
                        _donated(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        secondChild: Container(),
      );


  Widget _icon() => Hero(
        tag: widget.fish,
        child: Image(
          width: 50,
          height: 50,
          image: widget.fish.iconPath != null
              ? FileImage(File(widget.fish.iconPath))
              : NetworkImage(widget.fish.iconUri),
        ),
      );


  Widget _name() => Flexible(
        child: Text(
          StringUtil.capitalize(
            widget.fish.name.of(settingBloc.state.setting.language),
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


  Widget _location() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_pin,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(child: Text(widget.fish.availability.location)),
        ],
      );


  Widget _availableMonth() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.fish.availability
                  .availableMonth(fishBloc.state.condition.isNorth),
            ),
          ),
        ],
      );
  Widget _availableTime() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.av_timer,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(widget.fish.availability.availableTime),
          ),
        ],
      );


  Widget _shadow() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.visibility,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(widget.fish.shadow),
          ),
        ],
      );

  Widget _caught() => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.fish.isCaught,
        onSelected: (isCaught) {
          widget.fish.isCaught = !widget.fish.isCaught;
          fishBloc.add(UpdateFishEvent(widget.fish));
          setState(() {});
        },
        label: Text(
          "Caught",
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget _donated() => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.fish.isDonated,
        onSelected: (isDonated) {
          widget.fish.isDonated = !widget.fish.isDonated;
          fishBloc.add(UpdateFishEvent(widget.fish));
          setState(() {});
        },
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );
}
