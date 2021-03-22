import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nukak_maku/authentication_service.dart';
import 'package:nukak_maku/db.dart' as db;
import 'package:nukak_maku/models/favourite.dart';
import 'package:nukak_maku/widgets/favourite_list.dart';
import 'package:nukak_maku/widgets/loading_circle.dart';
import 'package:nukak_maku/widgets/snerror.dart';
import 'package:provider/provider.dart';

class FavouritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
        future: UserHelper.getUserRole(firebaseUser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
            return UserFavs(firebaseUser: firebaseUser);
            
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Loading();
        });
  }
}

class UserFavs extends StatelessWidget {
  const UserFavs({
    Key key,
    @required this.firebaseUser,
  }) : super(key: key);

  final User firebaseUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shops')),
      body: StreamBuilder(
          stream: db.getFavourites(firebaseUser.uid),
          builder: (context, AsyncSnapshot<List<Favourite>> snapshot) {
            if (snapshot.hasError) {
              return SnapshotError(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Loading();
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: FavouriteList(favourites: snapshot.data),
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () =>
                      context.read<AuthenticationService>().signOut(),
                ),
              ],
            );
          }),
    );
  }
}


