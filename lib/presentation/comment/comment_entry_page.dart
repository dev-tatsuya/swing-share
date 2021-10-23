import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/comment/comment_list.dart';
import 'package:swing_share/util/color.dart';
import 'package:swing_share/util/string.dart';

class CommentEntryPage extends StatefulWidget {
  const CommentEntryPage(this.post, {Key? key}) : super(key: key);

  final Post post;

  @override
  _CommentEntryPageState createState() => _CommentEntryPageState();
}

class _CommentEntryPageState extends State<CommentEntryPage> {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColor.dark!.withOpacity(0.5),
        elevation: 1,
        toolbarHeight: 44,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: Container(
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: GestureDetector(
                onTap: () async {
                  print('comment body: $_body');
                  Navigator.pop(context);
                },
                child: const Center(child: Text('投稿')),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            if (Platform.isIOS) const SizedBox(height: 44),
            const SizedBox(height: 44),
            CommentList(posts: [widget.post]), // todo change
            TextField(
              style: const TextStyle(fontSize: 16.4),
              autofocus: true,
              cursorColor: Colors.blueGrey,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 20,
              controller: _ctrl,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }
}
