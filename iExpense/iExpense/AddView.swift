//
//  AddView.swift
//  iExpense
//
//  Created by CHIARELLO Berardino - ADECCO on 07/05/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses : Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertIsShowed = false
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form{
                TextField("Name", text: $name)
                
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "Eur"))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Add new Expense")
            .toolbar {
                Button("Save") {
                    
                    if name.isEmpty || type.isEmpty || amount == 0.0 {
                        setAlert(title: "Error", message: "Something missing")
                    } else {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            }
        }
        .alert(alertTitle, isPresented: $alertIsShowed) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func setAlert (title: String, message: String){
        alertTitle = title
        alertMessage = message
        alertIsShowed = true
    }
    
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
