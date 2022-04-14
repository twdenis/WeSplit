//
//  ContentView.swift
//  WeSplit
//
//  Created by Denis on 23/02/22.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 35, weight: .heavy, design: .monospaced))
            
            .foregroundColor(.blue)
            .padding()
    }
}
extension View {
    func beautifulBlue() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let bigTotal = checkAmount + tipValue
        return bigTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
   
    
    
    var body: some View {
        VStack {
            Spacer()
        Text ("WeSplit")
                .beautifulBlue()
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "BRL"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker ("Number of people", selection: $numberOfPeople) {
                        ForEach(0..<100) {
                            Text("\($0) people")
                            }
                        }
        
                    }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                    }
                }
                    
                } header: {
                    Text ("How much tip do you want to leave?")
                }
                Section {
                    Text (grandTotal, format: .currency (code: Locale.current.currencyCode ?? "BRL"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }
                
            header: {
                Text ("Amount + tip:")
                }
           
                Section {
                    Text (totalPerPerson, format: .currency (code: Locale.current.currencyCode ?? "BRL"))
                    }
            header: {
                Text ("Total per person:")
                }
            }
            //You should always attach this modifier to the view inside the navigation view rather than the navigation view itself.
            //.navigationTitle("WeSplit")
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    //tentar traduzir o nome do botao de acordo com a regiao
                    Spacer()
                    Button("🔽") {
                        amountIsFocused = false
                    }
                }
            }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
