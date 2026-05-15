// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PostsTableTable extends PostsTable
    with TableInfo<$PostsTableTable, PostsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, content, link, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'posts_table';
  @override
  VerificationContext validateIntegrity(Insertable<PostsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PostsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PostsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PostsTableTable createAlias(String alias) {
    return $PostsTableTable(attachedDatabase, alias);
  }
}

class PostsTableData extends DataClass implements Insertable<PostsTableData> {
  final int id;
  final String title;
  final String content;
  final String link;

  /// Unix milliseconds.
  final int createdAt;
  const PostsTableData(
      {required this.id,
      required this.title,
      required this.content,
      required this.link,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['link'] = Variable<String>(link);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  PostsTableCompanion toCompanion(bool nullToAbsent) {
    return PostsTableCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      link: Value(link),
      createdAt: Value(createdAt),
    );
  }

  factory PostsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostsTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      link: serializer.fromJson<String>(json['link']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'link': serializer.toJson<String>(link),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  PostsTableData copyWith(
          {int? id,
          String? title,
          String? content,
          String? link,
          int? createdAt}) =>
      PostsTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        link: link ?? this.link,
        createdAt: createdAt ?? this.createdAt,
      );
  PostsTableData copyWithCompanion(PostsTableCompanion data) {
    return PostsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      link: data.link.present ? data.link.value : this.link,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('link: $link, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, link, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.link == this.link &&
          other.createdAt == this.createdAt);
}

class PostsTableCompanion extends UpdateCompanion<PostsTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> link;
  final Value<int> createdAt;
  const PostsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.link = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PostsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    required String link,
    required int createdAt,
  })  : title = Value(title),
        content = Value(content),
        link = Value(link),
        createdAt = Value(createdAt);
  static Insertable<PostsTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? link,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (link != null) 'link': link,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PostsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String>? link,
      Value<int>? createdAt}) {
    return PostsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      link: link ?? this.link,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('link: $link, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MorseExercisesTableTable extends MorseExercisesTable
    with TableInfo<$MorseExercisesTableTable, MorseExercisesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MorseExercisesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseContentType, String>
      exerciseContentType = GeneratedColumn<String>(
              'exercise_content_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ExerciseContentType>(
              $MorseExercisesTableTable.$converterexerciseContentType);
  @override
  late final GeneratedColumnWithTypeConverter<TranslationDirection, String>
      translateType = GeneratedColumn<String>(
              'translate_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TranslationDirection>(
              $MorseExercisesTableTable.$convertertranslateType);
  static const VerificationMeta _exerciseValuesMeta =
      const VerificationMeta('exerciseValues');
  @override
  late final GeneratedColumn<String> exerciseValues = GeneratedColumn<String>(
      'exercise_values', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _translatedValuesMeta =
      const VerificationMeta('translatedValues');
  @override
  late final GeneratedColumn<String> translatedValues = GeneratedColumn<String>(
      'translated_values', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<InteractionType, String>
      interactionType = GeneratedColumn<String>(
              'interaction_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InteractionType>(
              $MorseExercisesTableTable.$converterinteractionType);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        exerciseContentType,
        translateType,
        exerciseValues,
        translatedValues,
        count,
        interactionType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'morse_exercises_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MorseExercisesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_values')) {
      context.handle(
          _exerciseValuesMeta,
          exerciseValues.isAcceptableOrUnknown(
              data['exercise_values']!, _exerciseValuesMeta));
    } else if (isInserting) {
      context.missing(_exerciseValuesMeta);
    }
    if (data.containsKey('translated_values')) {
      context.handle(
          _translatedValuesMeta,
          translatedValues.isAcceptableOrUnknown(
              data['translated_values']!, _translatedValuesMeta));
    } else if (isInserting) {
      context.missing(_translatedValuesMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MorseExercisesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MorseExercisesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseContentType: $MorseExercisesTableTable
          .$converterexerciseContentType
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}exercise_content_type'])!),
      translateType: $MorseExercisesTableTable.$convertertranslateType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translate_type'])!),
      exerciseValues: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}exercise_values'])!,
      translatedValues: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}translated_values'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      interactionType: $MorseExercisesTableTable.$converterinteractionType
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}interaction_type'])!),
    );
  }

  @override
  $MorseExercisesTableTable createAlias(String alias) {
    return $MorseExercisesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExerciseContentType, String, String>
      $converterexerciseContentType =
      const EnumNameConverter<ExerciseContentType>(ExerciseContentType.values);
  static JsonTypeConverter2<TranslationDirection, String, String>
      $convertertranslateType = const EnumNameConverter<TranslationDirection>(
          TranslationDirection.values);
  static JsonTypeConverter2<InteractionType, String, String>
      $converterinteractionType =
      const EnumNameConverter<InteractionType>(InteractionType.values);
}

