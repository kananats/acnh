part of 'fish_list_page.dart';

class FishDetailPage extends StatefulWidget {
  final Fish fish;

  FishDetailPage({@required this.fish});

  @override
  _FishDetailPageState createState() => _FishDetailPageState();
}

class _FishDetailPageState extends State<FishDetailPage>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            StringUtil.capitalize(
              widget.fish.name.of(settingBloc.state.setting.language),
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
            _shadow(),
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
        tag: widget.fish,
        child: Image(
          image: widget.fish.iconPath != null
              ? FileImage(File(widget.fish.iconPath))
              : NetworkImage(widget.fish.iconUri),
        ),
      );

  Widget _image() => Transform.scale(
        scale: 1.75,
        child: Image(
          image: widget.fish.iconPath != null
              ? FileImage(File(widget.fish.imagePath))
              : NetworkImage(widget.fish.imageUri),
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
              widget.fish.availability.monthArrayNorthern,
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
              widget.fish.availability.monthArraySouthern,
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
                      child: widget.fish.availability.timeArray.contains(index)
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
                      child: widget.fish.availability.timeArray
                              .contains(index + 12)
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
        trailing: Text("${widget.fish.price} bells"),
      );

  Widget _location() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.location_pin),
        title: Text("Location"),
        trailing: Text(widget.fish.availability.location),
      );

  Widget _shadow() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.visibility),
        title: Text("Shadow"),
        trailing: Text(widget.fish.shadow),
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

  Widget get _donatedChip => FilterChip(
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
