//
//  Expenses.swift
//  iExpense
//
//  Created by CHIARELLO Berardino - ADECCO on 07/05/23.
//

import Foundation

//Here we are creating our array where store ExpenseItem, conforme to ObservableObject help use to track the change in the class and tell swiftUI when update the view

class Expenses: ObservableObject {
    //Using Published tell swiftUI to check the change of this variable
    @Published var items = [ExpenseItem]() {
        // runs a piece of code right after the property has changed
        didSet {
            //Encode our data in JSON and save to UserDefaults
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        //trying to retrive data from UserDefaults
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            //Trying to decode data, we write [ExposeItem].self because we are referring to the type itself, known as the type object
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                //Assigning decode data to our array
                items = decodedItems
                return
            }
        }
        //if data load fail, we initialize items as empty array
        items = []
    }
}
