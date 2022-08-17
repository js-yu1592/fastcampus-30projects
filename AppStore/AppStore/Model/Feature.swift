//
//  Feature.swift
//  AppStore
//
//  Created by 유준상 on 2022/05/19.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
