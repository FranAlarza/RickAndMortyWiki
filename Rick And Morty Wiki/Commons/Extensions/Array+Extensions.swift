//
//  Array+Extensions.swift
//  Rick and Morty Wiki
//
//  Created by Francisco Javier Alarza on 21/7/23.
//

import Foundation

extension Array where Element: Identifiable {
    func isLast(_ item: Element) -> Bool {
        guard let lastItem = self.last else {
            return false
        }

        return lastItem.id == item.id
    }
}
