import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewmobile/repository/models/post_model.dart';

import '../bloc/blog/blog_cubit.dart';
import '../bloc/blog/blog_event.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    calPostApi();
  }

  void calPostApi() => context.read<BlogCubit>().getPost();

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Title",
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: bodyController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Body",
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      var data = PostModel(
                                          title: titleController.text,
                                          body: bodyController.text);
                                      context.read<BlogCubit>().createPost(data,
                                          () {
                                        titleController.clear();
                                        bodyController.clear();
                                        Navigator.pop(context);
                                        var snackBar = const SnackBar(
                                          content: Text(
                                              'Successfully Create your post'),
                                          duration: Duration(seconds: 5),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    },
                                    child: const Text("Submit"))
                              ],
                            ),
                          ));
                },
                child: const Text("Add post")),
            BlocBuilder<BlogCubit, BlogEvent>(
              builder: (context, state) {
                if (state is BlogLoaded) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.postModel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Card(
                              child: ListTile(
                            title: Text(state.postModel[index].body.toString()),
                            subtitle: Row(children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.update)),
                              IconButton(
                                  onPressed: () {
                                    context.read<BlogCubit>().deletePost(
                                        state.postModel[index].id, () {
                                      var snackBar = const SnackBar(
                                        content: Text(
                                            'Successfully DELETE your post'),
                                        duration: Duration(seconds: 5),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                  },
                                  icon: const Icon(Icons.delete))
                            ]),
                          )),
                        );
                      });
                } else if (state is BlogLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
