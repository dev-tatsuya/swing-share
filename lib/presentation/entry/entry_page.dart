import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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
  late FocusNode _focusNode;
  String get _body => trimLastBlankLine(_ctrl.text);
  String? localImagePath;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.dark,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            if (localImagePath != null) {
              Directory(localImagePath!).delete(recursive: true);
            }
            Navigator.pop(context);
          },
          child: const Icon(Icons.clear),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async {
                _focusNode.unfocus();

                final file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (file == null) {
                  return;
                }
                localImagePath = file.path;
                setState(() {});
              },
              child: const Icon(Icons.add_photo_alternate),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: SendButton(
                disabled: _body.isEmpty,
                onTap: () async {
                  await ref.read(entryVm).post(_body, localImagePath);

                  if (localImagePath != null) {
                    Directory(localImagePath!).delete(recursive: true);
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
        toolbarHeight: 44,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              focusNode: _focusNode,
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
            if (localImagePath != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    File(localImagePath!),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
