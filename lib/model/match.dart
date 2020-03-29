
import 'package:flutter_app/model/team.dart';

class Match{

   String _match_Venue;
   Map<String, Team> teams = new Map();

   void setMatchVenue(String matchVenue){
     this._match_Venue = matchVenue;
   }

  String getMatchVenue(){
    return this._match_Venue;
  }

  Map<String, Team> getTeams(){
    return this.teams;
  }

}