enum PlayerName { A, C, B, D }

String getPlayerNameIn(PlayerName playerName) {
  return playerName.name;
}

PlayerName? playerNameEnum(String enumString) {
  return PlayerName.values
      .where((element) => element.name == enumString)
      .firstOrNull;
}

int playerNameIndex(String enumString) {
  return PlayerName.values.indexWhere((element) => element.name == enumString);
}
