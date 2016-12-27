//
//  SocialMedia.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/8/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

enum SocialMedia {
    case facebook
    case twitter
    case instagram
    
    var url: URL {
        
        let url: String
        
        switch self {
        case .twitter:
            url = "https://twitter.com/losaltoshacks"
        case .facebook:
            url = "https://www.facebook.com/events/584690041683677"
        case .instagram:
            url = "https://www.instagram.com/losaltoshacks"
        }
        
        return URL(string: url)!
    }
}