class MorseExercisesTableData extends DataClass
    implements Insertable<MorseExercisesTableData> {
  final int id;
  final ExerciseContentType exerciseContentType;
  final TranslationDirection translateType;
  final String exerciseValues;

  /// JSON array of strings.
  final String translatedValues;
  final int count;
  final InteractionType interactionType;
  const MorseExercisesTableData(
      {required this.id,
      required this.exerciseContentType,
      required this.translateType,
      required this.exerciseValues,
      required this.translatedValues,
      required this.count,
      required this.interactionType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['exercise_content_type'] = Variable<String>($MorseExercisesTableTable
          .$converterexerciseContentType
          .toSql(exerciseContentType));
    }
    {
      map['translate_type'] = Variable<String>($MorseExercisesTableTable
          .$convertertranslateType
          .toSql(translateType));
    }
    map['exercise_values'] = Variable<String>(exerciseValues);
    map['translated_values'] = Variable<String>(translatedValues);
    map['count'] = Variable<int>(count);
    {
      map['interaction_type'] = Variable<String>($MorseExercisesTableTable
          .$converterinteractionType
          .toSql(interactionType));
    }
    return map;
  }

  MorseExercisesTableCompanion toCompanion(bool nullToAbsent) {
    return MorseExercisesTableCompanion(
      id: Value(id),
      exerciseContentType: Value(exerciseContentType),
      translateType: Value(translateType),
      exerciseValues: Value(exerciseValues),
      translatedValues: Value(translatedValues),
      count: Value(count),
      interactionType: Value(interactionType),
    );
  }

  factory MorseExercisesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MorseExercisesTableData(
      id: serializer.fromJson<int>(json['id']),
      exerciseContentType: $MorseExercisesTableTable
          .$converterexerciseContentType
          .fromJson(serializer.fromJson<String>(json['exerciseContentType'])),
      translateType: $MorseExercisesTableTable.$convertertranslateType
          .fromJson(serializer.fromJson<String>(json['translateType'])),
      exerciseValues: serializer.fromJson<String>(json['exerciseValues']),
      translatedValues: serializer.fromJson<String>(json['translatedValues']),
      count: serializer.fromJson<int>(json['count']),
      interactionType: $MorseExercisesTableTable.$converterinteractionType
          .fromJson(serializer.fromJson<String>(json['interactionType'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseContentType': serializer.toJson<String>($MorseExercisesTableTable
          .$converterexerciseContentType
          .toJson(exerciseContentType)),
      'translateType': serializer.toJson<String>($MorseExercisesTableTable
          .$convertertranslateType
          .toJson(translateType)),
      'exerciseValues': serializer.toJson<String>(exerciseValues),
      'translatedValues': serializer.toJson<String>(translatedValues),
      'count': serializer.toJson<int>(count),
      'interactionType': serializer.toJson<String>($MorseExercisesTableTable
          .$converterinteractionType
          .toJson(interactionType)),
    };
  }

  MorseExercisesTableData copyWith(
          {int? id,
          ExerciseContentType? exerciseContentType,
          TranslationDirection? translateType,
          String? exerciseValues,
          String? translatedValues,
          int? count,
          InteractionType? interactionType}) =>
      MorseExercisesTableData(
        id: id ?? this.id,
        exerciseContentType: exerciseContentType ?? this.exerciseContentType,
        translateType: translateType ?? this.translateType,
        exerciseValues: exerciseValues ?? this.exerciseValues,
        translatedValues: translatedValues ?? this.translatedValues,
        count: count ?? this.count,
        interactionType: interactionType ?? this.interactionType,
      );
  MorseExercisesTableData copyWithCompanion(MorseExercisesTableCompanion data) {
    return MorseExercisesTableData(
      id: data.id.present ? data.id.value : this.id,
      exerciseContentType: data.exerciseContentType.present
          ? data.exerciseContentType.value
          : this.exerciseContentType,
      translateType: data.translateType.present
          ? data.translateType.value
          : this.translateType,
      exerciseValues: data.exerciseValues.present
          ? data.exerciseValues.value
          : this.exerciseValues,
      translatedValues: data.translatedValues.present
          ? data.translatedValues.value
          : this.translatedValues,
      count: data.count.present ? data.count.value : this.count,
      interactionType: data.interactionType.present
          ? data.interactionType.value
          : this.interactionType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MorseExercisesTableData(')
          ..write('id: $id, ')
          ..write('exerciseContentType: $exerciseContentType, ')
          ..write('translateType: $translateType, ')
          ..write('exerciseValues: $exerciseValues, ')
          ..write('translatedValues: $translatedValues, ')
          ..write('count: $count, ')
          ..write('interactionType: $interactionType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseContentType, translateType,
      exerciseValues, translatedValues, count, interactionType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MorseExercisesTableData &&
          other.id == this.id &&
          other.exerciseContentType == this.exerciseContentType &&
          other.translateType == this.translateType &&
          other.exerciseValues == this.exerciseValues &&
          other.translatedValues == this.translatedValues &&
          other.count == this.count &&
          other.interactionType == this.interactionType);
}

class MorseExercisesTableCompanion
    extends UpdateCompanion<MorseExercisesTableData> {
  final Value<int> id;
  final Value<ExerciseContentType> exerciseContentType;
  final Value<TranslationDirection> translateType;
  final Value<String> exerciseValues;
  final Value<String> translatedValues;
  final Value<int> count;
  final Value<InteractionType> interactionType;
  const MorseExercisesTableCompanion({
    this.id = const Value.absent(),
    this.exerciseContentType = const Value.absent(),
    this.translateType = const Value.absent(),
    this.exerciseValues = const Value.absent(),
    this.translatedValues = const Value.absent(),
    this.count = const Value.absent(),
    this.interactionType = const Value.absent(),
  });
  MorseExercisesTableCompanion.insert({
    this.id = const Value.absent(),
    required ExerciseContentType exerciseContentType,
    required TranslationDirection translateType,
    required String exerciseValues,
    required String translatedValues,
    required int count,
    required InteractionType interactionType,
  })  : exerciseContentType = Value(exerciseContentType),
        translateType = Value(translateType),
        exerciseValues = Value(exerciseValues),
        translatedValues = Value(translatedValues),
        count = Value(count),
        interactionType = Value(interactionType);
  static Insertable<MorseExercisesTableData> custom({
    Expression<int>? id,
    Expression<String>? exerciseContentType,
    Expression<String>? translateType,
    Expression<String>? exerciseValues,
    Expression<String>? translatedValues,
    Expression<int>? count,
    Expression<String>? interactionType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseContentType != null)
        'exercise_content_type': exerciseContentType,
      if (translateType != null) 'translate_type': translateType,
      if (exerciseValues != null) 'exercise_values': exerciseValues,
      if (translatedValues != null) 'translated_values': translatedValues,
      if (count != null) 'count': count,
      if (interactionType != null) 'interaction_type': interactionType,
    });
  }

  MorseExercisesTableCompanion copyWith(
      {Value<int>? id,
      Value<ExerciseContentType>? exerciseContentType,
      Value<TranslationDirection>? translateType,
      Value<String>? exerciseValues,
      Value<String>? translatedValues,
      Value<int>? count,
      Value<InteractionType>? interactionType}) {
    return MorseExercisesTableCompanion(
      id: id ?? this.id,
      exerciseContentType: exerciseContentType ?? this.exerciseContentType,
      translateType: translateType ?? this.translateType,
      exerciseValues: exerciseValues ?? this.exerciseValues,
      translatedValues: translatedValues ?? this.translatedValues,
      count: count ?? this.count,
      interactionType: interactionType ?? this.interactionType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseContentType.present) {
      map['exercise_content_type'] = Variable<String>($MorseExercisesTableTable
          .$converterexerciseContentType
          .toSql(exerciseContentType.value));
    }
    if (translateType.present) {
      map['translate_type'] = Variable<String>($MorseExercisesTableTable
          .$convertertranslateType
          .toSql(translateType.value));
    }
    if (exerciseValues.present) {
      map['exercise_values'] = Variable<String>(exerciseValues.value);
    }
    if (translatedValues.present) {
      map['translated_values'] = Variable<String>(translatedValues.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (interactionType.present) {
      map['interaction_type'] = Variable<String>($MorseExercisesTableTable
          .$converterinteractionType
          .toSql(interactionType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MorseExercisesTableCompanion(')
          ..write('id: $id, ')
          ..write('exerciseContentType: $exerciseContentType, ')
          ..write('translateType: $translateType, ')
          ..write('exerciseValues: $exerciseValues, ')
          ..write('translatedValues: $translatedValues, ')
          ..write('count: $count, ')
          ..write('interactionType: $interactionType')
          ..write(')'))
        .toString();
  }
}

class $SemaphoreExercisesTableTable extends SemaphoreExercisesTable
    with TableInfo<$SemaphoreExercisesTableTable, SemaphoreExercisesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemaphoreExercisesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseContentType, String>
      exerciseContentType = GeneratedColumn<String>(
              'exercise_content_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ExerciseContentType>(
              $SemaphoreExercisesTableTable.$converterexerciseContentType);
  @override
  late final GeneratedColumnWithTypeConverter<TranslationDirection, String>
      translateType = GeneratedColumn<String>(
              'translate_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TranslationDirection>(
              $SemaphoreExercisesTableTable.$convertertranslateType);
  static const VerificationMeta _exerciseValuesMeta =
      const VerificationMeta('exerciseValues');
  @override
  late final GeneratedColumn<String> exerciseValues = GeneratedColumn<String>(
      'exercise_values', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _translatedValuesMeta =
      const VerificationMeta('translatedValues');
  @override
  late final GeneratedColumn<String> translatedValues = GeneratedColumn<String>(
      'translated_values', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<InteractionType, String>
      interactionType = GeneratedColumn<String>(
              'interaction_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InteractionType>(
              $SemaphoreExercisesTableTable.$converterinteractionType);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        exerciseContentType,
        translateType,
        exerciseValues,
        translatedValues,
        count,
        interactionType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semaphore_exercises_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SemaphoreExercisesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_values')) {
      context.handle(
          _exerciseValuesMeta,
          exerciseValues.isAcceptableOrUnknown(
              data['exercise_values']!, _exerciseValuesMeta));
    } else if (isInserting) {
      context.missing(_exerciseValuesMeta);
    }
    if (data.containsKey('translated_values')) {
      context.handle(
          _translatedValuesMeta,
          translatedValues.isAcceptableOrUnknown(
              data['translated_values']!, _translatedValuesMeta));
    } else if (isInserting) {
      context.missing(_translatedValuesMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SemaphoreExercisesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SemaphoreExercisesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseContentType: $SemaphoreExercisesTableTable
          .$converterexerciseContentType
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}exercise_content_type'])!),
      translateType: $SemaphoreExercisesTableTable.$convertertranslateType
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}translate_type'])!),
      exerciseValues: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}exercise_values'])!,
      translatedValues: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}translated_values'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      interactionType: $SemaphoreExercisesTableTable.$converterinteractionType
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}interaction_type'])!),
    );
  }

  @override
  $SemaphoreExercisesTableTable createAlias(String alias) {
    return $SemaphoreExercisesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExerciseContentType, String, String>
      $converterexerciseContentType =
      const EnumNameConverter<ExerciseContentType>(ExerciseContentType.values);
  static JsonTypeConverter2<TranslationDirection, String, String>
      $convertertranslateType = const EnumNameConverter<TranslationDirection>(
          TranslationDirection.values);
  static JsonTypeConverter2<InteractionType, String, String>
      $converterinteractionType =
      const EnumNameConverter<InteractionType>(InteractionType.values);
}

class SemaphoreExercisesTableData extends DataClass
    implements Insertable<SemaphoreExercisesTableData> {
  final int id;
  final ExerciseContentType exerciseContentType;
  final TranslationDirection translateType;
  final String exerciseValues;

  /// JSON array of strings.
  final String translatedValues;
  final int count;
  final InteractionType interactionType;
  const SemaphoreExercisesTableData(
      {required this.id,
      required this.exerciseContentType,
      required this.translateType,
      required this.exerciseValues,
      required this.translatedValues,
      required this.count,
      required this.interactionType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['exercise_content_type'] = Variable<String>(
          $SemaphoreExercisesTableTable.$converterexerciseContentType
              .toSql(exerciseContentType));
    }
    {
      map['translate_type'] = Variable<String>($SemaphoreExercisesTableTable
          .$convertertranslateType
          .toSql(translateType));
    }
    map['exercise_values'] = Variable<String>(exerciseValues);
    map['translated_values'] = Variable<String>(translatedValues);
    map['count'] = Variable<int>(count);
    {
      map['interaction_type'] = Variable<String>($SemaphoreExercisesTableTable
          .$converterinteractionType
          .toSql(interactionType));
    }
    return map;
  }

  SemaphoreExercisesTableCompanion toCompanion(bool nullToAbsent) {
    return SemaphoreExercisesTableCompanion(
      id: Value(id),
      exerciseContentType: Value(exerciseContentType),
      translateType: Value(translateType),
      exerciseValues: Value(exerciseValues),
      translatedValues: Value(translatedValues),
      count: Value(count),
      interactionType: Value(interactionType),
    );
  }

  factory SemaphoreExercisesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SemaphoreExercisesTableData(
      id: serializer.fromJson<int>(json['id']),
      exerciseContentType: $SemaphoreExercisesTableTable
          .$converterexerciseContentType
          .fromJson(serializer.fromJson<String>(json['exerciseContentType'])),
      translateType: $SemaphoreExercisesTableTable.$convertertranslateType
          .fromJson(serializer.fromJson<String>(json['translateType'])),
      exerciseValues: serializer.fromJson<String>(json['exerciseValues']),
      translatedValues: serializer.fromJson<String>(json['translatedValues']),
      count: serializer.fromJson<int>(json['count']),
      interactionType: $SemaphoreExercisesTableTable.$converterinteractionType
          .fromJson(serializer.fromJson<String>(json['interactionType'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseContentType': serializer.toJson<String>(
          $SemaphoreExercisesTableTable.$converterexerciseContentType
              .toJson(exerciseContentType)),
      'translateType': serializer.toJson<String>($SemaphoreExercisesTableTable
          .$convertertranslateType
          .toJson(translateType)),
      'exerciseValues': serializer.toJson<String>(exerciseValues),
      'translatedValues': serializer.toJson<String>(translatedValues),
      'count': serializer.toJson<int>(count),
      'interactionType': serializer.toJson<String>($SemaphoreExercisesTableTable
          .$converterinteractionType
          .toJson(interactionType)),
    };
  }

  SemaphoreExercisesTableData copyWith(
          {int? id,
          ExerciseContentType? exerciseContentType,
          TranslationDirection? translateType,
          String? exerciseValues,
          String? translatedValues,
          int? count,
          InteractionType? interactionType}) =>
      SemaphoreExercisesTableData(
        id: id ?? this.id,
        exerciseContentType: exerciseContentType ?? this.exerciseContentType,
        translateType: translateType ?? this.translateType,
        exerciseValues: exerciseValues ?? this.exerciseValues,
        translatedValues: translatedValues ?? this.translatedValues,
        count: count ?? this.count,
        interactionType: interactionType ?? this.interactionType,
      );
  SemaphoreExercisesTableData copyWithCompanion(
      SemaphoreExercisesTableCompanion data) {
    return SemaphoreExercisesTableData(
      id: data.id.present ? data.id.value : this.id,
      exerciseContentType: data.exerciseContentType.present
          ? data.exerciseContentType.value
          : this.exerciseContentType,
      translateType: data.translateType.present
          ? data.translateType.value
          : this.translateType,
      exerciseValues: data.exerciseValues.present
          ? data.exerciseValues.value
          : this.exerciseValues,
      translatedValues: data.translatedValues.present
          ? data.translatedValues.value
          : this.translatedValues,
      count: data.count.present ? data.count.value : this.count,
      interactionType: data.interactionType.present
          ? data.interactionType.value
          : this.interactionType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SemaphoreExercisesTableData(')
          ..write('id: $id, ')
          ..write('exerciseContentType: $exerciseContentType, ')
          ..write('translateType: $translateType, ')
          ..write('exerciseValues: $exerciseValues, ')
          ..write('translatedValues: $translatedValues, ')
          ..write('count: $count, ')
          ..write('interactionType: $interactionType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseContentType, translateType,
      exerciseValues, translatedValues, count, interactionType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemaphoreExercisesTableData &&
          other.id == this.id &&
          other.exerciseContentType == this.exerciseContentType &&
          other.translateType == this.translateType &&
          other.exerciseValues == this.exerciseValues &&
          other.translatedValues == this.translatedValues &&
          other.count == this.count &&
          other.interactionType == this.interactionType);
}

class SemaphoreExercisesTableCompanion
    extends UpdateCompanion<SemaphoreExercisesTableData> {
  final Value<int> id;
  final Value<ExerciseContentType> exerciseContentType;
  final Value<TranslationDirection> translateType;
  final Value<String> exerciseValues;
  final Value<String> translatedValues;
  final Value<int> count;
  final Value<InteractionType> interactionType;
  const SemaphoreExercisesTableCompanion({
    this.id = const Value.absent(),
    this.exerciseContentType = const Value.absent(),
    this.translateType = const Value.absent(),
    this.exerciseValues = const Value.absent(),
    this.translatedValues = const Value.absent(),
    this.count = const Value.absent(),
    this.interactionType = const Value.absent(),
  });
  SemaphoreExercisesTableCompanion.insert({
    this.id = const Value.absent(),
    required ExerciseContentType exerciseContentType,
    required TranslationDirection translateType,
    required String exerciseValues,
    required String translatedValues,
    required int count,
    required InteractionType interactionType,
  })  : exerciseContentType = Value(exerciseContentType),
        translateType = Value(translateType),
        exerciseValues = Value(exerciseValues),
        translatedValues = Value(translatedValues),
        count = Value(count),
        interactionType = Value(interactionType);
  static Insertable<SemaphoreExercisesTableData> custom({
    Expression<int>? id,
    Expression<String>? exerciseContentType,
    Expression<String>? translateType,
    Expression<String>? exerciseValues,
    Expression<String>? translatedValues,
    Expression<int>? count,
    Expression<String>? interactionType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseContentType != null)
        'exercise_content_type': exerciseContentType,
      if (translateType != null) 'translate_type': translateType,
      if (exerciseValues != null) 'exercise_values': exerciseValues,
      if (translatedValues != null) 'translated_values': translatedValues,
      if (count != null) 'count': count,
      if (interactionType != null) 'interaction_type': interactionType,
    });
  }

  SemaphoreExercisesTableCompanion copyWith(
      {Value<int>? id,
      Value<ExerciseContentType>? exerciseContentType,
      Value<TranslationDirection>? translateType,
      Value<String>? exerciseValues,
      Value<String>? translatedValues,
      Value<int>? count,
      Value<InteractionType>? interactionType}) {
    return SemaphoreExercisesTableCompanion(
      id: id ?? this.id,
      exerciseContentType: exerciseContentType ?? this.exerciseContentType,
      translateType: translateType ?? this.translateType,
      exerciseValues: exerciseValues ?? this.exerciseValues,
      translatedValues: translatedValues ?? this.translatedValues,
      count: count ?? this.count,
      interactionType: interactionType ?? this.interactionType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseContentType.present) {
      map['exercise_content_type'] = Variable<String>(
          $SemaphoreExercisesTableTable.$converterexerciseContentType
              .toSql(exerciseContentType.value));
    }
    if (translateType.present) {
      map['translate_type'] = Variable<String>($SemaphoreExercisesTableTable
          .$convertertranslateType
          .toSql(translateType.value));
    }
    if (exerciseValues.present) {
      map['exercise_values'] = Variable<String>(exerciseValues.value);
    }
    if (translatedValues.present) {
      map['translated_values'] = Variable<String>(translatedValues.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (interactionType.present) {
      map['interaction_type'] = Variable<String>($SemaphoreExercisesTableTable
          .$converterinteractionType
          .toSql(interactionType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemaphoreExercisesTableCompanion(')
          ..write('id: $id, ')
          ..write('exerciseContentType: $exerciseContentType, ')
          ..write('translateType: $translateType, ')
          ..write('exerciseValues: $exerciseValues, ')
          ..write('translatedValues: $translatedValues, ')
          ..write('count: $count, ')
          ..write('interactionType: $interactionType')
          ..write(')'))
        .toString();
  }
}

class $OrientationSignsTableTable extends OrientationSignsTable
    with TableInfo<$OrientationSignsTableTable, OrientationSignsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrientationSignsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageLocMeta =
      const VerificationMeta('imageLoc');
  @override
  late final GeneratedColumn<String> imageLoc = GeneratedColumn<String>(
      'image_loc', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TopoGroupType, String>
      topoGroupType = GeneratedColumn<String>(
              'topo_group_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TopoGroupType>(
              $OrientationSignsTableTable.$convertertopoGroupType);
  @override
  List<GeneratedColumn> get $columns => [id, name, imageLoc, topoGroupType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orientation_signs_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<OrientationSignsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_loc')) {
      context.handle(_imageLocMeta,
          imageLoc.isAcceptableOrUnknown(data['image_loc']!, _imageLocMeta));
    } else if (isInserting) {
      context.missing(_imageLocMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrientationSignsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrientationSignsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      imageLoc: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_loc'])!,
      topoGroupType: $OrientationSignsTableTable.$convertertopoGroupType
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}topo_group_type'])!),
    );
  }

  @override
  $OrientationSignsTableTable createAlias(String alias) {
    return $OrientationSignsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TopoGroupType, String, String>
      $convertertopoGroupType =
      const EnumNameConverter<TopoGroupType>(TopoGroupType.values);
}

class OrientationSignsTableData extends DataClass
    implements Insertable<OrientationSignsTableData> {
  final int id;
  final String name;
  final String imageLoc;
  final TopoGroupType topoGroupType;
  const OrientationSignsTableData(
      {required this.id,
      required this.name,
      required this.imageLoc,
      required this.topoGroupType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_loc'] = Variable<String>(imageLoc);
    {
      map['topo_group_type'] = Variable<String>($OrientationSignsTableTable
          .$convertertopoGroupType
          .toSql(topoGroupType));
    }
    return map;
  }

  OrientationSignsTableCompanion toCompanion(bool nullToAbsent) {
    return OrientationSignsTableCompanion(
      id: Value(id),
      name: Value(name),
      imageLoc: Value(imageLoc),
      topoGroupType: Value(topoGroupType),
    );
  }

  factory OrientationSignsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrientationSignsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageLoc: serializer.fromJson<String>(json['imageLoc']),
      topoGroupType: $OrientationSignsTableTable.$convertertopoGroupType
          .fromJson(serializer.fromJson<String>(json['topoGroupType'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageLoc': serializer.toJson<String>(imageLoc),
      'topoGroupType': serializer.toJson<String>($OrientationSignsTableTable
          .$convertertopoGroupType
          .toJson(topoGroupType)),
    };
  }

  OrientationSignsTableData copyWith(
          {int? id,
          String? name,
          String? imageLoc,
          TopoGroupType? topoGroupType}) =>
      OrientationSignsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        imageLoc: imageLoc ?? this.imageLoc,
        topoGroupType: topoGroupType ?? this.topoGroupType,
      );
  OrientationSignsTableData copyWithCompanion(
      OrientationSignsTableCompanion data) {
    return OrientationSignsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageLoc: data.imageLoc.present ? data.imageLoc.value : this.imageLoc,
      topoGroupType: data.topoGroupType.present
          ? data.topoGroupType.value
          : this.topoGroupType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrientationSignsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageLoc: $imageLoc, ')
          ..write('topoGroupType: $topoGroupType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imageLoc, topoGroupType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrientationSignsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageLoc == this.imageLoc &&
          other.topoGroupType == this.topoGroupType);
}

class OrientationSignsTableCompanion
    extends UpdateCompanion<OrientationSignsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageLoc;
  final Value<TopoGroupType> topoGroupType;
  const OrientationSignsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageLoc = const Value.absent(),
    this.topoGroupType = const Value.absent(),
  });
  OrientationSignsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageLoc,
    required TopoGroupType topoGroupType,
  })  : name = Value(name),
        imageLoc = Value(imageLoc),
        topoGroupType = Value(topoGroupType);
  static Insertable<OrientationSignsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageLoc,
    Expression<String>? topoGroupType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageLoc != null) 'image_loc': imageLoc,
      if (topoGroupType != null) 'topo_group_type': topoGroupType,
    });
  }

  OrientationSignsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? imageLoc,
      Value<TopoGroupType>? topoGroupType}) {
    return OrientationSignsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageLoc: imageLoc ?? this.imageLoc,
      topoGroupType: topoGroupType ?? this.topoGroupType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageLoc.present) {
      map['image_loc'] = Variable<String>(imageLoc.value);
    }
    if (topoGroupType.present) {
      map['topo_group_type'] = Variable<String>($OrientationSignsTableTable
          .$convertertopoGroupType
          .toSql(topoGroupType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrientationSignsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageLoc: $imageLoc, ')
          ..write('topoGroupType: $topoGroupType')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTableTable extends UserPreferencesTable
    with TableInfo<$UserPreferencesTableTable, UserPreferencesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<AppThemeMode, String> themeMode =
      GeneratedColumn<String>('theme_mode', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('dark'))
          .withConverter<AppThemeMode>(
              $UserPreferencesTableTable.$converterthemeMode);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarIdMeta =
      const VerificationMeta('avatarId');
  @override
  late final GeneratedColumn<String> avatarId = GeneratedColumn<String>(
      'avatar_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _onboardingSeenMeta =
      const VerificationMeta('onboardingSeen');
  @override
  late final GeneratedColumn<bool> onboardingSeen = GeneratedColumn<bool>(
      'onboarding_seen', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_seen" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, themeMode, username, role, avatarId, onboardingSeen];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserPreferencesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('avatar_id')) {
      context.handle(_avatarIdMeta,
          avatarId.isAcceptableOrUnknown(data['avatar_id']!, _avatarIdMeta));
    }
    if (data.containsKey('onboarding_seen')) {
      context.handle(
          _onboardingSeenMeta,
          onboardingSeen.isAcceptableOrUnknown(
              data['onboarding_seen']!, _onboardingSeenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreferencesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferencesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      themeMode: $UserPreferencesTableTable.$converterthemeMode.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}theme_mode'])!),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
      avatarId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_id']),
      onboardingSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}onboarding_seen'])!,
    );
  }

  @override
  $UserPreferencesTableTable createAlias(String alias) {
    return $UserPreferencesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppThemeMode, String, String> $converterthemeMode =
      const EnumNameConverter<AppThemeMode>(AppThemeMode.values);
}

class UserPreferencesTableData extends DataClass
    implements Insertable<UserPreferencesTableData> {
  final int id;
  final AppThemeMode themeMode;
  final String? username;
  final String? role;
  final String? avatarId;
  final bool onboardingSeen;
  const UserPreferencesTableData(
      {required this.id,
      required this.themeMode,
      this.username,
      this.role,
      this.avatarId,
      required this.onboardingSeen});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['theme_mode'] = Variable<String>(
          $UserPreferencesTableTable.$converterthemeMode.toSql(themeMode));
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || avatarId != null) {
      map['avatar_id'] = Variable<String>(avatarId);
    }
    map['onboarding_seen'] = Variable<bool>(onboardingSeen);
    return map;
  }

  UserPreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      avatarId: avatarId == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarId),
      onboardingSeen: Value(onboardingSeen),
    );
  }

  factory UserPreferencesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferencesTableData(
      id: serializer.fromJson<int>(json['id']),
      themeMode: $UserPreferencesTableTable.$converterthemeMode
          .fromJson(serializer.fromJson<String>(json['themeMode'])),
      username: serializer.fromJson<String?>(json['username']),
      role: serializer.fromJson<String?>(json['role']),
      avatarId: serializer.fromJson<String?>(json['avatarId']),
      onboardingSeen: serializer.fromJson<bool>(json['onboardingSeen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(
          $UserPreferencesTableTable.$converterthemeMode.toJson(themeMode)),
      'username': serializer.toJson<String?>(username),
      'role': serializer.toJson<String?>(role),
      'avatarId': serializer.toJson<String?>(avatarId),
      'onboardingSeen': serializer.toJson<bool>(onboardingSeen),
    };
  }

  UserPreferencesTableData copyWith(
          {int? id,
          AppThemeMode? themeMode,
          Value<String?> username = const Value.absent(),
          Value<String?> role = const Value.absent(),
          Value<String?> avatarId = const Value.absent(),
          bool? onboardingSeen}) =>
      UserPreferencesTableData(
        id: id ?? this.id,
        themeMode: themeMode ?? this.themeMode,
        username: username.present ? username.value : this.username,
        role: role.present ? role.value : this.role,
        avatarId: avatarId.present ? avatarId.value : this.avatarId,
        onboardingSeen: onboardingSeen ?? this.onboardingSeen,
      );
  UserPreferencesTableData copyWithCompanion(
      UserPreferencesTableCompanion data) {
    return UserPreferencesTableData(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      username: data.username.present ? data.username.value : this.username,
      role: data.role.present ? data.role.value : this.role,
      avatarId: data.avatarId.present ? data.avatarId.value : this.avatarId,
      onboardingSeen: data.onboardingSeen.present
          ? data.onboardingSeen.value
          : this.onboardingSeen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesTableData(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('username: $username, ')
          ..write('role: $role, ')
          ..write('avatarId: $avatarId, ')
          ..write('onboardingSeen: $onboardingSeen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, themeMode, username, role, avatarId, onboardingSeen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferencesTableData &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.username == this.username &&
          other.role == this.role &&
          other.avatarId == this.avatarId &&
          other.onboardingSeen == this.onboardingSeen);
}

class UserPreferencesTableCompanion
    extends UpdateCompanion<UserPreferencesTableData> {
  final Value<int> id;
  final Value<AppThemeMode> themeMode;
  final Value<String?> username;
  final Value<String?> role;
  final Value<String?> avatarId;
  final Value<bool> onboardingSeen;
  const UserPreferencesTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.username = const Value.absent(),
    this.role = const Value.absent(),
    this.avatarId = const Value.absent(),
    this.onboardingSeen = const Value.absent(),
  });
  UserPreferencesTableCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.username = const Value.absent(),
    this.role = const Value.absent(),
    this.avatarId = const Value.absent(),
    this.onboardingSeen = const Value.absent(),
  });
  static Insertable<UserPreferencesTableData> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<String>? username,
    Expression<String>? role,
    Expression<String>? avatarId,
    Expression<bool>? onboardingSeen,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (username != null) 'username': username,
      if (role != null) 'role': role,
      if (avatarId != null) 'avatar_id': avatarId,
      if (onboardingSeen != null) 'onboarding_seen': onboardingSeen,
    });
  }

  UserPreferencesTableCompanion copyWith(
      {Value<int>? id,
      Value<AppThemeMode>? themeMode,
      Value<String?>? username,
      Value<String?>? role,
      Value<String?>? avatarId,
      Value<bool>? onboardingSeen}) {
    return UserPreferencesTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      username: username ?? this.username,
      role: role ?? this.role,
      avatarId: avatarId ?? this.avatarId,
      onboardingSeen: onboardingSeen ?? this.onboardingSeen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>($UserPreferencesTableTable
          .$converterthemeMode
          .toSql(themeMode.value));
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (avatarId.present) {
      map['avatar_id'] = Variable<String>(avatarId.value);
    }
    if (onboardingSeen.present) {
      map['onboarding_seen'] = Variable<bool>(onboardingSeen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesTableCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('username: $username, ')
          ..write('role: $role, ')
          ..write('avatarId: $avatarId, ')
          ..write('onboardingSeen: $onboardingSeen')
          ..write(')'))
        .toString();
  }
}

