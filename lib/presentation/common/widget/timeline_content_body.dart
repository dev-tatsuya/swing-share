import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/common/widget/custom_popup_menu.dart';
import 'package:swing_share/util/color.dart';

class TimelineContentBody extends StatefulWidget {
  const TimelineContentBody(
    this.post, {
    Key? key,
    this.isWriting = false,
  }) : super(key: key);

  final Post post;
  final bool isWriting;

  @override
  State<TimelineContentBody> createState() => _TimelineContentBodyState();
}

class _TimelineContentBodyState extends State<TimelineContentBody> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.post.imagePath != null) {
      downloadImageUrl();
    }
  }

  Future<void> downloadImageUrl() async {
    imageUrl = await FirebaseStorage.instance
        .ref(widget.post.imagePath)
        .getDownloadURL();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.post.profile.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.post.createdAt.toString(),
                        style:
                            const TextStyle(fontSize: 14, color: AppColor.gray),
                      ),
                      if (!widget.isWriting) const SizedBox(width: 4),
                      if (!widget.isWriting) CustomPopupMenu(widget.post),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(widget.post.body.replaceAll('\\n', '\n')),
            ),
            if (imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
