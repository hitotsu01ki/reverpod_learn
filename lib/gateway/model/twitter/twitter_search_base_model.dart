import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_app/gateway/model/twitter/twitter_search_items_model.dart';

part 'twitter_search_base_model.freezed.dart';
part 'twitter_search_base_model.g.dart';

@freezed
abstract class TwitterSearchBaseModel with _$TwitterSearchBaseModel {
  factory TwitterSearchBaseModel({
    @Default([]) List<TwitterSearchItemsModel> statuses,

  }) = _TwitterSearchBaseModel;

  factory TwitterSearchBaseModel.fromJson(Map<String, dynamic> json) => _$TwitterSearchBaseModelFromJson(json);
}
