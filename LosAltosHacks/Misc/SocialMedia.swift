//
//  SocialMedia.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/8/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

enum SocialMedia {
    case Facebook
    case Twitter
    case Instagram
    
    var url: NSURL {
        
        let url: String
        
        switch self {
        case .Twitter:
            url = "https://twitter.com/losaltoshacks"
        case .Facebook:
            url = "https://www.facebook.com/events/584690041683677"
        case .Instagram:
            url = "https://www.instagram.com/losaltoshacks"
        }
        
        return NSURL(string: url)!
    }
}
