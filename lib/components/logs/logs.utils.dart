class BattleLog {
  final String id;
  final List<BattleLogPlayer> players;
  final String date;
  final String winner;
  final List<BattleLogTurn> sections;

  BattleLog({required this.id, required this.players, required this.date, required this.winner, required this.sections});
}

class BattleLogPlayer {
  final String name;
  final String deck;
  final String result;

  BattleLogPlayer({required this.name, required this.deck, required this.result});
}

class BattleLogTurn {
  final String turnTitle;
  final String body;
  final String player;
  final Map<String, int> prizesAfterTurn;
  final List<BattleLogAction> actions;

  BattleLogTurn({required this.turnTitle, required this.body, required this.player, required this.prizesAfterTurn, required this.actions});
}

BattleLog parseBattleLog(String log, String id, String createdAt, String? userEnteredArchetype, String? currentUserScreenName) {
  final cleanedLog = trimBattleLog(log);
  List<String> playerNames = getPlayerNames(cleanedLog);

  if (shouldReversePlayers(currentUserScreenName, playerNames)) {
    playerNames = [playerNames[1], playerNames[0]];
  }

  final winner = determineWinner(cleanedLog);
  final players = playerNames.map((player) {
    final deck = (currentUserScreenName != null &&
            player.toLowerCase() == currentUserScreenName.toLowerCase() &&
            userEnteredArchetype != null && userEnteredArchetype != '')
        ? userEnteredArchetype
        : determineArchetype(cleanedLog, player);
    final result = (winner == player) ? 'W' : 'L';

    return BattleLogPlayer(name: player, deck: deck ?? '', result: result);
  }).toList();

  return BattleLog(
    id: id,
    players: players,
    date: createdAt,
    winner: winner,
    sections: divideBattleLogIntoSections(cleanedLog),
  );
}

List<BattleLogTurn> divideBattleLogIntoSections(List<String> cleanedLog) {
  final playerNames = getPlayerNames(cleanedLog);

  List<BattleLogTurn> sections = [];
  String? currentTitle = "Setup"; // Default to "Setup" for the initial section
  List<String> currentBody = [];
  Map<String, int> prizes = {
    playerNames[0]: 6,
    playerNames[1]: 6,
  };
  bool firstTurnFound = false;

  for (final line in cleanedLog) {
    if (RegExp(r"Turn\s+#\s+\d+\s+-\s+.*'s\s+Turn").hasMatch(line)) {
      if (currentTitle != null && currentBody.isNotEmpty) {
        sections.add(BattleLogTurn(
          turnTitle: currentTitle,
          body: currentBody.join('\n'),
          player: getPlayerFromActionLine(currentTitle, playerNames),
          prizesAfterTurn: prizes,
          actions: getTurnActions(currentBody),
        ));
        currentBody = [];
        // Do NOT reset the prize map... That should persist
      }

      currentTitle = line;
      firstTurnFound = true;
    } else {
      if (line.contains('took') && line.contains('Prize card')) {
        int prizesTaken = 0;

        if (line.contains('took a Prize card')) {
          prizesTaken = 1;
        } else {
          final match = RegExp(r"took (\d)").firstMatch(line);
          prizesTaken = int.tryParse(match?.group(1) ?? '0') ?? 0;
        }

        final currentPlayer = getPlayerFromActionLine(line, playerNames);
        prizes = {
          ...prizes,
          currentPlayer: prizes[currentPlayer]! - prizesTaken,
        };
      }

      currentBody.add(line);
    }
  }

  if (currentTitle != null && currentBody.isNotEmpty) {
    sections.add(BattleLogTurn(
      turnTitle: currentTitle,
      body: currentBody.join('\n'),
      player: getPlayerFromActionLine(currentTitle, playerNames),
      prizesAfterTurn: prizes,
      actions: getTurnActions(currentBody),
    ));
  }

  return sections;
}

List<String> getPlayerNames(List<String> log) {
  final playerNames = log.fold<List<String>>([], (acc, curr) {
    if (!curr.toLowerCase().contains("'s turn")) return acc;
    if (acc.any((player) => curr.contains(player))) return acc;

    final name = RegExp(r"- (.*)'s Turn").firstMatch(curr)?.group(1);
    if (name == null) throw Exception('Name not found in correct log line');

    return [...acc, name];
  });

  if (playerNames.length != 2) {
    throw Exception('Error: not two players found in battle log.');
  }

  return playerNames;
}

List<String> trimBattleLog(String log) {
  return log.split('\n').fold<List<String>>([], (acc, curr) {
    if (curr.isEmpty || curr == '\n' || curr.contains('shuffled their deck.')) return acc;
    return [...acc, curr];
  });
}

bool shouldReversePlayers(String? currentScreenName, List<String> playerNames) {
  // because it doesn't matter
  if (currentScreenName == null) return false;

  if (playerNames[1].toLowerCase() == currentScreenName.toLowerCase()) return true;

  return false;
}

String determineWinner(List<String> log) {
  for (var line in log) {
    final match = RegExp(r'\. (.*) wins\.').firstMatch(line);
    if (match != null) {
      return match.group(1)!;
    }
  }

  throw Exception('No winner found');
}

