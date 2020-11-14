part of 'fossil_list_page.dart';

class FossilListItem extends StatefulWidget {
  final Fossil fossil;
  final bool isVisible;

  FossilListItem({
    @required this.fossil,
    this.isVisible,
  });

  @override
  _FossilListItemState createState() => _FossilListItemState();
}

class _FossilListItemState extends State<FossilListItem>
    with BlocProviderMixin {
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
                    builder: (context) => FossilDetailPage(
                      fossil: widget.fossil,
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
                      if (widget.fossil.isDonated) _badge("Donated"),
                    ],
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

  Widget _icon() => Hero(
        tag: widget.fossil,
        child: Image(
          width: 50,
          height: 50,
          image: widget.fossil.imagePath != null
              ? FileImage(File(widget.fossil.imagePath))
              : NetworkImage(widget.fossil.imageUri),
        ),
      );

  Widget _name() => Flexible(
        child: Text(
          StringUtil.capitalize(
            widget.fossil.name.of(settingBloc.state.setting.language),
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
