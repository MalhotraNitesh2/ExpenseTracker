//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Nitesh Malhotra on 05/10/23.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM : transactionListViewModel
    var body: some View {
        VStack{
            List {
                ForEach(Array(transactionListVM.groupTransactionByMonth()),id : \.key){
                    month, transactions in
                    Section {
                        ForEach(transactions){ transaction in
                            TransactionRow(transaction : transaction)
                        }
                    }header: {
                        Text(month)
                    }
                    .listRowSeparator(.hidden)
                }
                
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider{
    static let transactionListVM : transactionListViewModel = {
        let transactionListVM = transactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews : some View {
        Group{
            NavigationView{
                TransactionList()
            }
            NavigationView{
                TransactionList()
            }
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}

