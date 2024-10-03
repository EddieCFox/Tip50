# Tip 50

## Video Demo

A brief overview of the application can be found here: https://youtu.be/zO7_q-0JpNc

I spoke a little quickly as I was trying to get the video under 3 minutes.

If you are a CS50 staff member who is auditing this final project and needs to see the overview of the files in the project, click [this](#files-overview) to skip to the files overview section.

## Project Idea

The project is fairly simple in scope: A tip calculator in iOS for iPhone, written with Swift and SwiftUI.

I decided on this application for a few reasons. There are always new technologies and skills to learn in this field. As someone who is arguably a software engineer as a profession, "learning how to learn" is one of the most important skills.

I have no prior experience with Swift, so I decided to write this app in order to learn the basics of Swift, which is used for everything in the Apple ecosystem.

I was a little pressed for time because I only had two weeks to finish the final project before a long vacation, and I was worried that if I was not done with the final project by then, I would have forgotten a lot of the Swift knowledge I learned and would need to finish the project.

A tip calculator is a project where it is very easy to implement a MVP (Minimum Viable Product), but there are also lots of refinements and features that can be added. In this way, I knew that I would at least have a project that I could turn in, and I could add features progressively with whatever time I had remaining.

## Learning Swift

There are a lot of resources for learning Swift, but I wanted something that could teach me the basics without being a course that goes too in-depth, as I am not trying to become an Apple Developer at this time.

I considered watching the Apple WWDC videos, and they had lots of beautiful graphics and intelligent developers teaching, but the course wasn't focused enough and too short to teach me everything I needed to know.

I saw a Swift UI fundamentals course from Sean Allen that seems to have lots of information, but it was too long at 12 hours.

I saw lots of people recommend the [Swiftful Thinking](https://www.youtube.com/@SwiftfulThinking/featured) YouTube channel. I watched his entire Swift Basics (Beginner Level) playlist in order to gain structured knowledge on the Swift programming language in general, not just learning SwiftUI.

[Swift Basics playlist here](https://www.youtube.com/watch?v=PwXgg9adkdM&list=PLwvDm4VfkdpiLvzZFJI6rVIBtdolrJBVB&pp=iAQB)

I also decided to learn SwiftUI from the Swiftful Thinking Youtube channel. Lots of people have videos where they build apps with SwiftUI, but I wanted something structured that taught the fundamentals of SwiftUI with one topic per video.

[SwiftUI BootCamp (Beginner Level) Playlist](https://www.youtube.com/playlist?list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO)

I did not watch all of the videos on this Playlist, as it was significantly longer. I did not have enough time to watch everything, nor did I need everything in the bootcamp.

I watched the following:

**Watched:**

Bootcamp 1-12 watched

#18 – How to add Buttons to SwiftUI applications

#19 - How to use @State property wrapper in SwiftUI

#23 – How to use if-else and conditional statements in SwiftUI

#35 – How to use TextField in SwiftUI

#37 - How to use a Toggle to create a Switch in SwiftUI

#38 - Picker and PickerStyles in SwiftUI

#41 - Create a Stepper in SwiftUI

#42 – How to use Slider in SwiftUI

#50 - How to use @ObservableObject and @StateObject in SwiftUI

#56 - How to select text with TextSelection in SwiftUI

#68 – How to use menu in SwiftUI

**Skimmed:**

#20 - Extracting functions and subviews in SwiftUI – Delete

#21 – Extracting subviews in SwiftUI

#22 - How to use @Binding property wrapper in SwiftUI

#44 – For Dark mode

#48 – How to add a tap gesture in SwiftUI

#60 - How to use @FocusState in SwiftUI (For autofocus)

#63 – How to use Toolbar in SwiftUI

**Already covered by Swift Basics Bootcamp:**

#48 – How to safely unwrap optionals in Swift with if-let and guard

#49 – How to create custom models in SwiftUI


## Project Design

Before doing anything (even before learning Swift), I made a design document in order to describe what the MVP would look like and what additional features I would add with remaining time, in what order.

As I learned Swift, I edited the document as I realized ways that I could implement the MVP + features.

I had 20 hours left to work on actually coding and testing the final project after learning Swift.

Here is the final document (originally in word) translated to Markdown format

### Phase 1: Design (MVP)

Bill Total: Text field for user to type the bill total.

Variable: `billTotal`

Tip: Defaults to 0. Updates dynamically according to changes in bill total and percentage. User should not be able to type in it. Variable: `tip`

Total: Equal to the result of the Bill Total + Tip. User should not be able to type here. Variable: `total`

Tip percentage: Text field for user to type the percentage of tip. Variable: `tipPercentage`

Plain white background with black text. No special formatting. Probably in a VStack. I will just use a spacer after everything to push everything to the top of the screen, giving me room to add additional features later. The percentage should be in a somewhat separated section from the bill total, tip, and total.

The most difficult part will be to figure out how to update the tip and total variables in real time according to changes in the bill total and percentage, but that is at the core of a tip calculator. The user shouldn’t have to hit a calculate button to see a calculated result. I might opt for that approach if it is too challenging to do realtime updates, but it shouldn’t be based on what I have seen.

At the very minimum, I need to complete this phase before I can turn in the final project, but I would be a bit ashamed if this is all I could finish in 20 hours.

### Phase 2: Additional Features

Features in this phase should be added according to the below priority order. Keep going until all features are added, or stop this phase when only 3 hours are left for development.

1.	Instead of a text field where the user can input a tip percentage, turn it into a slider that defaults to 20% and can go up and down in realtime. The tip and total should still update in realtime according to changes in the tip percentage.
    * If possible, I want the minimum tip percentage on the slider to be 0% and the maximum to be 40%.
2.	Add a selection of common tip percentages below the total but above the slider with common tip percentages. Clicking any of them should update the value on the slider. I am thinking of 10, 15, 18, 20, and 25%. This can probably be done with a segmented picker.
    * This would be in the percentage section.
3.	Create a new vertical section below the percentage for calculating split bills
    * The first version can use a stepper that defaults at 1 people and can go up and down. It shouldn’t be able to drop below 1.
    * The total should dynamically adjust based on changes to the split. Variable name: `peopleSplitting` (name pending). The tip shouldn’t change based on the number of people splitting it.
4.	Second version of split: Add a section that shows the individual tip that each person in the split will need to pay. Variable: `splitTip`.
    * Should update dynamically based on the changes to the number of people splitting.
5.	Third version of split: A segmented picker with 1, 2, 3, 4, 5, 6, and other options, where upon clicking other, a text field opens up for the user to manually type the number of people who are splitting the bill.
    * I am not sure how hard this is to do technically, but I saw the iTip app use this approach.
6.	Add a green “Round to the nearest dollar” toggle button that can be flipped on and off. This rounds the total to the nearest dollar. Variable name: `roundToNearest`. Type: `Boolean`.
    * Originally, I wanted to round at the split tip level but this would lead to changing the logic. Instead of the split tip being calculated as the tip divided by the number of people, it would be reversed and the tip would be calculated as the rounded split tip multiplied by the number of people. I didn’t want that.
    * In my re-design, I was considering applying the rounding at the total tip level and rounding the total tip to the nearest dollar, then recalculate the total and split tip accordingly. This would be the easiest to implement, but users might expect the grand total to be rounded to the nearest dollar rather than the tip.
        * If total is 10.57 and tip is 4.33, I would expect “Round to the nearest dollar” to bring the total to 11.00 and the tip to 4.76, not the total to 10.24 and the tip to 4.00.
    * To implement this final design, we can calculate a `roundedTotal` that is equal to the round(total) [whatever the Swift function for this is] and then subtract the total to find the difference. We then add this to the tip.
    * To avoid issues with small tips getting rounded to zero, we will say that the minimum tip is 1% or whatever percentage the user input, if the percentage was less than that.
7.	Re-add the ability for user to type in the tip percentage, if possible, by clicking the number and typing in a value using the same text field ideas as before.
8.	Refactor the text fields so that there is a “Done” button that the user can click to dismiss the numberpad keyboard.
9.	Add the ability for the user to share the tips information to other apps (most likely to message people about the bill)
    * Bill amount, tip percentage, tip, grand total, total per person, tip per person
10.	Adjust the tip percentages when rounding to show the actual tip percentage

### Phase 3: Appearance + Finishing Touches

Begin this phase when only 3 hours remain.

1.	Add colors, shadows, rounded corners, font styling
2.	Further optimize spacing and padding
3.	If time, adapt the app for dark mode so the text is still readable with whatever colors are used during dark mode
4.	Add app icon
5.	Add launch screen while the app is loading

## Challenges

In this section, I describe what was unexpected during the development of the app. Challenges that I had to overcome.

### Rounding

Originally, I calculated the total as the bill amount + tip. I calculated the tip as `billAmount * tipPercentage`.

This worked fine for regular scenarios, but when adding rounding the total to the nearest dollar, this arrangement fell apart.

I realized that we have to calculate the tip based on the total.

If I calculated tip as `billAmount * tipPercentage`, this would not work well with rounding where we need to round the total to the nearest dollar. The only way to do that would be to increase the `tip`, because we can't change the `billAmount`. If we define the total as `billAmount + tip`, then the `total` depends on the `tip`, and in the case of rounding, the `tip` depends on the `total`, creating a circular dependency where both variables depend on each other. To break this circular dependency, I made the `total` the "source of truth" from which the `tip` is calculated from.

### Edge Cases

As is common, edge cases such as small overall bills or zero bills can cause issues.

When the bill is small, rounding can cause issues with the `tip`. For example, imagine the final bill is 40 cents. With 20% `tip` selected, the `tip` would be 8 cents for a `total` of 48 cents. If we selected rounding here and it rounded to the nearest dollar, it would round to a grand `total` of $0.00, with a suggested `tip` of negative 40 cents (-$0.40).

Besides the negative `tip`, another obvious issue is that the `total` was rounded to a value below the overall `billAmount`.

I decided that I wanted to ensure that at least 1% of the bill was tipped by the calculator. Instead of having just a `total` variable, I decided to have `unroundedTotal` and `roundedTotal` variables. If rounding was not selected, I would return the `unroundedTotal`.

If rounding was selected, I would return the `billAmount` + the minimum tip if the `roundedTotal - the billAmount` was less than the minimum tip.

This is expressed as:

```swift
            if (roundedTotal - billAmount < minTip) {
                return billAmount + minTip
            }
```

If there is no edge case behavior with the `tip` after rounding, we can simply return the `roundedTotal`.

Overall, this ensures that the `total` is never rounded below the bill 

I later also realized that the bill is small enough (less than a dollar), 1% of the tip would be less than a cent. Instead of having a `minTip` of 1% of the `billAmount`, I set it to be a maximum of that and one cent, so the `minTip` would be at least one cent.

Finally, this would lead to the tip being calculated as 1 cent even if the bill was zero, which doesn't make sense. Why would you tip if you were never charged? So I had to handle the case of the `billAmount` being zero specifically so that in those cases, the `tip` would be zero cents.

### Keyboard

It was simple enough to add `.keyboardType(.decimalPad)` to the `TextField`s so that when a user clicks a `TextField`, a numerpad keyboard is brought up where they can only type numbers and decimals.

The issue however is that the `decimalPad` does not come with a `Done` button by default which can be used to dismiss the keyboard. This meant that once the user clicked a `TextField` to type in a value, they would never be able to get rid of the keyboard.

This didn't show up in initial testing because in the `XCode` preview, you just use the Macbook keyboard to type in the fields, but while using my actual phone as a run environment, I discovered the issue.

As a result, I had to research how to do this, and add lots of things to the code that I never originally planned for, such as:

1. A custom `Field` type enum that held every possible `TextField` that might be focused (as well as possibly having a value of `nil`, which is like `NULL` from C.)
2. A `FocusState` variable to programatically control `TextField` focus
3. A `toolbar` with a `Done` button to dismiss the keyboard and cancel the current `TextField` focus.

Even after doing this, I had the issue where the keyboard would push some of the text up into the very top of the iPhone, where it overlapped with where things like the dynamic island, time, Wifi, cellular bars, and battery are.

To fix this, I had to wrap the entire body in a `ScrollView` and then add a `.ignoresSafeArea(.keyboard)` so that users would be able to scroll while the keyboard was up, and it wouldn't push the content up.

### Launch Screen

I watched several tutorials on how to do Launch Screens. This is the screen that shows up while an application is still loading, and usually has things like a logo and title.

Unlike all other components that are designed in SwiftUI, the launch screens use Storyboard instead. 

I was able to learn enough of this to make a basic launch screen which can be seen [here](https://i.imgur.com/9esrHlw.png).

Despite following the tutorials exactly, I had some technical issues where Xcode would not persist my selection of the launch screen, so the app wasn't able to actually use the launch screen.

This was the last feature I was trying to implement before beautifying the application. As I was running into time limits / deadlines, like a real engineer, I had to evaluate whether this feature was necessary to implement, or if it was just a "nice to have".

I ultimately decided to not include this feature because the Tip50 app is relatively simple. It does not call any external APIs, databases, etc. On my iPhone 15 Pro Max, it loads nearly instantly. So fast, that no one would be able to read the launch screen unless they were on an old iPhone. So the feature had minimal benefits, but trying for an indefinite amount of time to solve the technical issue would lead to me not having enough time to optimize the appearance of the app, which has much more tangible benefits.

## Files Overview

The file structure for my app is pretty simple.

Almost everything lives within the `Tip50` directory that Xcode automatically created when I started the project.

### Within Tip50 folder

#### Assets.xcassets

This folder contains all of the image and color assets used in the app. In this case, the app icon and accent colors.

##### AccentColor.colorset

This file is automatically created by Xcode and defines a color set for the app’s accent color.

##### AppIcon.appiconset
Stores the app icon. I used a 512x512 app icon that I saw on Google due to difficulties in creating my own original art (I am not an artist). Since I only plan to use the app personally and not put it on the app store, this should be acceptable. I used an AI upscaler to make it 1024x1024 as required by Xcode.

##### Contents.json
A metadata file that organizes the assets within the Assets.xcassets folder.

#### PreviewContent

This directory contains auto generated files used to preview the application during development.

#### ContentView.swift

This is where almost all the code for my application is written. I only needed one view because my app only has one screen, and does not have any other views. This includes the UI specifciation, layout, and internal calculation logic.

The code itself is fully commented, so please look at that file for further details.

#### Tip50App.swift

The entry point of the application. This follows the SwiftUI `App` protocol and defines the main scene of the application. It basically launches the `ContentView`.

### Tip50.xcodeproj

Automatically generated and updated files that track the various settings and configurations for my project. I did not need to update this manually.

At the top of the file browser in Xcode, there is an app store sort of icon with the name of the `Tip50` project that when double clicked, brings up a graphical interface that can be used to update the project settings. Files within this `Tip50.xcodeproj` directory are then updated automatically.