import 'package:flutter/material.dart';

String determineRoundResult(List<String> gameResults) {
  // Count occurrences of Wins, Losses, and Ties
  int wins = gameResults.where((result) => result == 'W').length;
  int losses = gameResults.where((result) => result == 'L').length;
  int ties = gameResults.where((result) => result == 'T').length;

  // Determine overall result
  if (wins >= 2 || (wins == 1 && losses == 0 && ties == 0)) {
    return 'W'; // Overall Win
  } else if (losses >= 2 || (losses == 1 && wins == 0 && ties == 0)) {
    return 'L'; // Overall Loss
  } else {
    return 'T'; // Overall Tie
  }
}

Color getResultBackgroundColor(String result) {
  switch (result) {
    case 'W':
      return Color(0xffdcfce7); // Light Green for Win
    case 'L':
      return Color(0xfffee2e2); // Light Red for Loss
    case 'T':
      return Color(0xFFfef9c3); // Light Yellow for Tie
    default:
      return Colors.grey; // Default color for unrecognized result
  }
}

Color getResultForegroundColor(String result) {
  switch (result) {
    case 'W':
      return Color(0xff16a34a); // Light Green for Win
    case 'L':
      return Color(0xffdc2626); // Light Red for Loss
    case 'T':
      return Color(0xffca8a04); // Light Yellow for Tie
    default:
      return Colors.grey; // Default color for unrecognized result
  }
}