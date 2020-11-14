part of 'fossil_list_page.dart';

class FossilDetailPage extends StatefulWidget {
  final Fossil fossil;
  final int count;

  FossilDetailPage({
    @required this.fossil,
    @required this.count,
  });

  @override
  _FossilDetailPageState createState() => _FossilDetailPageState();
}

class _FossilDetailPageState extends State<FossilDetailPage>
    with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            StringUtil.capitalize(
              widget.fossil.name.of(settingBloc.state.setting.language),
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
                    Expanded(child: _image()),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            _price(),
            _count(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                _donatedChip,
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      );

  Widget _image() => Transform.scale(
        scale: 1.75,
        child: Image(
          image: widget.fossil.imagePath != null
              ? FileImage(File(widget.fossil.imagePath))
              : NetworkImage(widget.fossil.imageUri),
        ),
      );

  Widget _count() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.pie_chart),
        title: Text("Piece"),
        trailing: Text("${widget.count}"),
      );

  Widget _price() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.attach_money),
        title: Text("Price"),
        trailing: Text("${widget.fossil.price} bells"),
      );

  Widget get _donatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.fossil.isDonated,
        onSelected: (isDonated) {
          widget.fossil.isDonated = !widget.fossil.isDonated;
          fossilBloc.add(UpdateFossilEvent(widget.fossil));
          setState(() {});
        },
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );
}
