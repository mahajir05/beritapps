import '../../../../config/api_path.dart';
import '../../../../config/environment.dart';
import '../../../../core/error/handle_errors.dart';
import '../../../../core/models/base_list_resp.dart';
import '../../../../core/network/api_service.dart';
import '../model/article_model.dart';

abstract class HomeRemoteDataSource {
  Future<BaseListResp<ArticleModel>> getTopHeadlinesNews(
      {String? countryCode = "id", String? category});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<BaseListResp<ArticleModel>> getTopHeadlinesNews(
      {String? countryCode = "id", String? category}) async {
    final result = await apiService.baseUrl(Environment.baseUrlV2()).get(
      apiPath: ApiPath.topHeadline,
      request: {
        'country': countryCode,
        'apiKey': Environment.keyNewsApi(),
        ...(category == "all" || category == null)
            ? {}
            : {
                'category': category,
              },
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
