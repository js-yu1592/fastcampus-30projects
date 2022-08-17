//
//  RankingFeature.swift
//  AppStore
//
//  Created by 유준상 on 2022/05/19.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
