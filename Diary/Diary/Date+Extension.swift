//
//  String+Extension.swift
//  Diary
//
//  Created by 유준상 on 2022/02/16.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
