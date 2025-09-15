/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Todo type in your schema. */
class Todo extends amplify_core.Model {
  static const classType = const _TodoModelType();
  final String id;
  final String? _content;
  final bool? _isDone;
  final int? _pomodoros;
  final amplify_core.TemporalDateTime? _date;
  final List<BreakdownItem>? _breakdown;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TodoModelIdentifier get modelIdentifier {
      return TodoModelIdentifier(
        id: id
      );
  }
  
  String get content {
    try {
      return _content!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get isDone {
    try {
      return _isDone!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get pomodoros {
    return _pomodoros;
  }
  
  amplify_core.TemporalDateTime get date {
    try {
      return _date!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<BreakdownItem>? get breakdown {
    return _breakdown;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Todo._internal({required this.id, required content, required isDone, pomodoros, required date, breakdown, createdAt, updatedAt}): _content = content, _isDone = isDone, _pomodoros = pomodoros, _date = date, _breakdown = breakdown, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Todo({String? id, required String content, required bool isDone, int? pomodoros, required amplify_core.TemporalDateTime date, List<BreakdownItem>? breakdown}) {
    return Todo._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      content: content,
      isDone: isDone,
      pomodoros: pomodoros,
      date: date,
      breakdown: breakdown != null ? List<BreakdownItem>.unmodifiable(breakdown) : breakdown);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
      id == other.id &&
      _content == other._content &&
      _isDone == other._isDone &&
      _pomodoros == other._pomodoros &&
      _date == other._date &&
      DeepCollectionEquality().equals(_breakdown, other._breakdown);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Todo {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("isDone=" + (_isDone != null ? _isDone!.toString() : "null") + ", ");
    buffer.write("pomodoros=" + (_pomodoros != null ? _pomodoros!.toString() : "null") + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("breakdown=" + (_breakdown != null ? _breakdown!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Todo copyWith({String? content, bool? isDone, int? pomodoros, amplify_core.TemporalDateTime? date, List<BreakdownItem>? breakdown}) {
    return Todo._internal(
      id: id,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      pomodoros: pomodoros ?? this.pomodoros,
      date: date ?? this.date,
      breakdown: breakdown ?? this.breakdown);
  }
  
  Todo copyWithModelFieldValues({
    ModelFieldValue<String>? content,
    ModelFieldValue<bool>? isDone,
    ModelFieldValue<int?>? pomodoros,
    ModelFieldValue<amplify_core.TemporalDateTime>? date,
    ModelFieldValue<List<BreakdownItem>?>? breakdown
  }) {
    return Todo._internal(
      id: id,
      content: content == null ? this.content : content.value,
      isDone: isDone == null ? this.isDone : isDone.value,
      pomodoros: pomodoros == null ? this.pomodoros : pomodoros.value,
      date: date == null ? this.date : date.value,
      breakdown: breakdown == null ? this.breakdown : breakdown.value
    );
  }
  
  Todo.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content'],
      _isDone = json['isDone'],
      _pomodoros = (json['pomodoros'] as num?)?.toInt(),
      _date = json['date'] != null ? amplify_core.TemporalDateTime.fromString(json['date']) : null,
      _breakdown = json['breakdown'] is List
        ? (json['breakdown'] as List)
          .where((e) => e != null)
          .map((e) => BreakdownItem.fromJson(new Map<String, dynamic>.from(e['serializedData'] ?? e)))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content, 'isDone': _isDone, 'pomodoros': _pomodoros, 'date': _date?.format(), 'breakdown': _breakdown?.map((BreakdownItem? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'content': _content,
    'isDone': _isDone,
    'pomodoros': _pomodoros,
    'date': _date,
    'breakdown': _breakdown,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TodoModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TodoModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final ISDONE = amplify_core.QueryField(fieldName: "isDone");
  static final POMODOROS = amplify_core.QueryField(fieldName: "pomodoros");
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final BREAKDOWN = amplify_core.QueryField(fieldName: "breakdown");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Todo";
    modelSchemaDefinition.pluralName = "Todos";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Todo.CONTENT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Todo.ISDONE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Todo.POMODOROS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Todo.DATE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.embedded(
      fieldName: 'breakdown',
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'BreakdownItem')
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TodoModelType extends amplify_core.ModelType<Todo> {
  const _TodoModelType();
  
  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Todo';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Todo] in your schema.
 */
class TodoModelIdentifier implements amplify_core.ModelIdentifier<Todo> {
  final String id;

  /** Create an instance of TodoModelIdentifier using [id] the primary key. */
  const TodoModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'TodoModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TodoModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}