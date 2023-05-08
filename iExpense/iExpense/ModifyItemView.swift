//
//  ModifyItemView.swift
//  iExpense
//
//  Created by CHIARELLO Berardino - ADECCO on 08/05/23.
//

import SwiftUI

struct ModifyItemView: View {
    
    @ObservedObject var expenses : Expenses
    @Environment(\.dismiss) var dismiss
    
    @Binding var item : ExpenseItem
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertIsShowed = false
    
    let types = ["Business", "Personal"]
    
    var body: some View {
            Form{
                TextField("Name", text: $item.name)
                
                
                Picker("Type", selection: $item.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                
                TextField("Amount", value: $item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "Eur"))
                    .keyboardType(.decimalPad)
                
            }
            .toolbar {
                Button("Save") {
                    
                    if item.name.isEmpty || item.type.isEmpty || item.amount == 0.0 {
                        setAlert(title: "Error", message: "Something missing")
                    } else {
                        let modifiedItem = ExpenseItem(name: item.name, type: item.type, amount: item.amount)
                        
                        for item in expenses.items {
                            if item.id == self.item.id {
                                self.item = modifiedItem
                            } else {
                                continue
                            }
                        }
                        dismiss()
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

struct ModifyItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyItemView(expenses: Expenses(), item: .constant(ExpenseItem(name: "Test", type: "Personal", amount: 20.05)))
            .environmentObject(Expenses())
    }
}
