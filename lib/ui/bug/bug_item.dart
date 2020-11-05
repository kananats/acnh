part of 'bug_page.dart';

class BugItem extends StatefulWidget {
  final Bug bug;
  final bool isVisible;

  BugItem({
    @required this.bug,
    this.isVisible,
  });

  @override
  _BugItemState createState() => _BugItemState();
}

class _BugItemState extends State<BugItem> with BlocProviderMixin {
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
              child: ExpansionTile(
                leading: Column(
                  children: [
                    SizedBox(child: _iconImage),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _name,
                    SizedBox(width: 6),
                    if (widget.bug.availability.isAvailableNow(
                      settingBloc.state.dateTime,
                      bugBloc.state.condition.isNorth,
                    ))
                      _badge("Now"),
                    if (widget.bug.isCaught) _badge("Caught"),
                    if (widget.bug.isDonated) _badge("Donated"),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _location,
                    _availableMonth,
                    _availableTime,
                  ],
                ),
                children: [
                  ButtonBar(
                    children: [
                      _caughtChip,
                      _donatedChip,
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        secondChild: Container(),
      );

  Widget _badge(String text) => Row(
        children: [
          Badge(text),
          SizedBox(width: 3),
        ],
      );

  Widget get _name => Text(
        StringUtil.capitalize(
          widget.bug.name.of(settingBloc.state.setting.language),
        ),
        style: TextStyle(color: Colors.blue),
      );

  Widget get _location => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_pin,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(child: Text(widget.bug.availability.location)),
        ],
      );

  Widget get _availableTime => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.timelapse,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(widget.bug.availability.availableTime),
          ),
        ],
      );

  Widget get _availableMonth => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.bug.availability
                  .availableMonth(bugBloc.state.condition.isNorth),
            ),
          ),
        ],
      );

  Widget get _iconImage => Image(
        width: 50,
        height: 50,
        image: widget.bug.iconPath != null
            ? FileImage(File(widget.bug.iconPath))
            : NetworkImage(widget.bug.iconUri),
      );

  Widget get _caughtChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.bug.isCaught,
        onSelected: (isCaught) {
          widget.bug.isCaught = !widget.bug.isCaught;
          bugBloc.add(UpdateBugEvent(widget.bug));
          setState(() {});
        },
        label: Text(
          "Caught",
          style: TextStyle(fontSize: 12),
        ),
      );

  Widget get _donatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.bug.isDonated,
        onSelected: (isDonated) {
          widget.bug.isDonated = !widget.bug.isDonated;
          bugBloc.add(UpdateBugEvent(widget.bug));
          setState(() {});
        },
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );
}
