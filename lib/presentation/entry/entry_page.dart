import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/presentation/common/widget/send_button.dart';
import 'package:swing_share/presentation/entry/entry_view_model.dart';
import 'package:swing_share/util/color.dart';
import 'package:swing_share/util/string.dart';

class EntryPage extends ConsumerStatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  late TextEditingController _ctrl;
  String get _body => trimLastBlankLine(_ctrl.text);

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
        backgroundColor: AppColor.dark,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: SendButton(
                disabled: _body.isEmpty,
                onTap: () async {
                  await ref.read(entryVm).post(_body);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
        toolbarHeight: 44,
      ),
      body: TextField(
        style: const TextStyle(fontSize: 16.4),
        autofocus: true,
        cursorColor: Colors.blueGrey,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 10,
        controller: _ctrl,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}
