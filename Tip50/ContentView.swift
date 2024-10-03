//
//  ContentView.swift
//  Tip50
//
//  Created by Eddie Christopher Fox III on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    
    // State variables - When these variables change,
    // the view is automatically re-rendered
    
    // Self explanatory
    // These are directly modified by using the text fields, sliders, and pickers in the UI of the app
    @State var billAmount: Double = 0.0
    @State var tipPercentage: Double = 20.0
    
    // Boolean that controls whether the calculator should round the total
    // to the nearest dollar or not. Controlled by the toggle switch near "Round total to nearest dollar"
    @State var roundToNearest: Bool = false
    
    // The number of people the bill is being split between
    @State var selectedSplitCount: String = "1"
    // Holds the split count typed in by the user if they select the "Other"
    // option instead of 1-6
    @State var otherSplitCount: String = ""

    // Boolean that indicates whether the user is manually editing the tip percentage
    // (as opposed to using the slider or common percentages)
    // When the user clicks the percentage, this is toggled to true, and a TextField is shown
    // When the user clicks "Done" on the keyboard, the value for the TextField is submitted,
    // this variable is set to false, and the TextField disappears
    @State private var isEditingTipPercentage: Bool = false
    
    // Custon enum to hold the different TextFields in our app
    enum Field {
        case billAmount, tipPercentage, splitCount
    }
    
    // FocusState variable that tracks which TextField, if any, is currently in focus on the application
    // Accepts an enum of our Field type, while also having the possibility of "nil", in which case,
    // no field is being focused
    @FocusState private var focusedField: Field?
    
    // Computed Properties - The values are not stored, but rather computed
    // on the fly every time the value is accessed
    // See: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Computed-Properties
    
    // This is either 1% of the bill or 1 cent, whichever one is larger
    // I assumed that people would want to tip at least 1% if they were using a tip calculator app
    // If this was a real app, I might set the minimum tip to 1 cent instead
    var minTip: Double {
        max(0.01, billAmount * 0.01)
    }
    
    // Total without any rounding
    // If the bill is zero, the total should also be zero (effectively meaning no tip)
    var unroundedTotal: Double {
        if billAmount == 0 {
            return 0.0
        }
        
        // Otherwise, it is the bill + the tip, with the tip being at least 1 cent
        return billAmount + max(0.01, billAmount * (tipPercentage / 100 ))
    }
        
    // If roundToNearest is true, return a rounded total, otherwise, return the unrounded total
    var total: Double {
        // If the bill is zero, the total should also be zero (effectively meaning no tip)
        if roundToNearest {
            if billAmount == 0 {
                return 0.0
            }
            
            let roundedTotal = unroundedTotal.rounded()
            
            // This ensures that the tip provided is at least the minimum tip of 1% / 1 cent
            // If the tip is less than the minimum tip, we add to the bill minimum tip instead of the tip
            if (roundedTotal - billAmount < minTip) {
                return billAmount + minTip
            }
            
            // If the tip is at least the minimum tip, return the rounded total that was previously calculated
            return roundedTotal
        }
        
        // If roundToNearest is not select, we simply return the unrounded total
        return unroundedTotal
    }
    
    // We have to calculate the tip based on the total.
    // If we calculated tip as billAmount * tipPercentage, this would not work well with rounding where we
    // need to round the total to the nearest dollar, and the only way to do that would be to increase the tip,
    // because we can't change the bill amount. If we define the total as bill + tip, then the total depends on the
    // tip, and in the case of rounding, the tip depends on the total, creating a circular dependency where both
    // variables depend on each other.

    // To break this circular dependency, I made the total the "source of truth" from which the tip is calculated from.
    var tip: Double {
        return total - billAmount
    }

    // Holds the actual tip percentage rather than the one the user selected
    // This can be different due to rounding (if the user selects this option)
    // If the bill amount is zero, return 0%, because we are forcing the tip
    // to be zero in this case
    var effectiveTipPercentage: Double {
        guard billAmount > 0 else { return 0.0 }
        return ((total - billAmount) / billAmount) * 100
    }
    
    // The amount of people who are splitting the bill
    // Attempt to parse as an int, otherwise use 1
    var splitCount: Int {
        if selectedSplitCount == "Other" {
            return Int(otherSplitCount) ?? 1
        }
        
        else {
            return Int(selectedSplitCount) ?? 1
        }
    }
    
    // Simply dividing the total by the number of people splitting the bill
    var splitTotal: Double {
        return (total / Double(splitCount))
    }

    // Dividing the tip by the number of people splitting the bill
    var splitTip: Double {
        return (tip / Double(splitCount))
    }
    
    // The body contains everything that is actually on the screen
    // Note: I will not explain basic SwiftUI elements in my comments, only where not as self-explanatory
    var body: some View {
        // We need to wrap everything in a ScrollView because otherwise, when the keyboard is brought up by
        // the billAmount or tipPercentage TextFields, the content can be pushed up to the point it merges
        // with the top of the screen (including the dynamic island, time, etc).
        // ScrollView means the content won't get pushed up,
        // but that the app can instead scroll while the keyboard is up
        ScrollView {
            VStack {
                Text("Tip50")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 25)
            }
            VStack {
                HStack {
                    Text("Bill Amount: $")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                    // See: https://www.hackingwithswift.com/quick-start/swiftui/how-to-format-a-textfield-for-numbers
                    // for how to format the TextField to take numbers specifically rather than strings
                    // We use decimalPad specifically so that the user can only type numbers and the decimal period
                    TextField("0.00", value: $billAmount, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                    // This changes the focusedField enum to indicate that the billAmount TextField is in focus
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
                    // Create a slider for tip percentage between 1-50%, with steps of 1%
                    // I didn't want to show any decimals within the slider, as that is uncommon for tips
                    Slider(value: $tipPercentage, in: 1...50, step: 1.0)
                    
                    // If the user has clicked the tip percentage to the right of the slider
                    if isEditingTipPercentage {
                        // Show the TextField for manual percentage input
                        // See billAmount comments for more particulars on the TextField + enums
                        TextField("Enter %", value: $tipPercentage, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .tipPercentage)
                        
                    // If the user hasn't clicked the tip percentage, show the tip percentage currently
                    // selected by the slider
                    } else {
                        Text("\(tipPercentage, specifier: "%.0f")%")
                            .font(.headline)
                            .fontWeight(.semibold)
                            // If the tip percentage is clicked, set the editing variable to true, which
                            // brings up the TextField and focuses the app on it
                            .onTapGesture {
                                isEditingTipPercentage = true
                                focusedField = .tipPercentage
                            }
                    }
                }
                .padding()
                
                // As stated in the variable explanation, this shows the actual tip percentage that is being
                // applied, regardless of what the user selected as the tip percentage. This can be
                // different due to rounding
                Text("Effective tip percentage: \(effectiveTipPercentage, specifier: "%.1f")%")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .padding(.top, -20)
                    .padding(.bottom, 20)
                
                Text("Common percentages")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                // Allows people to click common percentages. Defaults to 20%
                // Whenever the user clicks on a common percentage, it will update everything else,
                // Such as the tip percentage, effective tip percentage, etc.
                Picker("Common percentages", selection: $tipPercentage) {
                    Text("10%").tag(10.0)
                    Text("15%").tag(15.0)
                    Text("18%").tag(18.0)
                    Text("20%").tag(20.0)
                    Text("25%").tag(25.0)
                }
                .pickerStyle(.segmented)
                // Cyan is selected for a blue color that has decent readability in both light and dark mode
                // Regular blue more closely matches the slider and "Share Details" button, and also has
                // good readability in dark mode, but poor readability in light mode.
                // Without specifying any color, the default color is a different shade of grey,
                // which is a little boring
                .colorMultiply(.cyan)
                .padding(.bottom, 10)
                                
            }
            .padding()
            
            VStack {
                // Toggle switch to "turn on" and "turn off" rounding to the nearest dollar
                // In practice, this toggles roundToNearest between false and true (false by default)
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
                    // A picker that allows users to select how many people are splitting the bill
                    // If user clicks "Other", it will show a TextField for them to input the number of people
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
                    .colorMultiply(.cyan)
                    .padding(.top, -10)
                    .padding()
                    
                    if selectedSplitCount == "Other" {
                        TextField("# of people", text: $otherSplitCount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .splitCount)
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
                // Uses the ShareLink API to create a clickable Share" button that can be used to share
                // the relevant details with any other app that supports the ShareLink API, such as
                // messages, reminder, copying to clipboard, saving as text file, and others
                // The shareText() function below defines the text that is shared We pass this
                // function to the ShareLink as an argument
                ShareLink(item: shareText()) {
                    Label("Share Details", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .padding()
                }
            }
        }
        // The toolbar is placed on top of the keyboard that is brought up when the user clicks on a TextField.
        // There is a "Done" button on the right that the user can click to submit the text in the TextField,
        // dismiss the keyboard, and remove focus from the TextField. The view will then update according to
        // the new TextField values.
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                    // This variable is also set to false so that if the tipPercentage TextField was
                    // showing, it will be dismissed
                    isEditingTipPercentage = false
                }
            }
        }
        // This tells the ScrollView to adjust for the keyboard so that
        // content isn't pushed into the status bar and other iPhone UI elements
        .ignoresSafeArea(.keyboard)
    }
    
    // This function defines the initial text presented to the user to share when pressing the ShareLink button
    // at the bottom for a certain app. The user is sometimes then able to edit the text, such as in iMessage
    // before sending the text. I use the effectiveTipPercentage rather than the selected tipPercentage in order
    // to avoid inaccuracies if someone is splitting with others
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
