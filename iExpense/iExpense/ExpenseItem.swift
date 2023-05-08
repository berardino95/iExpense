//
//  ExpenseItem.swift
//  iExpense
//
//  Created by CHIARELLO Berardino - ADECCO on 07/05/23.
//

import Foundation

//This is the struct with the property of each Expense item

struct ExpenseItem: Identifiable, Codable {
    var name : String
    var type : String
    var amount: Double
    var id = UUID()
}
