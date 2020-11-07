part of 'sea_list_page.dart';

class SeaListItem extends StatefulWidget {
  final Sea sea;
  final bool isVisible;

  SeaListItem({
    @required this.sea,
    this.isVisible,
  });

  @override
  _SeaListItemState createState() => _SeaListItemState();
}

class _SeaListItemState extends State<SeaListItem> with BlocProviderMixin {
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
                    builder: (context) => SeaDetailPage(
                      sea: widget.sea,
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
                      if (widget.sea.availability.isAvailableNow(
                        settingBloc.state.dateTime,
                        seaBloc.state.condition.isNorth,
                      ))
                        _badge("Now"),
                      if (widget.sea.isCaught) _badge("Caught"),
                      if (widget.sea.isDonated) _badge("Donated"),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
        tag: widget.sea,
        child: Image(
          width: 50,
          height: 50,
          image: widget.sea.iconPath != null
              ? FileImage(File(widget.sea.iconPath))
              : NetworkImage(widget.sea.iconUri),
        ),
      );

  Widget _name() => Flexible(
        child: Text(
          StringUtil.capitalize(
            widget.sea.name.of(settingBloc.state.setting.language),
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
              widget.sea.availability
                  .availableMonth(seaBloc.state.condition.isNorth),
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
            child: Text(widget.sea.availability.availableTime),
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
            child: Text(widget.sea.shadow + " / " + widget.sea.speed),
          ),
        ],
      );

  Widget _caught() => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.sea.isCaught,
        onSelected: (isCaught) {
          widget.sea.isCaught = !widget.sea.isCaught;
          seaBloc.add(UpdateSeaEvent(widget.sea));
          setState(() {});
        },
        label: Text(
          "Caught",
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget _donated() => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.sea.isDonated,
        onSelected: (isDonated) {
          widget.sea.isDonated = !widget.sea.isDonated;
          seaBloc.add(UpdateSeaEvent(widget.sea));
          setState(() {});
        },
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );
}
