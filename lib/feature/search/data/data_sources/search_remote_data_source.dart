import '../../../../config/api_path.dart';
import '../../../../config/environment.dart';
import '../../../../core/error/handle_errors.dart';
import '../../../../core/models/base_list_resp.dart';
import '../../../../core/network/api_service.dart';
import '../models/article_model.dart';

abstract class SearchRemoteDataSource {
  Future<BaseListResp<ArticleModel>> searchTopHeadlinesNews(
      {String? countryCode = "id", String? keyword});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiService apiService;

  SearchRemoteDataSourceImpl({required this.apiService});

  @override
  Future<BaseListResp<ArticleModel>> searchTopHeadlinesNews(
      {String? countryCode = "id", String? keyword}) async {
    final result = await apiService.baseUrl(Environment.baseUrlV2()).get(
      apiPath: ApiPath.topHeadline,
      request: {
        'country': countryCode,
        'apiKey': Environment.keyNewsApi(),
        'q': keyword,
      },
    );
    switch (result.statusCode) {
      case 200:
        return BaseListResp<ArticleModel>.fromJson(
            result.data, ArticleModel.fromJson);
      default:
        return handleErrors(result);
    }
  }
}