class $ExerciseHistoryTableTable extends ExerciseHistoryTable
    with TableInfo<$ExerciseHistoryTableTable, ExerciseHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<FeatureType, String> featureType =
      GeneratedColumn<String>('feature_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<FeatureType>(
              $ExerciseHistoryTableTable.$converterfeatureType);
  static const VerificationMeta _exerciseContentTypeMeta =
      const VerificationMeta('exerciseContentType');
  @override
  late final GeneratedColumn<String> exerciseContentType =
      GeneratedColumn<String>('exercise_content_type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _interactionTypeMeta =
      const VerificationMeta('interactionType');
  @override
  late final GeneratedColumn<String> interactionType = GeneratedColumn<String>(
      'interaction_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalQuestionsMeta =
      const VerificationMeta('totalQuestions');
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
      'total_questions', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _correctCountMeta =
      const VerificationMeta('correctCount');
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
      'correct_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sessionDateMeta =
      const VerificationMeta('sessionDate');
  @override
  late final GeneratedColumn<int> sessionDate = GeneratedColumn<int>(
      'session_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        featureType,
        exerciseContentType,
        interactionType,
        totalQuestions,
        correctCount,
        sessionDate,
        durationSeconds
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExerciseHistoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_content_type')) {
      context.handle(
          _exerciseContentTypeMeta,
          exerciseContentType.isAcceptableOrUnknown(
              data['exercise_content_type']!, _exerciseContentTypeMeta));
    } else if (isInserting) {
      context.missing(_exerciseContentTypeMeta);
    }
    if (data.containsKey('interaction_type')) {
      context.handle(
          _interactionTypeMeta,
          interactionType.isAcceptableOrUnknown(
              data['interaction_type']!, _interactionTypeMeta));
    } else if (isInserting) {
      context.missing(_interactionTypeMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(
          _totalQuestionsMeta,
          totalQuestions.isAcceptableOrUnknown(
              data['total_questions']!, _totalQuestionsMeta));
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
          _correctCountMeta,
          correctCount.isAcceptableOrUnknown(
              data['correct_count']!, _correctCountMeta));
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('session_date')) {
      context.handle(
          _sessionDateMeta,
          sessionDate.isAcceptableOrUnknown(
              data['session_date']!, _sessionDateMeta));
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseHistoryTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseHistoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      featureType: $ExerciseHistoryTableTable.$converterfeatureType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}feature_type'])!),
      exerciseContentType: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}exercise_content_type'])!,
      interactionType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}interaction_type'])!,
      totalQuestions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_questions'])!,
      correctCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_count'])!,
      sessionDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_date'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
    );
  }

  @override
  $ExerciseHistoryTableTable createAlias(String alias) {
    return $ExerciseHistoryTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FeatureType, String, String> $converterfeatureType =
      const EnumNameConverter<FeatureType>(FeatureType.values);
}

