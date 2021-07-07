import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'package:iesbgram/app/modules/profile/padding_widget.dart';
import 'package:iesbgram/app/modules/profile/user_store.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}
class ProfilePageState extends ModularState<ProfilePage, UserStore> {

  late final ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(store.user?.displayName ?? 'Sem nome');
        }),
        actions: [
          Observer(builder: (_) {
            if (store.loading) {
              return Container(
                child: Center(
                  child: Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(color: Theme.of(context).buttonColor),
                  ),
                ),
              );
            }
            return IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt_outlined),
                                SizedBox(width: 16),
                                Text('Tirar foto')
                              ],
                            ),
                            onTap: () async {
                              final pickedFile = await _picker.getImage(
                                  source: ImageSource.camera,
                                  imageQuality: 50,
                                  maxWidth: 1920,
                                  maxHeight: 1200
                              );
                              if (pickedFile != null) {
                                store.postPicture(pickedFile.path);
                              }
                              Navigator.of(ctx).pop();
                            },
                          ),
                          SizedBox(height: 24),
                          InkWell(
                            child: Row(
                              children: [
                                Icon(Icons.photo_library_outlined),
                                SizedBox(width: 16),
                                Text('Escolher foto')
                              ],
                            ),
                            onTap: () async {
                              final pickedFile = await _picker.getImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50,
                                  maxWidth: 1920,
                                  maxHeight: 1200
                              );
                              if (pickedFile != null) {
                                store.postPicture(pickedFile.path);
                              }
                              Navigator.of(ctx).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
            );
          }),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _UserHeader(store),
          _UserSubHeading(store),
          _UserGallery(store),

        ],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {

  UserStore store;
  _UserHeader(this.store);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            child: Observer(builder: (_) {
              if (store.user!.photoURL != null && store.user!.photoURL!.isNotEmpty) {
                return CircleAvatar(
                  radius: 38,
                  backgroundImage: NetworkImage(store.user!.photoURL!),
                );
              }
              return CircleAvatar(
                radius: 38,
                backgroundImage: AssetImage('assets/sem_foto.jpg'),
              );
            }),
          ),
          Column(
            children: [
              Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Publicações')
            ],
          ),
          Column(
            children: [
              Text('200', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Seguidores')
            ],
          ),
          Column(
            children: [
              Text('300', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Seguindo')
            ],
          ),
        ],
      ),
    );
  }
}

class _UserSubHeading extends StatelessWidget {

  UserStore store;
  _UserSubHeading(this.store);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Observer(builder: (_) {
            return Text((store.user?.displayName ?? 'Sem nome'), style: TextStyle(fontWeight: FontWeight.bold));
          }),
          Observer(builder: (_) {
            return Text(store.bio ?? '');
          }),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: Text('Editar perfil'),
                onPressed: () {
                  Modular.to.pushNamed('.${Constants.Routes.EDIT_PROFILE}');
                },
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.logout),
                label: Text('Logoff'),
                onPressed: () {
                  store.logoff()
                      .then((_) => Modular.to.popAndPushNamed(Constants.Routes.LOGIN));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class _UserGallery extends StatelessWidget {

  final UserStore store;
  _UserGallery(this.store);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: StreamBuilder(
        stream: store.posts,
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            log('Erro ao carregar: ${snapshot.error}');
            return Text('Deu erro');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            final posts = snapshot.data!.docs;
            return GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: posts.map((post) {
                final data = post.data() as Map<String, dynamic>;
                return Image.network(data['url'] as String, fit: BoxFit.cover);
              }).toList()
            );
          }
          return Container();
        },
      )
    );
  }
}
