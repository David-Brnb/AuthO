//
//  ChartsTestsFail.swift
//  AuthO
//
//  Created by Usuario on 14/10/25.
//
import Testing
import Foundation
@testable import AuthO
struct ChartsTestsFail {
    @Test
    func usersContributionShouldHaveFiveDaysFails() throws {
        let data = ChartDataExamples.usersContribution
        try? #require(data.count == 5, "This test will fail: the series 'mistakenly' should have 5 days (but actually has 7).")
    }
    @Test
    func likedReportsPercentageAssumedZeroToOneHundredFails() throws {
        try? #require(ChartDataExamples.mostLikedPercentaje > 10.0, "This test will fail: percentage should not be > 10 based on current logic (mostLikedPercentaje <= 10.0).")
    }
    @Test
    func userDailyLikesTotalAssumedZeroFails() throws {
        try? #require(ChartDataExamples.totalLikesReports == 0, "This test will fail: the sum of daily likes is not 0 (each day has 1..10 likes).")
    }
    @Test
    func userContributionMaxAssumedZeroFails() throws {
        try? #require(ChartDataExamples.mostContributedDay.contributions == 0, "This test will fail: the day with the most contributions cannot be 0 (range is 1..10).")
    }
