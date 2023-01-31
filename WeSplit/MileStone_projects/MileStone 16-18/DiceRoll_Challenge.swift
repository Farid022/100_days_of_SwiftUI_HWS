
//The DiceRoll project is in SwiftUI folder. It is to save data to coreData.
//Challenge is:
/*
 Your challenge this time can be easy or hard depending on how far you want to take it, but at its core the project is simple: you need to build an app that helps users roll dice then store the results they had.

 At the very least you should lets users roll dice, and also let them see results from previous rolls. However, if you want to push yourself further you can try one or more of the following:

 Let the user customize the dice that are rolled: how many of them, and what type: 4-sided, 6-sided, 8-sided, 10-sided, 12-sided, 20-sided, and even 100-sided.
 Show the total rolled on the dice.
 Store the results using JSON or Core Data – anywhere they are persistent.
 Add haptic feedback when dice are rolled.
 For a real challenge, make the value rolled by the dice flick through various possible values before settling on the final figure.
 When I say “roll dice” you don’t need to create fancy 3D effects – just showing the numbers that were “rolled” is fine.

 The only thing that might cause you some work is step 5: making the results flick through various values before settling on the final figure. The easiest way to tackle this is through a Timer that gets cancelled after a certain number of calls.

 While you’re working, please take a moment to remember the accessibility of your code – try using it with VoiceOver and make sure it works as well as you can make it.
 */

//All in one. First create two entities -> CoreData. CoreDataRoll and Result with relationship.
//1. CoreDataRoll
/*
 import Foundation
 import CoreData


 extension CoreDataRoll {

     @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRoll> {
         return NSFetchRequest<CoreDataRoll>(entityName: "CoreDataRoll")
     }

     @NSManaged public var totalSum: Int16
     @NSManaged public var numofSides: Int16
     @NSManaged public var id: UUID?
     @NSManaged public var date: Date?
     @NSManaged public var mainResult: Result?
     
     var wrappedNumberOfSides: Int {
             Int(numofSides)
         }
         
         var wrappedTotalSum: Int {
             Int(totalSum)
         }
         
         var wrappedId: UUID {
             id ?? UUID()
         }
         
         var wrappedDate: Date {
             date ?? Date()
         }

 }

 extension CoreDataRoll : Identifiable {

 }

 */
//2. Result.
/*
 import Foundation
 import CoreData


 extension Result {

     @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
         return NSFetchRequest<Result>(entityName: "Result")
     }

     @NSManaged public var totalResult: Int16
     @NSManaged public var numOfDice: Int16
     @NSManaged public var date: Date?
     @NSManaged public var id: UUID?
     @NSManaged public var dice: NSSet?
     
     var wrappedDate: String {
         let formatter = DateFormatter()
         formatter.dateFormat = "MMMM dd, yyyy"

         if let wrapDate = date {
             return formatter.string(from: wrapDate)
         } else {
             return formatter.string(from: Date())
         }
     }

     var wrappedTime: String {
         let formatter = DateFormatter()

         formatter.dateFormat = "h:mm a"
         if let wrapDate = date {
             return formatter.string(from: wrapDate)
         } else {
             return formatter.string(from: Date())
         }
     }

     var wrappedTotalResult: Int {
         Int(totalResult)
     }

     var wrappedNumberOfDice: Int {
         Int(numOfDice)
     }

     var wrappedId: UUID {
         id ?? UUID()
     }

     var diceArray: [CoreDataRoll] {
         let set = dice as? Set<CoreDataRoll> ?? []
         let array = set.sorted { $0.wrappedTotalSum > $1.wrappedTotalSum }

         return array

     }


 }

 // MARK: Generated accessors for dice
 extension Result {

     @objc(addDiceObject:)
     @NSManaged public func addToDice(_ value: CoreDataRoll)

     @objc(removeDiceObject:)
     @NSManaged public func removeFromDice(_ value: CoreDataRoll)

     @objc(addDice:)
     @NSManaged public func addToDice(_ values: NSSet)

     @objc(removeDice:)
     @NSManaged public func removeFromDice(_ values: NSSet)

 }

 extension Result : Identifiable {

 }
 */
