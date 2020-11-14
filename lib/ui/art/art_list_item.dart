part of 'art_list_page.dart';

class ArtListItem extends StatefulWidget {
  final Art art;
  final bool isVisible;

  ArtListItem({
    @required this.art,
    this.isVisible,
  });

  @override
  _ArtListItemState createState() => _ArtListItemState();
}

class _ArtListItemState extends State<ArtListItem> with BlocProviderMixin {
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
                    builder: (context) => ArtDetailPage(
                      art: widget.art,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  leading: _image(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _name(),
                      SizedBox(width: 6),
                      if (widget.art.hasFake) _badge("Fake"),
                      if (widget.art.isDonated) _badge("Donated"),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                  children: [
                    ButtonBar(
                      children: [
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

  Widget _image() => Hero(
        tag: widget.art,
        child: Image(
          width: 50,
          height: 50,
          image: widget.art.imagePath != null
              ? FileImage(File(widget.art.imagePath))
              : NetworkImage(widget.art.imageUri),
        ),
      );

  Widget _name() => Flexible(
        child: Text(
          StringUtil.capitalize(
            widget.art.name.of(settingBloc.state.setting.language),
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

  Widget _donated() => FilterChip(
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
