//
//  iExpense_HomeView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 29/01/2023.
//

import SwiftUI

struct Project7_iExpense: View {
    @StateObject var expenses = Expenses()
    @State private var show_addExpenseView = true
    
    //Challenge:
    @State var switch_Type = "Personal"
    let switch_Types = ["Personal", "Business"]
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $switch_Type) {
                    ForEach(switch_Types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                List {
                    ForEach(expenses.items) { item in
                        if switch_Type == item.type {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: item.countryCode))
                                    .foregroundColor( item.amount <= 10 || item.amount <= 100 && item.amount > 10 ? .red : .green)
                            }
                        } else {
                            
                        }
                    }
                    .onDelete(perform: removeItem)
                }
                Spacer()
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button {
                    show_addExpenseView = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $show_addExpenseView) {
                ExpenseAddView(expenses: expenses)
            }
            
        }
    }
    
    func removeItem(atIndex: IndexSet) {
        expenses.items.remove(atOffsets: atIndex)
    }
}

struct Project7_iExpense_Previews: PreviewProvider {
    static var previews: some View {
        SecondView_sheet()
    }
}

