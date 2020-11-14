part of 'art_list_page.dart';

class ArtDetailPage extends StatefulWidget {
  final Art art;

  ArtDetailPage({@required this.art});

  @override
  _ArtDetailPageState createState() => _ArtDetailPageState();
}

class _ArtDetailPageState extends State<ArtDetailPage> with BlocProviderMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            StringUtil.capitalize(
              widget.art.name.of(settingBloc.state.setting.language),
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
            _buyPrice(),
            _sellPrice(),
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
          image: widget.art.imagePath != null
              ? FileImage(File(widget.art.imagePath))
              : NetworkImage(widget.art.imageUri),
        ),
      );

  Widget _buyPrice() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.attach_money),
        title: Text("Buy Price"),
        trailing: Text("${widget.art.buyPrice} bells"),
      );

  Widget _sellPrice() => ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(Icons.attach_money),
        title: Text("Sell Price"),
        trailing: Text("${widget.art.sellPrice} bells"),
      );

  Widget get _donatedChip => FilterChip(
        selectedColor: Colors.lightBlue,
        selected: widget.art.isDonated,
        onSelected: (isDonated) {
          widget.art.isDonated = !widget.art.isDonated;
          artBloc.add(UpdateArtEvent(widget.art));
          setState(() {});
        },
        label: Text(
          "Donated",
          style: TextStyle(fontSize: 12),
        ),
      );
}
