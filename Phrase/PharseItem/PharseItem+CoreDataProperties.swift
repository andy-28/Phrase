//
//  PharseItem+CoreDataProperties.swift
//  Phrase
//
//  Created by 江啟綸 on 2022/5/21.
//
//

import Foundation
import CoreData


extension PharseItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PharseItem> {
        return NSFetchRequest<PharseItem>(entityName: "PharseItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createAt: Date?

}

extension PharseItem : Identifiable {

}
