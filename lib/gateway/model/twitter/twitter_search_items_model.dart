import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_app/gateway/model/twitter/twitter_search_result_model.dart';

part 'twitter_search_items_model.freezed.dart';
part 'twitter_search_items_model.g.dart';

@freezed
abstract class TwitterSearchItemsModel with _$TwitterSearchItemsModel {
  factory TwitterSearchItemsModel({
    @Default('') String created_at,
    @Default('') String text,
    // TwitterSearchResultModel? urls,

  }) = _TwitterSearchItemsModel;

  factory TwitterSearchItemsModel.fromJson(Map<String, dynamic> json) => _$TwitterSearchItemsModelFromJson(json);

}
