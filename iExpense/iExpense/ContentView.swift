//
//  ContentView.swift
//  iExpense
//
//  Created by CHIARELLO Berardino - ADECCO on 07/05/23.
//

import SwiftUI


struct ContentView: View {
    //Here we are creating an instance of Expense that is an array of ExpenseItem, marking it as StateObject is the same thing as marking a variable state
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                //iterating over our array accessing by expense.items passing as id the name of the ExpenseItem, our item conform to Identifiable protocol, in this case we don't need to specify the id in the ForEach
                ForEach($expenses.items){ $item in
                    NavigationLink (destination: ModifyItemView(expenses: expenses, item: $item),
                                    label: {
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.callout)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "Eur"))
                        }
                    })
                    .accessibilityElement()
                    .accessibilityLabel("\(item.name) amount: \(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "Eur")))")
                    .accessibilityHint(item.type)
                }
                .onDelete(perform: removeExpense)
            }
            .navigationTitle("iEpense")
            .toolbar {
                //adding a button on NavigationBar that append an example value
                Button{
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeExpense(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
