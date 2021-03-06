//
//  LocalMediaRecord.swift
//  Exposure
//
//  Created by Fredrik Sjöberg on 2017-10-19.
//  Copyright © 2017 emp. All rights reserved.
//

import Foundation
import Exposure

internal struct LocalMediaRecord: Codable {
    /// Id for the asset at `bookmarkURL`
    internal let assetId: String
    
    /// Related entitlement
    internal let entitlement: PlaybackEntitlement?
    
    /// URL encoded as bookmark data
    internal let urlBookmark: Data?
    
    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        assetId = try container.decode(String.self, forKey: .assetId)
        entitlement = try container.decodeIfPresent(PlaybackEntitlement.self, forKey: .entitlement)
        urlBookmark = try container.decodeIfPresent(Data.self, forKey: .urlBookmark)
    }
    
    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(assetId, forKey: .assetId)
        try container.encodeIfPresent(entitlement, forKey: .entitlement)
        try container.encodeIfPresent(urlBookmark, forKey: .urlBookmark)
    }
    
    internal init(assetId: String, entitlement: PlaybackEntitlement?, completedAt location: URL?) throws {
        self.assetId = assetId
        self.entitlement = entitlement
        self.urlBookmark = try location?.bookmarkData()
    }
    
    internal enum CodingKeys: String, CodingKey {
        case assetId
        case entitlement
        case urlBookmark
    }
}
