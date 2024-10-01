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
    
    var effectiveTipPercentage: Double {
        guard billAmount > 0 else { return 0.0 }
        return ((total - billAmount) / billAmount) * 100
    }
    
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
        if billAmount == 0 {
            return 0.0
        }
        
        return billAmount + max(0.01, billAmount * (tipPercentage / 100 ))
    }
    
    var minTip: Double {
        max(0.01, billAmount * 0.01)
    }
    
    // If roundToNearest is true, return a rounded total, otherwise, return the unrounded total
    var total: Double {
        if roundToNearest {
            if billAmount == 0 {
                return 0.0
            }
            
            let roundedTotal = unroundedTotal.rounded()
            
            if (roundedTotal - billAmount < minTip) {
                return billAmount + minTip
            }
            
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
    
    enum Field {
        case billAmount, tipPercentage
    }
    
    @FocusState private var focusedField: Field?
    
    @State private var isEditingTipPercentage: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                Text("Tip Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 25)
            }
            VStack {
                HStack {
                // https://www.hackingwithswift.com/quick-start/swiftui/how-to-format-a-textfield-for-numbers
                    Text("Bill Amount: $")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                    TextField("0.00", value: $billAmount, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .billAmount)
                        .padding(.leading, -5)
                }
                .padding()
                .padding(.top, 20)
                .padding(.bottom, -25)
            }

            VStack {
                HStack {
                    Text("Tip percentage:")
                        .font(.headline)
                        .fontWeight(.bold)
                    Slider(value: $tipPercentage, in: 1...50, step: 1.0)
                    
                    if isEditingTipPercentage {
                        // Show the TextField for manual percentage input
                        TextField("Enter %", value: $tipPercentage, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .tipPercentage)
                    } else {
                        Text("\(tipPercentage, specifier: "%.0f")%")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .onTapGesture {
                                isEditingTipPercentage = true
                                focusedField = .tipPercentage
                            }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                            isEditingTipPercentage = false
                        }
                    }
                }
                
                Text("Effective tip percentage: \(effectiveTipPercentage, specifier: "%.1f")%")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .padding(.top, -20)
                    .padding(.bottom, 20)
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
                .padding(.bottom, 10)
                                
            }
            .padding()
            
            VStack {
                Toggle(isOn: $roundToNearest) {
                    Text("Round total to nearest dollar")
                    Text("Rounding will not lower total below bill amount")
                        .font(.caption)
                }
            }
            .padding()
            .padding(.vertical, 15)
            
            VStack {
                Text("Number of people splitting the bill:")
                    .multilineTextAlignment(.center)
                    .padding(.top, 15)
                
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
                    .padding(.top, -10)
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
                HStack {
                    Text("Grand Total:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("$\(total, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Tip:")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("$\(tip, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 10)
                Text("Total Bill per person: $\(splitTotal, specifier: "%.2f")")
                    .font(.headline)
                Text("Total Tip per person: $\(splitTip, specifier: "%.2f")")
                    .font(.headline)
            }
            .padding()
            .padding(.vertical, 10)
            
            VStack {
                ShareLink(item: shareText()) {
                    Label("Share Details", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .padding()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }

    func shareText() -> String {
        return """
        Bill amount: $\(String(format: "%.2f", billAmount))
        Tip percentage: \(String(format: "%.1f", effectiveTipPercentage))%
        Tip: $\(String(format: "%.2f", tip))
        Grand total: $\(String(format: "%.2f", total))
        Total per person: $\(String(format: "%.2f", splitTotal))
        Tip per person: $\(String(format: "%.2f", splitTip))
        """
    }
}
#Preview {
    ContentView()
}
