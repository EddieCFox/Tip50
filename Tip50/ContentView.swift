//
//  ContentView.swift
//  Tip50
//
//  Created by Eddie Christopher Fox III on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var billAmount: Double = 0.0
    @State var tipPercentage: Double = 20.0
    
    // The number of people the bill is being split between
    @State var selectedSplitCount: String = "1"
    @State var otherSplitCount: String = ""
    
    @State var roundToNearest: Bool = false
    
    // Computed properties for tip and total
    // See: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#
    var tip: Double {
        return total - billAmount
    }
    
    // Total without any rounding
    var unroundedTotal: Double {
        billAmount + (billAmount * (tipPercentage / 100 ))
    }
    
    // If roundToNearest is true, return a rounded total, otherwise, return the unrounded total
    var total: Double {
        if roundToNearest {
            return unroundedTotal.rounded()
        }
        
        return unroundedTotal
    }
    
    var splitTotal: Double {
        return (total / Double(splitCount))
    }
    
    var splitTip: Double {
        return (tip / Double(splitCount))
    }
    
    var splitCount: Int {
        if selectedSplitCount == "Other" {
            return Int(otherSplitCount) ?? 1
        }
        
        else {
            return Int(selectedSplitCount) ?? 1
        }
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
                TextField("0.00", value: $billAmount, format: .number)
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
            
        }
        
        VStack {
            HStack {
                Text("Tip percentage:")
                    .font(.headline)
                Slider(value: $tipPercentage, in: 0...40, step: 1.0)
                Text("\(tipPercentage, specifier: "%.0f")")
                Text("%")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding()
            Text("Common percentages")
                .font(.subheadline)
                .fontWeight(.medium)

            Picker("Common percentages", selection: $tipPercentage) {
                Text("10%").tag(10.0)
                Text("15%").tag(15.0)
                Text("18%").tag(18.0)
                Text("20%").tag(20.0)
                Text("25%").tag(25.0)
            }
            .pickerStyle(.segmented)
            
            Toggle(isOn: $roundToNearest) {
                Text("Round to nearest dollar")
            }
            
        }
        .padding()

        VStack {
            
            Text("Number of people splitting the bill:")
                .padding()
                .multilineTextAlignment(.center)
            
            HStack {

                Picker("Number of people", selection: $selectedSplitCount) {
                    Text("1").tag("1")
                    Text("2").tag("2")
                    Text("3").tag("3")
                    Text("4").tag("4")
                    Text("5").tag("5")
                    Text("6").tag("6")
                    Text("Other").tag("Other")
                }
                .pickerStyle(.segmented)
                .padding()
                
                if selectedSplitCount == "Other" {
                    TextField("# of people", text: $otherSplitCount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
            }
        }
        
        VStack {
            Text("Total Bill per person: $\(splitTotal, specifier: "%.2f")")
            Text("Total Tip per person: $\(splitTip, specifier: "%.2f")")
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
