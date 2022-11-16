//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Jesus Calleja on 7/11/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let name: String
    let type: String
    let currencyCode: String
    let amount: Double
    let id: UUID
}
