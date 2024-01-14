import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String uid,
    required String nick,
    required String name,
    required int age,
    required String phoneNum,
    required String deviceToken,
    required bool isRegistered,
    required String type,
    required List<String>? friends,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static UserModel initUser() {
    return UserModel(
      uid: '',
      nick: '',
      name: '',
      age: 0,
      phoneNum: '',
      deviceToken: '',
      isRegistered: false,
      type: '',
      friends: [],
    );
  }
}
