import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;

import '../../../../core/database/app_database.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/i_post_repository.dart';
import '../mappers/post_mapper.dart';

class PostRepository implements IPostRepository {
  const PostRepository(this._db);

  final AppDatabase _db;

  static const _feedUrl = 'https://www.tabornistvo.si/feed/';

  @override
  Future<Post?> getCached() async {
    final row = await (_db.select(_db.postsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : PostMapper.fromRow(row);
  }

  @override
  Future<Post?> fetchRemote() async {
    try {
      final response = await http.get(Uri.parse(_feedUrl));
      if (response.statusCode != 200) return null;
      return _parseFirstItem(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cache(Post post) async {
    await _db.delete(_db.postsTable).go();
    await _db.into(_db.postsTable).insert(PostMapper.toCompanion(post));
  }

  /// Extracts the first RSS <item> and maps it to a [Post].
  Post? _parseFirstItem(String xml) {
    final itemMatch =
        RegExp(r'<item>(.*?)</item>', dotAll: true).firstMatch(xml);
    if (itemMatch == null) return null;
    final item = itemMatch.group(1)!;

    String? extract(String tag) {
      final m = RegExp(
        '<$tag[^>]*>(?:<!\\[CDATA\\[)?(.*?)(?:\\]\\]>)?</$tag>',
        dotAll: true,
      ).firstMatch(item);
      return m?.group(1)?.trim();
    }

    final title = extract('title') ?? '';
    final content =
        extract('content:encoded') ?? extract('description') ?? '';
    final link = extract('link') ?? '';
    final pubDateStr = extract('pubDate') ?? '';
    final createdAt = _parsePubDate(pubDateStr) ?? DateTime.now();

    return Post(
      id: 0,
      title: title,
      content: content,
      link: link,
      createdAt: createdAt,
    );
  }

  /// Parses RFC 2822 pubDate: "Tue, 15 Mar 2023 12:00:00 +0000"
  DateTime? _parsePubDate(String value) {
    try {
      const months = {
        'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
        'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08',
        'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12',
      };
      final parts = value.trim().split(RegExp(r'\s+'));
      if (parts.length < 5) return null;
      final day = parts[1].padLeft(2, '0');
      final month = months[parts[2]];
      if (month == null) return null;
      final year = parts[3];
      final time = parts[4];
      return DateTime.parse('$year-$month-${day}T$time');
    } catch (_) {
      return null;
    }
  }
}
