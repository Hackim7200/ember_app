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


/** This is an auto generated class representing the BreakdownItem type in your schema. */
class BreakdownItem {
  final String? _activity;
  final int? _timeElapsed;
  final String? _type;

  String get activity {
    try {
      return _activity!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get timeElapsed {
    try {
      return _timeElapsed!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get type {
    try {
      return _type!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const BreakdownItem._internal({required activity, required timeElapsed, required type}): _activity = activity, _timeElapsed = timeElapsed, _type = type;
  
  factory BreakdownItem({required String activity, required int timeElapsed, required String type}) {
    return BreakdownItem._internal(
      activity: activity,
      timeElapsed: timeElapsed,
      type: type);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BreakdownItem &&
      _activity == other._activity &&
      _timeElapsed == other._timeElapsed &&
      _type == other._type;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BreakdownItem {");
    buffer.write("activity=" + "$_activity" + ", ");
    buffer.write("timeElapsed=" + (_timeElapsed != null ? _timeElapsed!.toString() : "null") + ", ");
    buffer.write("type=" + "$_type");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BreakdownItem copyWith({String? activity, int? timeElapsed, String? type}) {
    return BreakdownItem._internal(
      activity: activity ?? this.activity,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      type: type ?? this.type);
  }
  
  BreakdownItem copyWithModelFieldValues({
    ModelFieldValue<String>? activity,
    ModelFieldValue<int>? timeElapsed,
    ModelFieldValue<String>? type
  }) {
    return BreakdownItem._internal(
      activity: activity == null ? this.activity : activity.value,
      timeElapsed: timeElapsed == null ? this.timeElapsed : timeElapsed.value,
      type: type == null ? this.type : type.value
    );
  }
  
  BreakdownItem.fromJson(Map<String, dynamic> json)  
    : _activity = json['activity'],
      _timeElapsed = (json['timeElapsed'] as num?)?.toInt(),
      _type = json['type'];
  
  Map<String, dynamic> toJson() => {
    'activity': _activity, 'timeElapsed': _timeElapsed, 'type': _type
  };
  
  Map<String, Object?> toMap() => {
    'activity': _activity,
    'timeElapsed': _timeElapsed,
    'type': _type
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BreakdownItem";
    modelSchemaDefinition.pluralName = "BreakdownItems";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'activity',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'timeElapsed',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'type',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}