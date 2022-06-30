//
//  PhoneFormat.swift
//  DimitriForm
//
//  Created by Kei on 4/30/22.
//

import Foundation
import UIKit

/**
 Phone Format Class. Conatin format and related regexp
*/
public struct PhoneFormat {

    /**
     Phone format
     */
    public let phoneFormat: String

    /**
     Phone regexp for the format
     */
    public let regexp: String

    public init(defaultPhoneFormat: String) {
        self.phoneFormat = defaultPhoneFormat
        self.regexp = "*"
    }

    public init(phoneFormat: String, regexp: String) {
        self.phoneFormat = phoneFormat
        self.regexp = regexp
    }
}
