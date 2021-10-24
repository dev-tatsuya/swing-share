import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/infra/service/auth_service_impl.dart';

class CustomPopupMenu extends ConsumerWidget {
  const CustomPopupMenu(this.post, {Key? key, this.comment}) : super(key: key);

  final Post post;
  final Comment? comment;

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authStateChangesProvider);
    late bool canDelete = false;
    if (comment == null) {
      canDelete = auth.asData?.value?.uid == post.profile.id;
    } else {
      canDelete = auth.asData?.value?.uid == comment!.profile.id ||
          auth.asData?.value?.uid == post.profile.id;
    }

    return SizedBox(
      width: 24,
      height: 24,
      child: PopupMenuButton(
        icon: const Icon(Icons.more_horiz, size: 24, color: Colors.white60),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(0),
        itemBuilder: (context) => [
          if (canDelete)
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('削除する'), Icon(Icons.delete)],
              ),
              onTap: () async {
                if (comment == null) {
                  await ref.read(repo).deletePost(post.id ?? '');
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                } else {
                  await ref.read(repo).deleteComment(
                        post.profile.id ?? '',
                        post.id ?? '',
                        comment!.id ?? '',
                        post.decrementedCount,
                      );
                }
              },
            ),
          if (!canDelete)
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('報告する'), Icon(Icons.flag)],
              ),
            ),
        ],
      ),
    );
  }
}
