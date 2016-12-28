class Game {
  String getJankenResult(String hand) {

    if (hand.equals("Gu")) 
    return "hot";
    else if (hand.equals("Choki"))
    return "cold";
    else if (hand.equals("Pa"))
    return "good";

    return null;
  }

  
}