
class Game {
  String getJankenResult(String hand) {

    if (hand.equals("Gu")) 
    return "hot";
    else if (hand.equals("Choki"))
    return "good";
    else if (hand.equals("Pa"))
    return "cold";
    else if(hand.equals("Bad"))
    return "bad";

    return null;
  }
}

  