//
//  TweetFilterViewModel.swift
//  CloneTwitter
//
//  Created by andres holivin on 05/06/22.
//

import Foundation

enum TweetFilterViewModel : Int, CaseIterable{
    case tweets
    case replies
    case likes
    var title: String {
        switch self {
        case .tweets : return "Tweets"
        case .replies : return "Replies"
        case .likes : return "Likes"
        }
    }
}
