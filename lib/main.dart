import 'package:flutter/material.dart';

import 'expansion_tile_copy.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

final _tileKeys = [];
var _selectedIndex = 0;

void resetExpansionTileKeysAndSelectedIndex() {
  _tileKeys.clear();
  _selectedIndex = 0;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    resetExpansionTileKeysAndSelectedIndex();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expansion Tile Demo"),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              final tileKey = GlobalKey();
              _tileKeys.add(tileKey); // <- Add tile key to [_tileKeys] list.
              return ExpansionTileCopy(
                key: tileKey, // <- Add a key to each tile.
                title: Text("Tile $index"),
                children: [
                  Container(
                      color: Colors.grey[350],
                      height: 200,
                      child: Center(
                        child: Text("Tile $index Body"),
                      ))
                ],
                onExpansionChanged: (value) {
                  // If tile is expanding, then collapse the already expanded tile.
                  if (value) {
                    if (index != _selectedIndex) {
                      _tileKeys[_selectedIndex].currentState!.closeExpansion();
                    }
                    _selectedIndex = index;
                  }
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: 100));
  }
}
