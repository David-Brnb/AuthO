//
//  RecentPostTest.swift
//  AuthO
//
//  Created by Usuario on 14/10/25.
//
import Testing
@testable import AuthO
struct RecentReportsTests {
    @Test
    func feedDefaultOrderIsOldestToNewestAndLastIsMostRecent() throws {
        let cards = ExampleCards.cards
        try? #require(!cards.isEmpty, "At least one report must exist in the feed.")
        let mostRecent = cards.max(by: { $0.creationDate < $1.creationDate })!
        try? #require(cards.last!.id == mostRecent.id, "The last element in the feed must be the most recent by creation date.")
        for i in 1..<cards.count {
            try? #require(cards[i - 1].creationDate <= cards[i].creationDate, "The feed must be ordered from oldest to newest.")
        }
    }
    @Test
    func topThreeRecentReportsMatchLastThreeFromFeed() throws {
        let cards = ExampleCards.cards
        try? #require(cards.count >= 3, "At least 3 reports are required for this validation.")
        let top3ByDateDesc = Array(cards.sorted { $0.creationDate > $1.creationDate }.prefix(3))
        let last3FromFeed = Array(cards.suffix(3))
        let expectedIds = Set(top3ByDateDesc.map { $0.id })
        let lastIds = Set(last3FromFeed.map { $0.id })
        try? #require(expectedIds == lastIds, "The 3 most recent reports must match the last 3 reports in the feed.")
        try? #require(top3ByDateDesc.first!.id == cards.last!.id, "The most recent report must be the last one in the feed.")
    }
}
