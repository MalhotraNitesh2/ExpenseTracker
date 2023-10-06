//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Nitesh Malhotra on 27/09/23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transacationListVM = transactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transacationListVM)
        }
    }
}
