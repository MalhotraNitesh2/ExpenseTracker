//
//  TransactionPreviewListViewModel.swift
//  ExpenseTracker


import Foundation
import Combine
import  Collections

typealias TransactionGroup = OrderedDictionary <String , [Transaction]>
typealias TransactionPrefixSum = [Double]
final class  transactionListViewModel : ObservableObject{
    @Published var transactions : [Transaction] = []
    private var cancellables = Set <AnyCancellable>()
    
    init(){
        getTransaction()
    }
    
    func getTransaction(){
        guard let url = URL(string: "https://designcode.io/data/transactions.json")else{
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url )
            .tryMap { (data, response)-> Data  in
                guard let httpResponse =  response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self , decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { Completion in
                switch Completion {
                case .failure(let error):
                    print("fatal error fetcging transactions",error.localizedDescription)
                case .finished :
                    print("finished")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in:  &cancellables)
    }
    
    func groupTransactionByMonth ()-> TransactionGroup{
        guard !transactions.isEmpty else { return [:]}
        let groupedTransactions = TransactionGroup(grouping : transactions){  $0.month}
        return groupedTransactions
    }
    
    func accumlateTransactions()-> TransactionPrefixSum{
        guard !transactions.isEmpty else{ return[] }
        
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)
        
        var sum : Double = .zero
        var cummulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval!.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transactions.filter({ $0.dateParsed == date && $0.isExpense })
            let dailtTotal = dailyExpenses.reduce(0){$0 - $1.signedamount}
            
            sum += dailtTotal
            sum = sum.Roundof2digits()
            cummulativeSum.append(sum)
            
        }
        
        return cummulativeSum
    }
}
