//
//  ContentView.swift
//  ExpenseTracker
//


import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM : transactionListViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading,spacing: 24){
                    Text("Overview")
                        .font(.title2)
                        .bold()
                        var demoData = transactionListVM.accumlateTransactions()
                        var title = "$" + String(demoData.last ?? 0.00 )
                        LineChartView(data : demoData,title: title , form: ChartForm.extraLarge)
                        RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon,.primary)
                    
                    
                }
            }
           
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
        
        
    }
}

struct ContentView_Previews:PreviewProvider{
    
    static let transactionListVM : transactionListViewModel = {
        let transactionListVM = transactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews:some View {
        Group{
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
        .environmentObject(transactionListVM)
   }
}
