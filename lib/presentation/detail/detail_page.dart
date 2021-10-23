import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/comment/comment_entry_page.dart';
import 'package:swing_share/presentation/comment/comment_list.dart';
import 'package:swing_share/presentation/detail/detail_view_model.dart';
import 'package:swing_share/util/color.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage(this.post, {Key? key}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
        toolbarHeight: 44,
        backgroundColor: AppColor.dark,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildBody(),
            _buildFooter(context),
            StreamBuilder<List<Post>>(
                stream: ref.watch(detailVm).commentsStream(post.id ?? ''),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CupertinoActivityIndicator();
                  }
                  return CommentList(posts: snapshot.data);
                }),
          ],
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post.profile.thumbnailPath),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
          ),
        ),
        Text(
          post.profile.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.more_horiz, size: 24, color: Colors.white60),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.body.replaceAll('\\n', '\n'),
            style: const TextStyle(fontSize: 16.4),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              post.createdAt.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.white60),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Divider(height: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => CommentEntryPage(post),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.reply, color: AppColor.gray),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    'コメントをする',
                    style: TextStyle(fontSize: 13, color: AppColor.gray),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Divider(height: 0),
        ),
      ],
    );
  }
}
