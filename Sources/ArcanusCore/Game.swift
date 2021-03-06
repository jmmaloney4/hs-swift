// Copyright © 2017 Jack Maloney. All Rights Reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation

public class Game {
    internal struct Rules {
        var cardsInDeck: Int = 30
        var startingHandSizeGoFirst: Int = 3
        var startingHandSizeGoSecond: Int = 4
        var maxManaCrystals: Int = 10
        // var defaultHeroHealth: Int = 30
        var maxMinionsOnBoard: Int = 7
        var maxCardsInHand: Int = 10
        var maxCardsInDeck: Int = 60
    }

    internal static let defaultRules = Rules()

    internal private(set) var rules: Rules = Rules()
    
    internal private(set) var rng: Random
    internal private(set) var players: [Player]
    internal private(set) var firstPlayer: Int!
    internal private(set) var board: Board
    internal private(set) var hasEnded: Bool
    internal private(set) var hasStarted: Bool = false
    internal private(set) var turn: Int

    public init(playerOneInterface interfacePlayer1: inout PlayerInterface,
                deckPath deckPathPlayer1: String,
                playerTwoInterface interfacePlayer2: inout PlayerInterface,
                deckPath deckPathPlayer2: String)
    {
        rng = Random()
        firstPlayer = rng.next(upTo: 1)
        players = []
        board = Board()
        hasEnded = false
        turn = 0

        players.append(try! Player(isPlayerOne: true,
                              isGoingFirst: firstPlayer == 0,
                              interface: &interfacePlayer1,
                              deckPath: deckPathPlayer1,
                              game: self))

        players.append(try! Player(isPlayerOne: false,
                              isGoingFirst: firstPlayer == 1,
                              interface: &interfacePlayer2,
                              deckPath: deckPathPlayer2,
                              game: self))

    }

    public func start() {
        // players[0].runMulligan()
        // players[1].runMulligan()
                
        hasStarted = true

        while !hasEnded {
            players[turn % 2].takeTurn(turn)
            turn += 1
        }
    }

    internal var charactersInPlay: [Character] {
        get {
            var rv: [Character] = [players[0].hero, players[1].hero]
            for p in players {
                for c in p.board {
                    rv.append(c)
                }
            }
            return rv
        }
    }

    // -1 so when incremented first card will have id = 0
    private var entityID = -1
    func getNextEntityID() -> Int {
        entityID += 1
        return entityID
    }
}
