//
//  UUID+extension.swift
//  ERepair
//
//  Created by Никитин Артем on 5.06.23.
//

import Foundation

// что-бы UUID поддерживался в качестве ключа словарей, которые приходят в codable
extension UUID: CodingKeyRepresentable {
    public init?<T>(codingKey: T) where T: CodingKey {
        self.init(uuidString: codingKey.stringValue)
    }

    public var codingKey: CodingKey { uuidString.codingKey }
}
