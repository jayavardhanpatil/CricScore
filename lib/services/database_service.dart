
import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/model/team.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth_service.dart';

class DatabaseService {

  final String uid;

  final StreamController<MatchGame> matchStreamController = StreamController<MatchGame>();

  DatabaseService({this.uid});

  static List<dynamic> cities = new List();
  Map<String, User> users = new Map();

  final DatabaseReference _fireBaseRTreference = FirebaseDatabase.instance
      .reference();


  //Write a data : key value
  Future addUser(User user) async {
    print(user.uid);
    print("Adding User" + user.toJson().toString());
    await _fireBaseRTreference.child("/users/" + user.uid).set(user.toJson())
        .then((value) {
      print("Added User" + user.toJson().toString());
      reLoadUserRecord(user.uid);
      return user;
    }).catchError((e) {
      print("Error in writing to DB : " + e.toString());
    });
  }

  void addCities() {
    addCityList();
    _fireBaseRTreference.child("/countries/all/").set({
      "cities": cities
    }).then((value) {
      print("Cities Added");
    }).catchError((e) {
      print("Error in writing to DB : " + e.toString());
    });
  }

  reloadCitiesList() async{
    if(cities.length == 0) {
      await _fireBaseRTreference.child("countries/all").once().
      then((value) =>
      {
        cities = value.value['cities'].toList(),
      });
    }
  }

  getCity(String pattern) {
    if (cities.length == 0) {
      print("Entered City : " + pattern);
      _fireBaseRTreference.child("countries/all").once().
      then((value) =>
      {
        print(value.value['cities'].toString()),
        cities = value.value['cities'].toList(),
        print(
            cities.where((element) => element.startsWith(pattern)).toList()),

      }).
      catchError((e) {
        print("Error in fetching city" + e.toString());
      });
    }
    return cities.where((element) => element.startsWith(pattern)).toList();
  }

  void addCityList() {
    cities.add("Pomona");
    cities.add("New York");
    cities.add("Chicago");
    cities.add("Los Angeles");
    cities.add("Santa Clara");
    cities.add("San Francisco");
    cities.add("Fresno");
    cities.add("San Diego");
    cities.add("Bangalore");
    cities.add("Delhi");
    cities.add("Pune");
    cities.add("Mumbai");
    cities.add("Belgaum");
    cities.add("Bhoj");
    cities.add("Chennai");
    cities.add("Hyderabad");
  }

  List getusers() {
    _fireBaseRTreference.child("/users").once().then((value) {
      print(value);
    }).catchError((e) {
      print("Error in fetching the user record : " + e.toString());
    });
    return null;
  }

  Future reLoadUserRecord(uid) async {
    await getUserRecord(uid).then((value) => print("User record reloaded"));
  }

  Future<User> getUserRecord(uid) async {
    await _fireBaseRTreference.child("/users/" + uid).once().then((value) {
      if (value.value == null) return null;
//      print("Getting Data from DB : "+value.value);
      print(value.value['name']);
      if(value.value == null) {
        value.value['uid'] = uid;
      }
      User user = User.fromJson(value.value);
      if (AuthService.user.uid == uid) {
        AuthService.user = user;
      }
      return user;
    }).catchError((e) {
      print("Error in fetching the user record : " + e.toString());
    });
  }

  Future addTeams(Team team) async{
    return await _fireBaseRTreference.child("teams").child(team.getTeamName() +" - "+ team.getTeamCity()).set(team.toJson()).then((value) => print("Added teams")).catchError((e){
      print(e.toString());
    });

  }

  Future addMatch(MatchGame match) async{
    print("Match Title : "+match.getMatchTitle());
    return await _fireBaseRTreference.child("matches").child(match.getMatchVenue()).child(match.getMatchTitle()).set(match.toJson())
        .then((value) => print("Added match Detail"))
        .catchError((e){
      print("Error : in adding match details"+e.toString());
    });

  }

  Future<Map<String, User>> getUsersList() async {
    if(users.length == 0) {
      return await _fireBaseRTreference.child("/users").once().then((value) {
        print("Getting user data from DB");
        value.value.forEach((k, v) {
          User user = User.fromJson(v);
          user.uid = k;
          if (user.name != null) {
            users.update(k, (value) => user, ifAbsent: () => user);
          }
        });
        return users;
      }).catchError((e) {
        print("Error : " + e.toString());
      });
    }else{
      return users;
    }
  }

  addInningsPlayers(MatchGame match, Map<String, Player> player, String inningType, String playingType) async{
    //print(match.toJson());
    player.forEach((key, value) async {
      return await _fireBaseRTreference.child("matches/"+match.getMatchVenue()+"/").child(match.getMatchTitle()).child(inningType).child(playingType).child(key).set(value.toJson())
          .then((value) => print("Player details added to "+inningType + " inning")).catchError((e){
        print("error : "+e.toString());
      });
    });
  }
  
  Future updateCurrentPlayer(MatchGame matchGame) async{
    return await _fireBaseRTreference.child("matches/"+matchGame.getMatchVenue()+"/").child(matchGame.getMatchTitle()).child("currentPlayers").set(matchGame.currentPlayers.toJson()).then((value) => (){
    print("Currentt userd detail Updated");
    }).catchError((e) {
      print("error : failed to update current players"+e.toString());
    });
  }

  Future<List<MatchGame>> getListOfMatches(String city) async{
    List<MatchGame> listOfMatches = new List();
    return await _fireBaseRTreference.child("matches").child(city).limitToFirst(4).once().then((value) {
      value.value.forEach((k, v) {
        MatchGame matchGame = MatchGame.fromJson(v);
        if(matchGame.isLive)
        listOfMatches.insert(0, matchGame);
        else
          listOfMatches.add(matchGame);
      });
      return listOfMatches;
    }).catchError((e){
      print("error in fetching match data" + e.toString());
      return listOfMatches;
    });
  }



//  addMatchDetail(MatchGame match) async{
//    print(match.toJson());
//    return await _fireBaseRTreference.child("matches/"+match.getMatchVenue()+"/").child(match.getMatchTitle())
//        .set(match.toJson()).then((value) => print("Match details added")).catchError((e){
//      print("error : "+e.toString());
//    });
//  }


   Stream<MatchGame> gameStreamData(String matchVenue, String matchTitle) {
    return _fireBaseRTreference.child("matches").child(matchVenue).child(matchTitle).onValue.map(_mapTOMatchGame);
  }

  MatchGame _mapTOMatchGame(dynamic gameData){
    MatchGame game = MatchGame.fromJson(gameData.snapshot.value);
    return game;
  }
}