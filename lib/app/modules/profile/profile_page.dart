import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iesbgram/app/constants.dart';
import 'package:iesbgram/app/modules/profile/padding_widget.dart';
import 'package:iesbgram/app/modules/profile/user_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}
class ProfilePageState extends ModularState<ProfilePage, UserStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(store.user?.displayName ?? 'Sem nome');
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _UserHeader(store),
          _UserSubHeading(store),
          _UserGallery(),

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
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/sem_foto.jpg'),
              radius: 38,
            ),
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
          ElevatedButton(
            child: Text('Editar perfil'),
            onPressed: () {
              Modular.to.pushNamed('.${Constants.Routes.EDIT_PROFILE}');
            },
          )
        ],
      ),
    );
  }
}

class _UserGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
          Image.network('http://lorempixel.com.br/300/300/?${DateTime.now().microsecond}'),
        ],
      ),
    );
  }
}
