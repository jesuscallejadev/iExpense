//
//  AddView.swift
//  iExpense
//
//  Created by Jesus Calleja on 8/11/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "EUR"
    
    let types = ["Business", "Personal"]
    let currencies = ["USD", "EUR", "JPY", "GBP"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("", text: $name)
                    .placeholder(when: name.isEmpty) {
                        Text("Name").foregroundColor(.white)
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.black)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.menu)
                .listRowBackground(Color.black)
                
                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .id(currency)
                    .keyboardType(.decimalPad)
                    .listRowBackground(Color.black)
                    .foregroundColor(.white)
                
                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }
                .listRowBackground(Color.black)
                .pickerStyle(.segmented)
            }
            .padding(.top, 16)
            .background(.black)
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, currencyCode: currency, amount: amount, id: UUID())
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
