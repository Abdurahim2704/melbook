import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget
    List<GlobalKey> keys = [];
    var widgets = List.generate(25, (index) {
      GlobalKey globalKey = GlobalKey();
      keys.add(globalKey);
      return FilterChip(
        key: globalKey,
        label: Text("asdasasd"),
        onSelected: (bool value) {},
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar'),
      ),
      body: Column(
        children: [
          OverRow(
            keys: keys,
            widgets: widgets,
          ),
        ],
      ),
    );
  }
}

class OverRow extends StatefulWidget {
  OverRow({super.key, required this.keys, required this.widgets});

  List<GlobalKey> keys = [];
  List<Widget> widgets = [];

  @override
  State<OverRow> createState() => _OverRowState();
}

class _OverRowState extends State<OverRow> {
  int overIndex = -1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (var i = 0; i < widget.keys.length; i++) {
        final box =
            widget.keys[i].currentContext?.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero);
        var over =
            (pos.dy + box.size.height) > MediaQuery.of(context).size.height;
        if (over) {
          overIndex = i;
          setState(() {});
          return;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: overIndex == -1
            ? widget.widgets
            : [
                ...widget.widgets.take(overIndex).toList(),
                Container(
                  child: Text("+${widget.widgets.skip(overIndex).length}"),
                )
              ]);
  }
}
