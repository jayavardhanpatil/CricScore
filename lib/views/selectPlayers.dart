
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/startMatch.dart';

class PlayersList extends StatefulWidget {

  @override
  _PlayersList createState() =>
      _PlayersList();
  }

  class _PlayersList extends State<PlayersList> {

    List<User> _listofUsers = new List();
    List<String> selectedList;
    List<bool> _selected = List.generate(8, (index) => false);
    Future users;

    @override
  void initState() {
      super.initState();
      selectedList = List();
      users = loadUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${StartMatch.currentTeamName} selected(" + "${selectedList.length}" + ")"),
      ),
      body: Center(
        child: Container(
          child: userListView(context),
        ),
      )
    );
  }

  Widget userListView(BuildContext context){
    return FutureBuilder(
      future: users,
      builder: (context,  snapshot){

        if(snapshot.data == null){
          return Text("Loading....");
        } else if (snapshot.hasData) {
            _listofUsers = snapshot.data;
          }

        if(_listofUsers.length > 0){

          return ListView.builder(
            itemCount: _listofUsers.length,
            itemBuilder: (context, index){
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),

                color: _selected[index] ? Colors.black12 : null,
                child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20),
                    leading: CircleAvatar(
                      backgroundImage: ExactAssetImage(
                          "lib/assets/images/default_profile_avatar.png"),
                      backgroundColor: Colors.blue,
                    ),
                    title: Text(
                      _listofUsers[index].name,
                    ),
                    subtitle: Text(
                      _listofUsers[index].phoneNumber.toString(),
                    ),
                      onTap: (){
                        setState(() {
                          if(!_selected[index]){
                            selectedList.add(_listofUsers[index].getEmailId());
                          }else{
                            selectedList.remove(_listofUsers[index].getEmailId());
                          }
                          _selected[index] = !_selected[index];
                          print(selectedList.toString());
                        });
                    },
                ),
              );
            }
          );
        }else{
          return Text("No data");
        }
      });
  }

  Future loadUsers() async{
      return await DatabaseService().getUsersList();
  }

}