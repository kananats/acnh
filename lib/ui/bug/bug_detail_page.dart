part of 'bug_list_page.dart';

class BugDetailPage extends StatefulWidget {
  final Bug bug;

  BugDetailPage({@required this.bug});

  @override
  _BugDetailPageState createState() => _BugDetailPageState();
}

class _BugDetailPageState extends State<BugDetailPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            StringUtil.capitalize(
              widget.bug.name.of(settingBloc.state.setting.language),
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
            _availableMonthNorth(),
            SizedBox(height: 24),
            _availableMonthSouth(),
            SizedBox(height: 24),
            _availableTime(),
            SizedBox(height: 24),
            _price(),
            _location(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                _caughtChip,
                _donatedChip,
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      );

  Widget _icon() => Hero(
        tag: widget.bug,
        child: Image(
          image: widget.bug.iconPath != null
              ? FileImage(File(widget.bug.iconPath))
              : NetworkImage(widget.bug.iconUri),
        ),
      );

  Widget _image() => Transform.scale(
        scale: 1.75,
        child: Image(
          image: widget.bug.iconPath != null
              ? FileImage(File(widget.bug.imagePath))
              : NetworkImage(widget.bug.imageUri),
        ),
      );

  Widget _availableMonthNorth() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Month (North)",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue[300]),
            ),
            child: _monthCalendar(
              widget.bug.availability.monthArrayNorthern,
            ),
          ),
        ],
      );

  Widget _availableMonthSouth() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Month (South)",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue[300]),
            ),
            child: _monthCalendar(
              widget.bug.availability.monthArraySouthern,
            ),
          ),
        ],
      );

  Widget _monthCalendar(List<int> monthArray) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              6,
              (index) => Expanded(
                child: monthArray.contains(index + 1)
                    ? _availableContainer(StringUtil.monthToString(index + 1))
                    : _notAvailableContainer(
                        StringUtil.monthToString(index + 1)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              6,
              (index) => Expanded(
                child: monthArray.contains(index + 7)
                    ? _availableContainer(StringUtil.monthToString(index + 7))
                    : _notAvailableContainer(
                        StringUtil.monthToString(index + 7)),
              ),
            ),
          ),
        ],
      );

  Widget _availableTime() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Time",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue[300]),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    12,
                    (index) => Expanded(
                      child: widget.bug.availability.timeArray.contains(index)
                          ? _availableContainer("$index")
                          : _notAvailableContainer("$index"),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    12,
                    (index) => Expanded(
                      child:
                          widget.bug.availability.timeArray.contains(index + 12)
                              ? _availableContainer("${index + 12}")
                              : _notAvailableContainer("${index + 12}"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _price() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.attach_money),
        title: Text("Price"),
        trailing: Text("${widget.bug.price} bells"),
      );

  Widget _location() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.location_pin),
        title: Text("Location"),
        trailing: Text(widget.bug.availability.location),
      );

  Widget _availableContainer(String text) => Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget _notAvailableContainer(String text) => Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.lightBlue[300], width: 0.5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.blue[100]),
          ),
        ),
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
