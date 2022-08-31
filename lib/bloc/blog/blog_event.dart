import 'package:equatable/equatable.dart';
import 'package:interviewmobile/repository/models/post_model.dart';

abstract class BlogEvent extends Equatable {}

class BlogLoading extends BlogEvent {
  @override
  List<Object?> get props => [];
}

class BlogLoaded extends BlogEvent {
  final List<PostModel> postModel;

  BlogLoaded(this.postModel);

  @override
  List<Object?> get props => [postModel];
}
