import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;
part 'database-model.g.dart';

// This is where we define our tables:
const SqfEntityTable tableRepeatableMissions = SqfEntityTable(
    tableName: 'repeatableMissionsTable',
    primaryKeyName: 'repeatableMissionId',
    useSoftDeleting: true,
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    fields: [
      SqfEntityField('missionName', DbType.text),
      SqfEntityField('missionTime', DbType.text),
      SqfEntityField('missionDate', DbType.text),
      SqfEntityField('missionRepeat', DbType.text),
      SqfEntityField('missionDescription', DbType.text),
      SqfEntityField('missionLocationName', DbType.text),
      SqfEntityField('missionLocationId', DbType.text),
      SqfEntityField('missionLocationLat', DbType.text),
      SqfEntityField('missionLocationLng', DbType.text),
      SqfEntityField('missionRecordPath', DbType.text),
      SqfEntityField('completed', DbType.bool, defaultValue: false), //if it was completed
      SqfEntityField('archived', DbType.bool, defaultValue: false), //if it was completed
    ]);


const SqfEntityTable tableWeekdaysMissions = SqfEntityTable(
  tableName: 'weekdaysMissions',
  primaryKeyName: 'id',
  useSoftDeleting: true,
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('weekdayName', DbType.text),
    SqfEntityField('missionName', DbType.text),
    SqfEntityField('missionTime', DbType.text),
    SqfEntityField('missionDate', DbType.text),
    SqfEntityField('missionLocationId', DbType.text),
    SqfEntityField('missionLocationName', DbType.text),
    SqfEntityField('missionLocationLat', DbType.text),
    SqfEntityField('missionLocationLng', DbType.text),
    SqfEntityField('missionDescription', DbType.text),
    SqfEntityField('missionRecordPath', DbType.text),
    SqfEntityField('completed', DbType.bool, defaultValue: false),

  ],
);


const SqfEntityTable tableFaceData=SqfEntityTable(
  tableName: 'faceDataTable',
  primaryKeyName: 'id',
  useSoftDeleting: true,
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('facePoints', DbType.text),
    SqfEntityField('leftEyebrowTop', DbType.text),
    SqfEntityField('leftEyebrowBottom', DbType.text),
    SqfEntityField('rightEyebrowTop', DbType.text),
    SqfEntityField('rightEyebrowBottom', DbType.text),
    SqfEntityField('leftEye', DbType.text),
    SqfEntityField('rightEye', DbType.text),
    SqfEntityField('upperLipTop', DbType.text),
    SqfEntityField('lowerLipTop', DbType.text),
    SqfEntityField('noseBridge', DbType.text),
    SqfEntityField('noseBottom', DbType.text),
    SqfEntityField('leftCheek', DbType.text),
    SqfEntityField('rightCheek', DbType.text),
    SqfEntityField('userName', DbType.text),
    SqfEntityField('userRelation ', DbType.text),
    SqfEntityField('completed', DbType.bool, defaultValue: false),
  ]
);


const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);




// This is where we define our database:
@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyAppDatabaseModel',
    databaseName: 'myapp-db.db',
    sequences: [
      seqIdentity
    ],
    databaseTables: [
      tableRepeatableMissions,
      tableWeekdaysMissions,
      tableFaceData

    ] //if you will be adding new tables, do not forget to put them here
    );