import Foundation
import SwiftUI
import CoreData
/*
 
 //main
 import SwiftUI

 @main
 struct DiceRollApp: App {
     @StateObject var dataConroller = DataController()
     var body: some Scene {
         WindowGroup {
             HomeView()
                 .environment(\.managedObjectContext, dataConroller.container.viewContext)
         }
     }
 }
 
 
 
 //HomeView.
 struct HomeView: View {
     var body: some View {
    
         //  tab view where the first tab lets users roll dice, and the second tab shows results from previous rolls.
         TabView {
             PlayView()
                 .tabItem {
                     Image(systemName: "gamecontroller.fill")
                     Text("Play")
                 }
                 .tag("roll")

             HistoryView()
                 .tabItem {
                     Image(systemName: "clock.fill")
                     Text("History")
                 }
                 .tag("history")
         }
     }
 }
 
 
 
 
 //Play View
 struct PlayView: View {
     
     //background color for the picker.
     init() {
         UISegmentedControl.appearance().selectedSegmentTintColor = .blue
         UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
         UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
     }
     
     // color array for dice
     private let colors = [Color.red, Color.blue, Color.green, Color.purple, Color.pink]
     
     
     // MARK: HAPTICS
     
     var haptics = Haptics()
     
     // Let the user customize the dice that are rolled: how many of them, and what type: 4-sided, 6-sided, 8-sided, 10-sided, 12-sided, 20-sided, and even 100-sided.
     
     @Environment(\.managedObjectContext) var moc

     // MARK: - Private properties
     
     @State private var diceOne: Int = 0
     @State private var diceTwo: Int = 0
     @State private var diceThree: Int = 0
     
     //vars for Dice picker.
     @State private var diceSelection = 0
     private let numberOfDice = ["1","2","3"]
     private let diceMaxValue = [1,2,3]
     
     //vars for Sides picker.
     @State private var sideSelection = 0
     private let numberOfSides = ["4","6","8","10","12","20","100"]
     private let sidesMaxValue = [4,6,8,10,12,20,100]
     
     // rotation Amount
     @State private var rotateAnimationAmount = Double(Int.random(in: -8...8))
     
     // CONSTANTS
     private var fontResultSize = 35
     private var widthValue: CGFloat = 250
     private var opacityValue = 0.8
     private var cornerRadiusValue: CGFloat = 10
     
     
     
     func selectDie(at number: Int) -> Int {
         switch number {
         case 1:
             return diceOne
         case 2:
             return diceTwo
         case 3:
             return diceThree
         default:
             return diceOne
         }
     }
     
     func countTotal(at number: Int) -> Int16 {
         switch number {
         case 1:
             return Int16(diceOne)
         case 2:
             return Int16(diceOne + diceTwo)
         case 3:
             return Int16(diceOne + diceTwo + diceThree)
         default:
             return Int16(0)
             
         }
     }
     
     func saveData() {
         // save the results
         let newResult = Result(context: self.moc)
         newResult.id = UUID()
         newResult.date = Date()
         newResult.totalResult = countTotal(at: self.diceMaxValue[diceSelection])
         
         // go through each of the die and save them to the newResult
         for i in 1...self.diceMaxValue[diceSelection] {
             
             // create new die
             let newDie = CoreDataRoll(context: self.moc)
             
             // date
             newDie.date = Date()
             
             // ID
             newDie.id = UUID()
             
             // number on die
             newDie.totalSum = Int16(selectDie(at: i))
             
             // number of sides
             newDie.numofSides = Int16(sidesMaxValue[sideSelection])
             
             newResult.addToDice(newDie)
             
         }
         newResult.numOfDice = Int16(diceMaxValue[diceSelection])
         
         // haptic success activated
         haptics.complexSuccess()
         
         do {
             try self.moc.save()
         } catch {
             print("Error with save to Core Data")
         }

     }
     
     
     
     var body: some View {
         
         NavigationView {
             GeometryReader { proxy in
                 VStack {
                     //Dices Picker.
                     HStack {
                         Text("Dice").font(.caption)
                         Spacer()
                         Picker(selection: self.$diceSelection, label: Text("Number of Dice")) {
                             ForEach(0..<self.numberOfDice.count) {
                                 Text("\(self.numberOfDice[$0])")
                             }
                         }
                         .pickerStyle(SegmentedPickerStyle())
                         .frame(maxWidth: proxy.size.width * 0.8)
                         
                         // accessibility
                         .accessibility(label: Text("select the number of dice"))
                         
                         
                     }
                     .padding()
                     
                     //Sides Picker.
                     HStack {
                         Text("Sides").font(.caption)
                         Spacer()
                         Picker(selection: self.$sideSelection, label: Text("Number of Sides")) {
                             ForEach(0..<self.numberOfSides.count) {
                                 Text("\(self.numberOfSides[$0])")
                             }
                         }
                         .pickerStyle(SegmentedPickerStyle())
                         .frame(maxWidth: proxy.size.width * 0.8)
                         
                         // accessibility
                         .accessibility(label: Text("select the number of sides ond ice"))
                     }
                     .padding()
                     
                     //show number of Dices.
                     HStack {
                         // The .id(: \.self) part is required so that SwiftUI can identify each element in the array uniquely
                         ForEach((1...self.diceMaxValue[diceSelection]), id: \.self) { number in
                             DieView(die: selectDie(at: number), width: 100, height: 100, cornerRadius: 25, backgroundColor: colors.randomElement() ?? Color.primary)
                         }
                         // animation
                         .animation(.easeInOut)
                     }
                
                     Spacer()
                     //No of Dices = 2.
                     Text("You rolled a \(self.countTotal(at: self.diceMaxValue[diceSelection]))")
                         .font(Font.system(size: CGFloat(fontResultSize), weight: .heavy, design: .default))
                     
                         Spacer()
             
                     
                     Button(action: {
                         
                         for i in 1...10 {
                             DispatchQueue.main.asyncAfter(deadline: .now()+(0.3 / Double(i))) {
                                 
                                 diceOne = Int.random(in: 1...sidesMaxValue[sideSelection])
                                 
                                 diceTwo = Int.random(in: 1...sidesMaxValue[sideSelection])
                                 
                                 diceThree = Int.random(in: 1...sidesMaxValue[sideSelection])
                                 
                                 print(diceOne, diceTwo, diceThree)
                                 
                                 // prepare haptics
                                 haptics.prepare()
                             }
                         }
                         
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.31) {
                             print("Saving...")
                             print(self.diceOne, self.diceTwo, self.diceThree)
                             
                             // save the data
                           saveData()
                         }
                         
                     }) {
                         Text("Roll")
                     }
                     .accentColor(Color.white)
                     .frame(minWidth: widthValue, maxWidth: widthValue)
                     .padding()
                     .background(Color.blue.opacity(opacityValue))
                     .cornerRadius(cornerRadiusValue)
                     .padding()
                     .font(.headline)
                     
                 } // VStack
             } // GeometryReader
             
             .navigationBarTitle((Text("Dice Roll")))
         } // NavigationView
         
      
         .navigationViewStyle(StackNavigationViewStyle())
     } // Body
 }
 
 
 
 
 //DiceView
 struct DiceView: View {
     
     var die: Int
     var width: CGFloat
     var height: CGFloat
     var cornerRadius: CGFloat
     var backgroundColor: Color
     

     var body: some View {
         Text("\(die)")
             .frame(width: self.width, height: self.height)
             .background(backgroundColor)
             .foregroundColor(.white)
             .cornerRadius(cornerRadius)
             .overlay(
                 RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.black, lineWidth: 2))
             .font(backgroundColor == Color.yellow ? . title : .headline)
             .accessibility(label: Text("\(die)"))
     }
 }
 
 
 
 //History View
 struct HistoryView: View {
     
     
     @Environment(\.managedObjectContext) var moc
     
     @FetchRequest(entity: Result.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Result.totalResult, ascending: false)]) var results: FetchedResults<Result>
     
     @FetchRequest(entity: CoreDataRoll.entity(), sortDescriptors: []) var dices: FetchedResults<Result>
     
     //  Use onDelete(perform:) modifier to ForEach, but rather than just removing items from an array we instead need to find the requested object in our fetch request then use it to call delete() on our managed object context.
     func deleteRolls(at offsets: IndexSet) {
         for offset in offsets {
             // find the roll in fetch request
             let result = results[offset]
         
                 // delete it from the context
                 moc.delete(result)
                 
                 // save!
                 do {
                     try moc.save()
                 } catch {
                     print("error with save after delete")
                 }
    
             
         }
     }
     
     
     func findDiceIndex(at result: Result) -> Int {
         guard let index = results.firstIndex(of: result) else { return 0 }
         return index
     }
     
     @State private var countOfDie = 1
     
     var body: some View {
         NavigationView {
             VStack {
                 List {
                     ForEach(results, id: \.wrappedId)  { result in
                         HStack {
                             HStack {
                                 ForEach(result.diceArray, id: \.totalSum) { newDie in
                                     DieView(die: newDie.wrappedTotalSum, width: 54, height: 54, cornerRadius: 4, backgroundColor: .green)
                                 }
                             }
                             Spacer()
                             
                             VStack(alignment: .leading) {
                                 Text("Results: \(result.wrappedTotalResult)")
                                     .font(Font.system(size: CGFloat(16), weight: .heavy, design: .default))
                                     .foregroundColor(Color.red)
                                 
                                 Text("Date: \(result.wrappedDate)")
                                     .font(Font.system(size: CGFloat(16), weight: .heavy, design: .default))
                                     .foregroundColor(Color.purple)
                                 
                                 Text("Time: \(result.wrappedTime)")
                                     .font(Font.system(size: CGFloat(16), weight: .heavy, design: .default))
                                     .foregroundColor(Color.primary)
                             }
                             
                         }
                         
                     }
                     .onDelete(perform: deleteRolls)
                     
                 }
                 
             }
             
             .navigationBarTitle(Text("Die Roll Results"))
             .navigationBarItems(trailing: EditButton())
             
         }
         .navigationViewStyle(StackNavigationViewStyle())
         
     }
     
 }
 
 
 
 //Haptics view
 import CoreHaptics

 struct Haptics: View {
     // MARK: HAPTICS
     
     // instance of haptics engine
     @State private var engine: CHHapticEngine?
     
     // prepare the haptics
     func prepare() {
         guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
         
         do {
             self.engine = try CHHapticEngine()
             try engine?.start()
         } catch {
             print("There was an error creating the engine: \(error.localizedDescription)")
         }
     }
     
     func complexSuccess() {
         // make sure that the device supports haptics
         guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
         var events = [CHHapticEvent]()

         // create one intense, sharp tap
         let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
         let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
         let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
         events.append(event)

         // convert those events into a pattern and play it immediately
         do {
             let pattern = try CHHapticPattern(events: events, parameters: [])
             let player = try engine?.makePlayer(with: pattern)
             try player?.start(atTime: 0)
         } catch {
             print("Failed to play pattern: \(error.localizedDescription).")
         }
     }
     var body: some View {
         Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
     }
 }
 
 
 //Datacontroller for NSobjectdescription.
 import Foundation
 import CoreData

 class DataController: ObservableObject {
     let container = NSPersistentContainer(name: "DiceRoll")
     init() {
         container.loadPersistentStores { description, error in
             if let error = error {
                 print("Error loading data \(error.localizedDescription)")
             }
         }
     }
 }

 */

