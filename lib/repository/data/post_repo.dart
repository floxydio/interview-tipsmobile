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
}
