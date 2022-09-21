//
//  User.swift
//  CombineSkeletonView
//
//  Created by 新垣 清奈 on 2022/09/21.
//

import Foundation

struct User {
    let name: String
    let email: String
    let avatarUrl: String

    static var mock: User {
        .init(name: "Anies", email: "anies@gmail.com", avatarUrl: "https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png")
    }
}
