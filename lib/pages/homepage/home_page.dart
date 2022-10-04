import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_project/pages/homepage/homepage_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../base/routes.dart';
import '../../widgets/react_widget.dart';
import '../profile/profile_page.dart';

class HomePage extends StatelessWidget {
  TextEditingController commentCtrl = TextEditingController();
  String? fieldText;

  @override
  Widget build(BuildContext context) {
    return homePage();
  }

  Widget homePage() {
    return ChangeNotifierProvider(
      create: (context) => HomepageProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Home',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
        ),
        body: SafeArea(
          child: Consumer<HomepageProvider>(
            builder: (context, value, child) => Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(15), child: _buildContent()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Consumer<HomepageProvider>(builder: (context, value, child) {
      if (value.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
          itemCount: value.photos?.length,
          itemBuilder: (context, index) => Column(
            children: [
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  CircleAvatar(
                    radius: 48, // Image radius
                    backgroundImage:
                        NetworkImage('${value.photos?[index].src!.medium}'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  photo: value.photos![index],
                                ),
                              ));

                          print(value.photos![index].runtimeType);
                        },
                        // Navigator.pushNamed(context, AppRoutes.profile),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text(
                                    '${value.photos?[index].photographer}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                '${value.photos?[index].src!.medium}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReactWidget(),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoutes.comments);
                            value.visibleTextField();
                          },
                          child: const Icon(
                            Icons.comment_outlined,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          IconButton(
                            onPressed: () {
                              Share.share(
                                '${value.photos![index].src?.medium}',
                                subject: 'Message',
                              );
                            },
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // ignore: prefer_const_constructors
              Visibility(
                visible: value.isVisible,
                // ignore: prefer_const_constructors
                child: Card(
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: commentCtrl,
                          // obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Write a comment...',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: value.isShow,
                            child: Text('${fieldText}'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(children: [
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              onPressed: () {
                                print(commentCtrl.text);
                                value.show();
                                fieldText =
                                    value.isShow ? commentCtrl.text : '';
                                commentCtrl.text = '';
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blueGrey,
                              ),
                              child: const Text('SEND'),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              value.visibleTextField();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey,
                            ),
                            child: const Text('Ok'),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    });
  }
}
