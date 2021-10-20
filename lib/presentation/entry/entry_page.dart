import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/presentation/entry/entry_view_model.dart';

class EntryPage extends ConsumerStatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  late TextEditingController _ctrl;
  String get _body => _ctrl.text;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Wrap(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Visibility(
                    visible: _body.isNotEmpty,
                    child: GestureDetector(
                      onTap: () async {
                        log('onTap: $_body');
                        await ref.read(entryVm).post(_body);
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          '投稿',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        toolbarHeight: 44,
      ),
      body: TextField(
        autofocus: true,
        cursorColor: Colors.blueGrey,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 10,
        controller: _ctrl,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}
