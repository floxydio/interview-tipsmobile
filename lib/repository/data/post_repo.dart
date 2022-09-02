import 'package:dio/dio.dart';
import 'package:interviewmobile/config/options_server.dart';
import 'package:interviewmobile/config/server.dart';
import 'package:interviewmobile/repository/models/post_model.dart';

class PostRepository {
  Future<List<PostModel>> getDataPost() async {
    List<PostModel> repo = [];
    Response res = await Dio()
        .get(ServerConfig.baseURL + "posts", options: OptionsDio.options());
    res.data.forEach((e) {
      repo.add(PostModel.fromJson(e));
    });
    return repo;
  }

  Future<Response> createPost(PostModel formPost) async {
    Response res = await Dio().post(ServerConfig.baseURL + "posts",
        data: formPost.toJson(), options: OptionsDio.options());
    print(res.data);
    return res;
  }

  Future<Response> deletePost(int? id) async {
    var configUrl = ServerConfig.baseURL + "posts/$id";
    Response res = await Dio().delete(ServerConfig.baseURL + "posts/$id",
        options: OptionsDio.options());
    print(res.data);

    print(configUrl);

    return res;
  }
}
