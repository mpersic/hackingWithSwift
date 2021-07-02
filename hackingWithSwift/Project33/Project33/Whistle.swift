//
//  Whistle.swift
//  Project33
//
//  Created by COBE on 26/06/2021.
//

import CloudKit
import UIKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
