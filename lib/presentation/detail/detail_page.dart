import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/service/auth_service_impl.dart';
import 'package:swing_share/presentation/comment/comment_entry_page.dart';
import 'package:swing_share/presentation/comment/comment_list.dart';
import 'package:swing_share/presentation/common/widget/custom_popup_menu.dart';
import 'package:swing_share/presentation/detail/detail_view_model.dart';
import 'package:swing_share/presentation/login/login_sheet.dart';
import 'package:swing_share/util/color.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage(this.post, {Key? key}) : super(key: key);

  final Post post;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  void initState() {
    super.initState();
    ref
        .read(detailVm.notifier)
        .fetch(widget.post.profile.id ?? '', widget.post.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailVm);

    final auth = ref.watch(authStateChangesProvider);
    final isLogin = auth.asData?.value?.uid != null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('詳細'),
        toolbarHeight: 44,
        backgroundColor: AppColor.dark!.withOpacity(0.9),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildBody(),
              _buildFooter(context, state.comments, isLogin),
              if (state.comments.isNotEmpty)
                CommentList(widget.post, comments: state.comments),
            ],
          ),
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
                image: NetworkImage(widget.post.profile.thumbnailPath),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
          ),
        ),
        Text(
          widget.post.profile.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CustomPopupMenu(widget.post),
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
            widget.post.body.replaceAll('\\n', '\n'),
            style: const TextStyle(fontSize: 16.4),
          ),
          if (widget.post.imagePath != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.post.imagePath!,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              widget.post.createdAt.toString(),
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

  Widget _buildFooter(
      BuildContext context, List<Comment>? comments, bool isLogin) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: GestureDetector(
            onTap: () {
              if (!isLogin) {
                showLoginSheet(context);
                return;
              }

              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) =>
                      CommentEntryPage(widget.post, comments: comments),
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
