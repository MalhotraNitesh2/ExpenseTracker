//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Nitesh Malhotra on 04/10/23.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM : transactionListViewModel
    var body: some View {
        VStack{
            HStack{
                Text("Recent Transaactions")
                    .bold()
                Spacer()
                
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing :4 ){
                        Text("see all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                
               
            }
            .padding(.top)
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id : \.element){index, transaction in
                TransactionRow(transaction:  transaction)
                
                Divider()
                    .opacity(index == 4 ?0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20 , style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x:0 ,y: 5 )
    }
}

struct RecentTransactionList_Previews: PreviewProvider{
    static let transactionListVM : transactionListViewModel = {
        let transactionListVM = transactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews : some View {
        Group{
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