class ExerciseHistoryTableData extends DataClass
    implements Insertable<ExerciseHistoryTableData> {
  final int id;
  final FeatureType featureType;
  final String exerciseContentType;
  final String interactionType;
  final int totalQuestions;
  final int correctCount;

  /// Unix milliseconds.
  final int sessionDate;
  final int durationSeconds;
  const ExerciseHistoryTableData(
      {required this.id,
      required this.featureType,
      required this.exerciseContentType,
      required this.interactionType,
      required this.totalQuestions,
      required this.correctCount,
      required this.sessionDate,
      required this.durationSeconds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['feature_type'] = Variable<String>(
          $ExerciseHistoryTableTable.$converterfeatureType.toSql(featureType));
    }
    map['exercise_content_type'] = Variable<String>(exerciseContentType);
    map['interaction_type'] = Variable<String>(interactionType);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['correct_count'] = Variable<int>(correctCount);
    map['session_date'] = Variable<int>(sessionDate);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    return map;
  }

  ExerciseHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseHistoryTableCompanion(
      id: Value(id),
      featureType: Value(featureType),
      exerciseContentType: Value(exerciseContentType),
      interactionType: Value(interactionType),
      totalQuestions: Value(totalQuestions),
      correctCount: Value(correctCount),
      sessionDate: Value(sessionDate),
      durationSeconds: Value(durationSeconds),
    );
  }

  factory ExerciseHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      featureType: $ExerciseHistoryTableTable.$converterfeatureType
          .fromJson(serializer.fromJson<String>(json['featureType'])),
      exerciseContentType:
          serializer.fromJson<String>(json['exerciseContentType']),
      interactionType: serializer.fromJson<String>(json['interactionType']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      sessionDate: serializer.fromJson<int>(json['sessionDate']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'featureType': serializer.toJson<String>(
          $ExerciseHistoryTableTable.$converterfeatureType.toJson(featureType)),
      'exerciseContentType': serializer.toJson<String>(exerciseContentType),
      'interactionType': serializer.toJson<String>(interactionType),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'correctCount': serializer.toJson<int>(correctCount),
      'sessionDate': serializer.toJson<int>(sessionDate),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
    };
  }

  ExerciseHistoryTableData copyWith(
          {int? id,
          FeatureType? featureType,
          String? exerciseContentType,
          String? interactionType,
          int? totalQuestions,
          int? correctCount,
          int? sessionDate,
          int? durationSeconds}) =>
      ExerciseHistoryTableData(
        id: id ?? this.id,
        featureType: featureType ?? this.featureType,
        exerciseContentType: exerciseContentType ?? this.exerciseContentType,
        interactionType: interactionType ?? this.interactionType,
        totalQuestions: totalQuestions ?? this.totalQuestions,
        correctCount: correctCount ?? this.correctCount,
        sessionDate: sessionDate ?? this.sessionDate,
        durationSeconds: durationSeconds ?? this.durationSeconds,
      );
  ExerciseHistoryTableData copyWithCompanion(
      ExerciseHistoryTableCompanion data) {
    return ExerciseHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      featureType:
          data.featureType.present ? data.featureType.value : this.featureType,
      exerciseContentType: data.exerciseContentType.present
          ? data.exerciseContentType.value
          : this.exerciseContentType,
      interactionType: data.interactionType.present
          ? data.interactionType.value
          : this.interactionType,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      sessionDate:
          data.sessionDate.present ? data.sessionDate.value : this.sessionDate,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseHistoryTableData(')
          ..write('id: $id, ')
          ..write('featureType: $featureType, ')
          ..write('exerciseContentType: $exerciseContentType, ')
          ..write('interactionType: $interactionType, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctCount: $correctCount, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      featureType,
      exerciseContentType,
      interactionType,
      totalQuestions,
      correctCount,
      sessionDate,
      durationSeconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseHistoryTableData &&
          other.id == this.id &&
          other.featureType == this.featureType &&
          other.exerciseContentType == this.exerciseContentType &&
          other.interactionType == this.interactionType &&
          other.totalQuestions == this.totalQuestions &&
          other.correctCount == this.correctCount &&
          other.sessionDate == this.sessionDate &&
          other.durationSeconds == this.durationSeconds);
}

class ExerciseHistoryTableCompanion
    extends UpdateCompanion<ExerciseHistoryTableData> {
  final Value<int> id;
  final Value<FeatureType> featureType;
  final Value<String> exerciseContentType;
  final Value<String> interactionType;
  final Value<int> totalQuestions;
  final Value<int> correctCount;
  final Value<int> sessionDate;
  final Value<int> durationSeconds;
  const ExerciseHistoryTableCompanion({
    this.id = const Value.absent(),
    this.featureType = const Value.absent(),
    this.exerciseContentType = const Value.absent(),
    this.interactionType = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.durationSeconds = const Value.absent(),
  });
  ExerciseHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required FeatureType featureType,
    required String exerciseContentType,
    required String interactionType,
    required int totalQuestions,
    required int correctCount,
    required int sessionDate,
    required int durationSeconds,
  })  : featureType = Value(featureType),
        exerciseContentType = Value(exerciseContentType),
        interactionType = Value(interactionType),
        totalQuestions = Value(totalQuestions),
        correctCount = Value(correctCount),
        sessionDate = Value(sessionDate),
        durationSeconds = Value(durationSeconds);
  static Insertable<ExerciseHistoryTableData> custom({
    Expression<int>? id,
    Expression<String>? featureType,
    Expression<String>? exerciseContentType,
    Expression<String>? interactionType,
    Expression<int>? totalQuestions,
    Expression<int>? correctCount,
    Expression<int>? sessionDate,
    Expression<int>? durationSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (featureType != null) 'feature_type': featureType,
      if (exerciseContentType != null)
        'exercise_content_type': exerciseContentType,
      if (interactionType != null) 'interaction_type': interactionType,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (correctCount != null) 'correct_count': correctCount,
      if (sessionDate != null) 'session_date': sessionDate,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
    });
  }

  ExerciseHistoryTableCompanion copyWith(
      {Value<int>? id,
      Value<FeatureType>? featureType,
      Value<String>? exerciseContentType,
      Value<String>? interactionType,
      Value<int>? totalQuestions,
      Value<int>? correctCount,
      Value<int>? sessionDate,
      Value<int>? durationSeconds}) {
    return ExerciseHistoryTableCompanion(
      id: id ?? this.id,
      featureType: featureType ?? this.featureType,
      exerciseContentType: exerciseContentType ?? this.exerciseContentType,
      interactionType: interactionType ?? this.interactionType,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctCount: correctCount ?? this.correctCount,
      sessionDate: sessionDate ?? this.sessionDate,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (featureType.present) {
      map['feature_type'] = Variable<String>($ExerciseHistoryTableTable
          .$converterfeatureType
          .toSql(featureType.value));
    }
    if (exerciseContentType.present) {
      map['exercise_content_type'] =
          Variable<String>(exerciseContentType.value);
    }
    if (interactionType.present) {
      map['interaction_type'] = Variable<String>(interactionType.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<int>(sessionDate.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('featureType: $featureType, ')
          ..write('exerciseContentType: $exerciseContentType, ')
          ..write('interactionType: $interactionType, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctCount: $correctCount, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PostsTableTable postsTable = $PostsTableTable(this);
  late final $MorseExercisesTableTable morseExercisesTable =
      $MorseExercisesTableTable(this);
  late final $SemaphoreExercisesTableTable semaphoreExercisesTable =
      $SemaphoreExercisesTableTable(this);
  late final $OrientationSignsTableTable orientationSignsTable =
      $OrientationSignsTableTable(this);
  late final $UserPreferencesTableTable userPreferencesTable =
      $UserPreferencesTableTable(this);
  late final $ExerciseHistoryTableTable exerciseHistoryTable =
      $ExerciseHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        postsTable,
        morseExercisesTable,
        semaphoreExercisesTable,
        orientationSignsTable,
        userPreferencesTable,
        exerciseHistoryTable
      ];
}

typedef $$PostsTableTableCreateCompanionBuilder = PostsTableCompanion Function({
  Value<int> id,
  required String title,
  required String content,
  required String link,
  required int createdAt,
});
typedef $$PostsTableTableUpdateCompanionBuilder = PostsTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> content,
  Value<String> link,
  Value<int> createdAt,
});

class $$PostsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PostsTableTable> {
  $$PostsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$PostsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PostsTableTable> {
  $$PostsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PostsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PostsTableTable> {
  $$PostsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PostsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PostsTableTable,
    PostsTableData,
    $$PostsTableTableFilterComposer,
    $$PostsTableTableOrderingComposer,
    $$PostsTableTableAnnotationComposer,
    $$PostsTableTableCreateCompanionBuilder,
    $$PostsTableTableUpdateCompanionBuilder,
    (
      PostsTableData,
      BaseReferences<_$AppDatabase, $PostsTableTable, PostsTableData>
    ),
    PostsTableData,
    PrefetchHooks Function()> {
  $$PostsTableTableTableManager(_$AppDatabase db, $PostsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> link = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
          }) =>
              PostsTableCompanion(
            id: id,
            title: title,
            content: content,
            link: link,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String content,
            required String link,
            required int createdAt,
          }) =>
              PostsTableCompanion.insert(
            id: id,
            title: title,
            content: content,
            link: link,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PostsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PostsTableTable,
    PostsTableData,
    $$PostsTableTableFilterComposer,
    $$PostsTableTableOrderingComposer,
    $$PostsTableTableAnnotationComposer,
    $$PostsTableTableCreateCompanionBuilder,
    $$PostsTableTableUpdateCompanionBuilder,
    (
      PostsTableData,
      BaseReferences<_$AppDatabase, $PostsTableTable, PostsTableData>
    ),
    PostsTableData,
    PrefetchHooks Function()>;
typedef $$MorseExercisesTableTableCreateCompanionBuilder
    = MorseExercisesTableCompanion Function({
  Value<int> id,
  required ExerciseContentType exerciseContentType,
  required TranslationDirection translateType,
  required String exerciseValues,
  required String translatedValues,
  required int count,
  required InteractionType interactionType,
});
typedef $$MorseExercisesTableTableUpdateCompanionBuilder
    = MorseExercisesTableCompanion Function({
  Value<int> id,
  Value<ExerciseContentType> exerciseContentType,
  Value<TranslationDirection> translateType,
  Value<String> exerciseValues,
  Value<String> translatedValues,
  Value<int> count,
  Value<InteractionType> interactionType,
});

class $$MorseExercisesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MorseExercisesTableTable> {
  $$MorseExercisesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ExerciseContentType, ExerciseContentType,
          String>
      get exerciseContentType => $composableBuilder(
          column: $table.exerciseContentType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TranslationDirection, TranslationDirection,
          String>
      get translateType => $composableBuilder(
          column: $table.translateType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get exerciseValues => $composableBuilder(
      column: $table.exerciseValues,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translatedValues => $composableBuilder(
      column: $table.translatedValues,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<InteractionType, InteractionType, String>
      get interactionType => $composableBuilder(
          column: $table.interactionType,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$MorseExercisesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MorseExercisesTableTable> {
  $$MorseExercisesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseContentType => $composableBuilder(
      column: $table.exerciseContentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translateType => $composableBuilder(
      column: $table.translateType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseValues => $composableBuilder(
      column: $table.exerciseValues,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translatedValues => $composableBuilder(
      column: $table.translatedValues,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interactionType => $composableBuilder(
      column: $table.interactionType,
      builder: (column) => ColumnOrderings(column));
}

class $$MorseExercisesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MorseExercisesTableTable> {
  $$MorseExercisesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExerciseContentType, String>
      get exerciseContentType => $composableBuilder(
          column: $table.exerciseContentType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TranslationDirection, String>
      get translateType => $composableBuilder(
          column: $table.translateType, builder: (column) => column);

  GeneratedColumn<String> get exerciseValues => $composableBuilder(
      column: $table.exerciseValues, builder: (column) => column);

  GeneratedColumn<String> get translatedValues => $composableBuilder(
      column: $table.translatedValues, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InteractionType, String>
      get interactionType => $composableBuilder(
          column: $table.interactionType, builder: (column) => column);
}

class $$MorseExercisesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MorseExercisesTableTable,
    MorseExercisesTableData,
    $$MorseExercisesTableTableFilterComposer,
    $$MorseExercisesTableTableOrderingComposer,
    $$MorseExercisesTableTableAnnotationComposer,
    $$MorseExercisesTableTableCreateCompanionBuilder,
    $$MorseExercisesTableTableUpdateCompanionBuilder,
    (
      MorseExercisesTableData,
      BaseReferences<_$AppDatabase, $MorseExercisesTableTable,
          MorseExercisesTableData>
    ),
    MorseExercisesTableData,
    PrefetchHooks Function()> {
  $$MorseExercisesTableTableTableManager(
      _$AppDatabase db, $MorseExercisesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MorseExercisesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MorseExercisesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MorseExercisesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<ExerciseContentType> exerciseContentType =
                const Value.absent(),
            Value<TranslationDirection> translateType = const Value.absent(),
            Value<String> exerciseValues = const Value.absent(),
            Value<String> translatedValues = const Value.absent(),
            Value<int> count = const Value.absent(),
            Value<InteractionType> interactionType = const Value.absent(),
          }) =>
              MorseExercisesTableCompanion(
            id: id,
            exerciseContentType: exerciseContentType,
            translateType: translateType,
            exerciseValues: exerciseValues,
            translatedValues: translatedValues,
            count: count,
            interactionType: interactionType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required ExerciseContentType exerciseContentType,
            required TranslationDirection translateType,
            required String exerciseValues,
            required String translatedValues,
            required int count,
            required InteractionType interactionType,
          }) =>
              MorseExercisesTableCompanion.insert(
            id: id,
            exerciseContentType: exerciseContentType,
            translateType: translateType,
            exerciseValues: exerciseValues,
            translatedValues: translatedValues,
            count: count,
            interactionType: interactionType,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MorseExercisesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MorseExercisesTableTable,
    MorseExercisesTableData,
    $$MorseExercisesTableTableFilterComposer,
    $$MorseExercisesTableTableOrderingComposer,
    $$MorseExercisesTableTableAnnotationComposer,
    $$MorseExercisesTableTableCreateCompanionBuilder,
    $$MorseExercisesTableTableUpdateCompanionBuilder,
    (
      MorseExercisesTableData,
      BaseReferences<_$AppDatabase, $MorseExercisesTableTable,
          MorseExercisesTableData>
    ),
    MorseExercisesTableData,
    PrefetchHooks Function()>;
typedef $$SemaphoreExercisesTableTableCreateCompanionBuilder
    = SemaphoreExercisesTableCompanion Function({
  Value<int> id,
  required ExerciseContentType exerciseContentType,
  required TranslationDirection translateType,
  required String exerciseValues,
  required String translatedValues,
  required int count,
  required InteractionType interactionType,
});
typedef $$SemaphoreExercisesTableTableUpdateCompanionBuilder
    = SemaphoreExercisesTableCompanion Function({
  Value<int> id,
  Value<ExerciseContentType> exerciseContentType,
  Value<TranslationDirection> translateType,
  Value<String> exerciseValues,
  Value<String> translatedValues,
  Value<int> count,
  Value<InteractionType> interactionType,
});

class $$SemaphoreExercisesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SemaphoreExercisesTableTable> {
  $$SemaphoreExercisesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ExerciseContentType, ExerciseContentType,
          String>
      get exerciseContentType => $composableBuilder(
          column: $table.exerciseContentType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TranslationDirection, TranslationDirection,
          String>
      get translateType => $composableBuilder(
          column: $table.translateType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get exerciseValues => $composableBuilder(
      column: $table.exerciseValues,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translatedValues => $composableBuilder(
      column: $table.translatedValues,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<InteractionType, InteractionType, String>
      get interactionType => $composableBuilder(
          column: $table.interactionType,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$SemaphoreExercisesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SemaphoreExercisesTableTable> {
  $$SemaphoreExercisesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseContentType => $composableBuilder(
      column: $table.exerciseContentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translateType => $composableBuilder(
      column: $table.translateType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseValues => $composableBuilder(
      column: $table.exerciseValues,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translatedValues => $composableBuilder(
      column: $table.translatedValues,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interactionType => $composableBuilder(
      column: $table.interactionType,
      builder: (column) => ColumnOrderings(column));
}

class $$SemaphoreExercisesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemaphoreExercisesTableTable> {
  $$SemaphoreExercisesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExerciseContentType, String>
      get exerciseContentType => $composableBuilder(
          column: $table.exerciseContentType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TranslationDirection, String>
      get translateType => $composableBuilder(
          column: $table.translateType, builder: (column) => column);

  GeneratedColumn<String> get exerciseValues => $composableBuilder(
      column: $table.exerciseValues, builder: (column) => column);

  GeneratedColumn<String> get translatedValues => $composableBuilder(
      column: $table.translatedValues, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InteractionType, String>
      get interactionType => $composableBuilder(
          column: $table.interactionType, builder: (column) => column);
}

class $$SemaphoreExercisesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SemaphoreExercisesTableTable,
    SemaphoreExercisesTableData,
    $$SemaphoreExercisesTableTableFilterComposer,
    $$SemaphoreExercisesTableTableOrderingComposer,
    $$SemaphoreExercisesTableTableAnnotationComposer,
    $$SemaphoreExercisesTableTableCreateCompanionBuilder,
    $$SemaphoreExercisesTableTableUpdateCompanionBuilder,
    (
      SemaphoreExercisesTableData,
      BaseReferences<_$AppDatabase, $SemaphoreExercisesTableTable,
          SemaphoreExercisesTableData>
    ),
    SemaphoreExercisesTableData,
    PrefetchHooks Function()> {
  $$SemaphoreExercisesTableTableTableManager(
      _$AppDatabase db, $SemaphoreExercisesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemaphoreExercisesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SemaphoreExercisesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemaphoreExercisesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<ExerciseContentType> exerciseContentType =
                const Value.absent(),
            Value<TranslationDirection> translateType = const Value.absent(),
            Value<String> exerciseValues = const Value.absent(),
            Value<String> translatedValues = const Value.absent(),
            Value<int> count = const Value.absent(),
            Value<InteractionType> interactionType = const Value.absent(),
          }) =>
              SemaphoreExercisesTableCompanion(
            id: id,
            exerciseContentType: exerciseContentType,
            translateType: translateType,
            exerciseValues: exerciseValues,
            translatedValues: translatedValues,
            count: count,
            interactionType: interactionType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required ExerciseContentType exerciseContentType,
            required TranslationDirection translateType,
            required String exerciseValues,
            required String translatedValues,
            required int count,
            required InteractionType interactionType,
          }) =>
              SemaphoreExercisesTableCompanion.insert(
            id: id,
            exerciseContentType: exerciseContentType,
            translateType: translateType,
            exerciseValues: exerciseValues,
            translatedValues: translatedValues,
            count: count,
            interactionType: interactionType,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SemaphoreExercisesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SemaphoreExercisesTableTable,
        SemaphoreExercisesTableData,
        $$SemaphoreExercisesTableTableFilterComposer,
        $$SemaphoreExercisesTableTableOrderingComposer,
        $$SemaphoreExercisesTableTableAnnotationComposer,
        $$SemaphoreExercisesTableTableCreateCompanionBuilder,
        $$SemaphoreExercisesTableTableUpdateCompanionBuilder,
        (
          SemaphoreExercisesTableData,
          BaseReferences<_$AppDatabase, $SemaphoreExercisesTableTable,
              SemaphoreExercisesTableData>
        ),
        SemaphoreExercisesTableData,
        PrefetchHooks Function()>;
typedef $$OrientationSignsTableTableCreateCompanionBuilder
    = OrientationSignsTableCompanion Function({
  Value<int> id,
  required String name,
  required String imageLoc,
  required TopoGroupType topoGroupType,
});
typedef $$OrientationSignsTableTableUpdateCompanionBuilder
    = OrientationSignsTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> imageLoc,
  Value<TopoGroupType> topoGroupType,
});

class $$OrientationSignsTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrientationSignsTableTable> {
  $$OrientationSignsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageLoc => $composableBuilder(
      column: $table.imageLoc, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TopoGroupType, TopoGroupType, String>
      get topoGroupType => $composableBuilder(
          column: $table.topoGroupType,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$OrientationSignsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrientationSignsTableTable> {
  $$OrientationSignsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageLoc => $composableBuilder(
      column: $table.imageLoc, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topoGroupType => $composableBuilder(
      column: $table.topoGroupType,
      builder: (column) => ColumnOrderings(column));
}

class $$OrientationSignsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrientationSignsTableTable> {
  $$OrientationSignsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageLoc =>
      $composableBuilder(column: $table.imageLoc, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TopoGroupType, String> get topoGroupType =>
      $composableBuilder(
          column: $table.topoGroupType, builder: (column) => column);
}

class $$OrientationSignsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrientationSignsTableTable,
    OrientationSignsTableData,
    $$OrientationSignsTableTableFilterComposer,
    $$OrientationSignsTableTableOrderingComposer,
    $$OrientationSignsTableTableAnnotationComposer,
    $$OrientationSignsTableTableCreateCompanionBuilder,
    $$OrientationSignsTableTableUpdateCompanionBuilder,
    (
      OrientationSignsTableData,
      BaseReferences<_$AppDatabase, $OrientationSignsTableTable,
          OrientationSignsTableData>
    ),
    OrientationSignsTableData,
    PrefetchHooks Function()> {
  $$OrientationSignsTableTableTableManager(
      _$AppDatabase db, $OrientationSignsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrientationSignsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$OrientationSignsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrientationSignsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> imageLoc = const Value.absent(),
            Value<TopoGroupType> topoGroupType = const Value.absent(),
          }) =>
              OrientationSignsTableCompanion(
            id: id,
            name: name,
            imageLoc: imageLoc,
            topoGroupType: topoGroupType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String imageLoc,
            required TopoGroupType topoGroupType,
          }) =>
              OrientationSignsTableCompanion.insert(
            id: id,
            name: name,
            imageLoc: imageLoc,
            topoGroupType: topoGroupType,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrientationSignsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $OrientationSignsTableTable,
        OrientationSignsTableData,
        $$OrientationSignsTableTableFilterComposer,
        $$OrientationSignsTableTableOrderingComposer,
        $$OrientationSignsTableTableAnnotationComposer,
        $$OrientationSignsTableTableCreateCompanionBuilder,
        $$OrientationSignsTableTableUpdateCompanionBuilder,
        (
          OrientationSignsTableData,
          BaseReferences<_$AppDatabase, $OrientationSignsTableTable,
              OrientationSignsTableData>
        ),
        OrientationSignsTableData,
        PrefetchHooks Function()>;
typedef $$UserPreferencesTableTableCreateCompanionBuilder
    = UserPreferencesTableCompanion Function({
  Value<int> id,
  Value<AppThemeMode> themeMode,
  Value<String?> username,
  Value<String?> role,
  Value<String?> avatarId,
  Value<bool> onboardingSeen,
});
typedef $$UserPreferencesTableTableUpdateCompanionBuilder
    = UserPreferencesTableCompanion Function({
  Value<int> id,
  Value<AppThemeMode> themeMode,
  Value<String?> username,
  Value<String?> role,
  Value<String?> avatarId,
  Value<bool> onboardingSeen,
});

class $$UserPreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<AppThemeMode, AppThemeMode, String>
      get themeMode => $composableBuilder(
          column: $table.themeMode,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarId => $composableBuilder(
      column: $table.avatarId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onboardingSeen => $composableBuilder(
      column: $table.onboardingSeen,
      builder: (column) => ColumnFilters(column));
}

class $$UserPreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarId => $composableBuilder(
      column: $table.avatarId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onboardingSeen => $composableBuilder(
      column: $table.onboardingSeen,
      builder: (column) => ColumnOrderings(column));
}

class $$UserPreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTableTable> {
  $$UserPreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AppThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get avatarId =>
      $composableBuilder(column: $table.avatarId, builder: (column) => column);

  GeneratedColumn<bool> get onboardingSeen => $composableBuilder(
      column: $table.onboardingSeen, builder: (column) => column);
}

class $$UserPreferencesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserPreferencesTableTable,
    UserPreferencesTableData,
    $$UserPreferencesTableTableFilterComposer,
    $$UserPreferencesTableTableOrderingComposer,
    $$UserPreferencesTableTableAnnotationComposer,
    $$UserPreferencesTableTableCreateCompanionBuilder,
    $$UserPreferencesTableTableUpdateCompanionBuilder,
    (
      UserPreferencesTableData,
      BaseReferences<_$AppDatabase, $UserPreferencesTableTable,
          UserPreferencesTableData>
    ),
    UserPreferencesTableData,
    PrefetchHooks Function()> {
  $$UserPreferencesTableTableTableManager(
      _$AppDatabase db, $UserPreferencesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<AppThemeMode> themeMode = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> avatarId = const Value.absent(),
            Value<bool> onboardingSeen = const Value.absent(),
          }) =>
              UserPreferencesTableCompanion(
            id: id,
            themeMode: themeMode,
            username: username,
            role: role,
            avatarId: avatarId,
            onboardingSeen: onboardingSeen,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<AppThemeMode> themeMode = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> avatarId = const Value.absent(),
            Value<bool> onboardingSeen = const Value.absent(),
          }) =>
              UserPreferencesTableCompanion.insert(
            id: id,
            themeMode: themeMode,
            username: username,
            role: role,
            avatarId: avatarId,
            onboardingSeen: onboardingSeen,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserPreferencesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UserPreferencesTableTable,
        UserPreferencesTableData,
        $$UserPreferencesTableTableFilterComposer,
        $$UserPreferencesTableTableOrderingComposer,
        $$UserPreferencesTableTableAnnotationComposer,
        $$UserPreferencesTableTableCreateCompanionBuilder,
        $$UserPreferencesTableTableUpdateCompanionBuilder,
        (
          UserPreferencesTableData,
          BaseReferences<_$AppDatabase, $UserPreferencesTableTable,
              UserPreferencesTableData>
        ),
        UserPreferencesTableData,
        PrefetchHooks Function()>;
typedef $$ExerciseHistoryTableTableCreateCompanionBuilder
    = ExerciseHistoryTableCompanion Function({
  Value<int> id,
  required FeatureType featureType,
  required String exerciseContentType,
  required String interactionType,
  required int totalQuestions,
  required int correctCount,
  required int sessionDate,
  required int durationSeconds,
});
typedef $$ExerciseHistoryTableTableUpdateCompanionBuilder
    = ExerciseHistoryTableCompanion Function({
  Value<int> id,
  Value<FeatureType> featureType,
  Value<String> exerciseContentType,
  Value<String> interactionType,
  Value<int> totalQuestions,
  Value<int> correctCount,
  Value<int> sessionDate,
  Value<int> durationSeconds,
});

class $$ExerciseHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseHistoryTableTable> {
  $$ExerciseHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<FeatureType, FeatureType, String>
      get featureType => $composableBuilder(
          column: $table.featureType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get exerciseContentType => $composableBuilder(
      column: $table.exerciseContentType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get interactionType => $composableBuilder(
      column: $table.interactionType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));
}

class $$ExerciseHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseHistoryTableTable> {
  $$ExerciseHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get featureType => $composableBuilder(
      column: $table.featureType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseContentType => $composableBuilder(
      column: $table.exerciseContentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interactionType => $composableBuilder(
      column: $table.interactionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctCount => $composableBuilder(
      column: $table.correctCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));
}

class $$ExerciseHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseHistoryTableTable> {
  $$ExerciseHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeatureType, String> get featureType =>
      $composableBuilder(
          column: $table.featureType, builder: (column) => column);

  GeneratedColumn<String> get exerciseContentType => $composableBuilder(
      column: $table.exerciseContentType, builder: (column) => column);

  GeneratedColumn<String> get interactionType => $composableBuilder(
      column: $table.interactionType, builder: (column) => column);

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
      column: $table.totalQuestions, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => column);

  GeneratedColumn<int> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);
}

class $$ExerciseHistoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseHistoryTableTable,
    ExerciseHistoryTableData,
    $$ExerciseHistoryTableTableFilterComposer,
    $$ExerciseHistoryTableTableOrderingComposer,
    $$ExerciseHistoryTableTableAnnotationComposer,
    $$ExerciseHistoryTableTableCreateCompanionBuilder,
    $$ExerciseHistoryTableTableUpdateCompanionBuilder,
    (
      ExerciseHistoryTableData,
      BaseReferences<_$AppDatabase, $ExerciseHistoryTableTable,
          ExerciseHistoryTableData>
    ),
    ExerciseHistoryTableData,
    PrefetchHooks Function()> {
  $$ExerciseHistoryTableTableTableManager(
      _$AppDatabase db, $ExerciseHistoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseHistoryTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseHistoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<FeatureType> featureType = const Value.absent(),
            Value<String> exerciseContentType = const Value.absent(),
            Value<String> interactionType = const Value.absent(),
            Value<int> totalQuestions = const Value.absent(),
            Value<int> correctCount = const Value.absent(),
            Value<int> sessionDate = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
          }) =>
              ExerciseHistoryTableCompanion(
            id: id,
            featureType: featureType,
            exerciseContentType: exerciseContentType,
            interactionType: interactionType,
            totalQuestions: totalQuestions,
            correctCount: correctCount,
            sessionDate: sessionDate,
            durationSeconds: durationSeconds,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required FeatureType featureType,
            required String exerciseContentType,
            required String interactionType,
            required int totalQuestions,
            required int correctCount,
            required int sessionDate,
            required int durationSeconds,
          }) =>
              ExerciseHistoryTableCompanion.insert(
            id: id,
            featureType: featureType,
            exerciseContentType: exerciseContentType,
            interactionType: interactionType,
            totalQuestions: totalQuestions,
            correctCount: correctCount,
            sessionDate: sessionDate,
            durationSeconds: durationSeconds,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExerciseHistoryTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ExerciseHistoryTableTable,
        ExerciseHistoryTableData,
        $$ExerciseHistoryTableTableFilterComposer,
        $$ExerciseHistoryTableTableOrderingComposer,
        $$ExerciseHistoryTableTableAnnotationComposer,
        $$ExerciseHistoryTableTableCreateCompanionBuilder,
        $$ExerciseHistoryTableTableUpdateCompanionBuilder,
        (
          ExerciseHistoryTableData,
          BaseReferences<_$AppDatabase, $ExerciseHistoryTableTable,
              ExerciseHistoryTableData>
        ),
        ExerciseHistoryTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PostsTableTableTableManager get postsTable =>
      $$PostsTableTableTableManager(_db, _db.postsTable);
  $$MorseExercisesTableTableTableManager get morseExercisesTable =>
      $$MorseExercisesTableTableTableManager(_db, _db.morseExercisesTable);
  $$SemaphoreExercisesTableTableTableManager get semaphoreExercisesTable =>
      $$SemaphoreExercisesTableTableTableManager(
          _db, _db.semaphoreExercisesTable);
  $$OrientationSignsTableTableTableManager get orientationSignsTable =>
      $$OrientationSignsTableTableTableManager(_db, _db.orientationSignsTable);
  $$UserPreferencesTableTableTableManager get userPreferencesTable =>
      $$UserPreferencesTableTableTableManager(_db, _db.userPreferencesTable);
  $$ExerciseHistoryTableTableTableManager get exerciseHistoryTable =>
      $$ExerciseHistoryTableTableTableManager(_db, _db.exerciseHistoryTable);
}
