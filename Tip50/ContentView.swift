//
//  ContentView.swift
//  Tip50
//
//  Created by Eddie Christopher Fox III on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var billAmount = 0.0
    @State var tipPercentage = 0.0
    
    // Computed properties for tip and total
    // See: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#
    var tip: Double {
        return billAmount * (tipPercentage / 100)
    }

    var total: Double {
        return billAmount + tip
    }
    
    var body: some View {
        VStack {
            HStack {
            // https://www.hackingwithswift.com/quick-start/swiftui/how-to-format-a-textfield-for-numbers
                Text("Bill Amount:")
                    .font(.headline)
                    .padding(.leading, -10)
                Text("$")
                    .font(.headline)
                    .fontWeight(.bold)
                TextField("$0.00", value: $billAmount, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            HStack {
                Text("Tip:")
                    .font(.headline)
                Text("$\(tip, specifier: "%.2f")")
            }
            .padding()
            
            HStack {
                Text("Grand Total:")
                    .font(.headline)
                Text("$\(total, specifier: "%.2f")")
            }
            
            HStack {
                Text("Tip percentage:")
                    .font(.headline)
                TextField("%", value: $tipPercentage, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                Text("%")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding()
            
            Spacer()
        }
    }
}
#Preview {
    ContentView()
}
