//
//  RecentReportsTestsFail.swift
//  AuthO
//
//  Created by Usuario on 14/10/25.
//
import Testing
@testable import AuthO
struct RecentReportsTestsFail {
    @Test
    func feedExpectedNewestFirstAndFirstIsMostRecentFails() throws {
        let cards = ExampleCards.cards
        try? #require(!cards.isEmpty, "At least one report must exist in the feed.")
        let mostRecent = cards.max(by: { $0.creationDate < $1.creationDate })!
        try? #require(cards.first!.id == mostRecent.id, "This test will fail: the current feed does NOT start with the most recent report.")
        for i in 1..<cards.count {
            try? #require(cards[i - 1].creationDate >= cards[i].creationDate, "This test will fail: descending order (newest->oldest) is assumed.")
        }
    }
    @Test
    func topThreeRecentReportsMatchFirstThreeFromFeedFails() throws {
        let cards = ExampleCards.cards
        try? #require(cards.count >= 3, "At least 3 reports are required for this validation.")
        let top3ByDateDesc = Array(cards.sorted { $0.creationDate > $1.creationDate }.prefix(3))
        let first3FromFeed = Array(cards.prefix(3))
        let expectedIds = Set(top3ByDateDesc.map { $0.id })
        let firstIds = Set(first3FromFeed.map { $0.id })
        try? #require(expectedIds == firstIds, "This test will fail: the top 3 recent reports do not match the first 3 in the feed.")
        try? #require(top3ByDateDesc.first!.id == cards.first!.id, "This test will fail: the most recent report is not the first one in the feed.")
    }
}