// A list of Pokémon names to find in the battle log.
final List<String> pokemonToFind = [
  // Niche unplayed decks that have priority over the others
  'gouging fire',
  'cinderace',

  // Tier one as of 2024
  'regidrago',
  'miraidon',
  'snorlax',
  'roaring moon',
  'banette',
  'raging bolt',
  'lugia',
  'chien-pao',
  'gardevoir',
  'dragapult',
  'iron thorns',
  'charizard',

  // Tier two and below
  'regigigas',
  'gholdengo',
  'origin forme palkia',
  'hisuian zoroark',
  'terapagos',
  'giratina',
  'arceus',
  'comfey',
  'entei',
  'great tusk',
  'klawf',
  'iron hands',
  'galvantula',
  'lunatone',

  // Rogue decks
  'flamigo',
  'aegislash',
  'toedscruel',
  'conkeldurr',
  'incineroar',
  'bloodmoon ursaluna',
  'origin forme dialga',
  'venusaur',
  'espathra',
  'kingdra',
  'venomoth',
  'tinkaton',
  'tsareena',
  'hydrapple',

  // Secondary decks
  'iron valiant',
  'ogerpon',
  'pidgeot',
  'flutter mane',
  'sneasler'
];

// A map associating certain Pokémon to specific PNG names.
final Map<String, String> pngMap = {
  'bloodmoon ursaluna': 'ursaluna-bloodmoon',
  'origin forme dialga': 'dialga-origin',
  'origin forme palkia': 'palkia-origin',
  'hisuian zoroark': 'zoroark-hisui'
};

// A class representing Pokémon that can help infer a deck archetype based on association.
class AssociatedPokemon {
  String association;
  String deck;

  AssociatedPokemon({required this.association, required this.deck});
}

// A list of Pokémon that might indicate an archetype via association.
final List<AssociatedPokemon> associatedPokemon = [
  AssociatedPokemon(association: 'charmander', deck: 'charizard'),
  AssociatedPokemon(association: 'dreepy', deck: 'dragapult'),
  AssociatedPokemon(association: 'frigibax', deck: 'chien-pao'),
  AssociatedPokemon(association: 'ralts', deck: 'gardevoir'),
  AssociatedPokemon(association: 'shuppet', deck: 'banette'),
  AssociatedPokemon(association: 'applin', deck: 'dipplin'),
  AssociatedPokemon(association: 'joltik', deck: 'galvantula'),
  AssociatedPokemon(association: 'venonat', deck: 'venomoth'),
];

String? determineArchetype(List<String> log, String playerName) {
  final drawnCardsLines = log.where((line) {
    return line.contains('$playerName attached') ||
        line.contains('$playerName played ') ||
        (line.contains('$playerName drew ') && line.contains('and played it to the Bench')) ||
        line.contains('$playerName evolved ') ||
        (line.contains("${playerName}'s ") && (line.contains('was Knocked Out') || (line.contains(' used') && !line.contains('damage'))));
  }).toList();

  String? archetype = pokemonToFind.firstWhere(
    (targetMon) => drawnCardsLines.any((drawnCards) => drawnCards.toLowerCase().contains(targetMon.toLowerCase())),
    orElse: () => '',
  );

  String? associatedArchetype = associatedPokemon.firstWhere(
    (targetMon) => drawnCardsLines.any((drawnCards) => drawnCards.toLowerCase().contains(targetMon.association.toLowerCase())),
    orElse: () => AssociatedPokemon(association: '', deck: ''),
  ).deck;

  if (associatedArchetype != '') archetype = associatedArchetype;

  final foundMapTypeIdx = pngMap.keys.toList().indexWhere((key) => key == archetype?.toLowerCase());
  if (foundMapTypeIdx >= 0) {
    return pngMap.entries.toList()[foundMapTypeIdx].value;
  }

  return archetype.replaceAll(' ', '-');
}

String getPlayerFromActionLine(String line, List<String> playerNames) {
  return playerNames.firstWhere(
    (player) => line.contains(player),
    orElse: () => ''
  );
}

class BattleLogAction {
  String title;
  List<String> details;

  BattleLogAction({required this.title, required this.details});
}

List<BattleLogAction> getTurnActions(List<String> turnLines) {
  final textThatIndicatesSubaction = [
    'A card was added',
    ' was added to ',
    ' was discarded from',
    ' can no longer use VSTAR Powers',
    'is now in the Active Spot',
    ' for the opening coin flip',
    ' won the coin toss',
    ' took at least 1 mulligan',
    ' drew 7 cards for the opening hand',
    ' was activated.'
  ];

  List<BattleLogAction> actions = [];

  for (var line in turnLines) {
    if (line.trim().isNotEmpty && 
        (line.trim()[0] == '-' || line.trim()[0] == '•' || 
         textThatIndicatesSubaction.any((text) => line.contains(text)))) {
      if (actions.isNotEmpty) {
        actions.last.details.add(line);
      }
    } else {
      actions.add(BattleLogAction(
        title: line,
        details: [],
      ));
    }
  }

  return actions;
}