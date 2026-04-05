import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/post.dart';

class PostMapper {
  PostMapper._();

  static Post fromRow(PostsTableData row) {
    return Post(
      id: row.id,
      title: row.title,
      content: row.content,
      link: row.link,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
    );
  }

  /// id is omitted — autoIncrement assigns it on insert.
  static PostsTableCompanion toCompanion(Post post) {
    return PostsTableCompanion.insert(
      title: post.title,
      content: post.content,
      link: post.link,
      createdAt: post.createdAt.millisecondsSinceEpoch,
    );
  }
}
