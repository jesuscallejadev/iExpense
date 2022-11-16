//
//  ContentView.swift
//  iExpense
//
//  Created by Jesus Calleja on 4/11/22.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    init() {
        UITableView.appearance().backgroundColor =  UIColor.black
        UITableView.appearance().separatorColor = UIColor.white
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    private func getColorFromAmount(amount: Double) -> Color {
        if(amount < 10.0) {
            return Color.red
        } else if(amount > 10.0 && amount < 100.0) {
            return Color.blue
        } else {
            return Color.green
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                if(!expenses.items.filter {
                    $0.type == "Personal"
                }.isEmpty) {
                    Section(header: Text("Personal")
                        .foregroundColor(.gray)
                        .bold()
                    ) {
                        ForEach(expenses.items.filter {
                            $0.type == "Personal"
                        }) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(item.type)
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: item.currencyCode))
                                    .foregroundColor(getColorFromAmount(amount: item.amount))
                            }
                            .listRowBackground(Color.black)
                            
                            
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                if(!expenses.items.filter {
                    $0.type == "Business"
                }.isEmpty) {
                    Section(header: Text("Business")
                        .foregroundColor(.gray)
                        .bold()
                    ) {
                        ForEach(expenses.items.filter {
                            $0.type == "Business"
                        }) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(item.type)
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                Text(item.amount, format: .currency(code: item.currencyCode))
                                    .foregroundColor(getColorFromAmount(amount: item.amount))
                            }
                            .listRowBackground(Color.black)
                            
                            
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .padding(.top, 16)
            .background(.black)
            .navigationTitle("iExpense")
            .font(.headline).background(.white)
            .toolbar {
                Button {
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
