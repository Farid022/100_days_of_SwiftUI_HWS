////
////  HWS_playGround_100days.swift
////  WeSplit
////
////  Created by Muhammad Farid Ullah on 03/12/2022.
////
//
import Foundation
import UIKit
import SwiftUI
//
////Day3
////Arrays
//let myarr = ["name1", "name2"]
//var arr2: [String] = []
//var arr3 = Array<String>()
//var arr4 = [String]()
//var arr5 = ["z", "h", "e", "a"]
//arr2.append("farid")
//arr3.append("Khan")
//arr4.append("Amandi")
////print(myarr[0])
////print(arr2[0])
////print(arr3[0])
////print(arr4[0])
////print(arr4.count)
//arr2.count
//arr4.append("Amandi")
//arr4.removeAll()
//arr3.remove(at: 0)
//arr2.contains("farid")// returns true or false
//arr5.sorted()
//arr5.reversed()
////print(arr5)
////print(arr5.sorted())
////print(arr5.reversed())
////print(arr2.contains("farid")) //true
////print(arr4[0])
////print(arr3[0])
//
//
////Dictionaries Dictionaries don’t store items according to their position like arrays do, but instead let us decide where items should be stored. the left= key,  right= value
//var mydic1 = [
//    "name": "Farid",
//    "job": "iOS dev",
//    "Loc": "Amandi",
//    "Religion": "Islam"
//]
//let hasGraduated = [
//    "Eric": false,
//    "Maeve": true,
//    "Otis": false,
//]
//let olympics = [
//    2012: "London",
//    2016: "Rio de Janeiro",
//    2021: "Tokyo"
//]
//var mydic2 = [String: Int]()
//mydic2["name"] = 2
//mydic2["loc"] = 3
//mydic2["address"] = 4
//mydic2.count
//mydic2.removeAll()
//mydic2.reversed()
////all available with dict like arrays
////print(mydic1["name", default: "unknown"])
////print(mydic1["loc", default: "unknown"]) //does not match then Unknown
////print(hasGraduated["Eric", default: true])
////print(olympics[2012, default: "Unknown"])
////print(mydic2["name", default: 00])
//
//
////Set. similar to array but don't store dublicate values like array. sets make good ordering of the items. Does not have index.
//var myset = Set(["Khan", "Jemmy", "SoOn"])
//var myset22 = ("khann", 4, "djd", 4.3)
////print(myset22.0)
////print(myset)
//var myset2 = Set<String>()
//myset2.insert("newItem")
//myset2.insert("secItem")
//myset2.insert("Apple")
////print(myset2)
//myset2.contains("newItem")
//myset.removeAll()
////print(myset2)
//myset2.sorted()
//
//
//
////enum: The action of mentioning a number of things one by one
//enum Months {
//    case jan, fab, mar, ap
//}
////func months(month: Months){
////    switch month {
////    case .fab:
////        //print("It is fab")
////        fallthrough // By default Swift will stop executing code in a switch block once it reaches the end of a case that was matched but fallthrough make it goooo
////    case .ap:
////        //print("It is ap")
////
////    case .jan:
////        //print("It jan")
////
////    case .mar:
////        //print("It is mar")
////
////    default:
////        //print("Hello Nothing")
////    }
////}
////months(month: .fab)
////var mont = Months.fab
////mont = .fab
////mont = .jan
//
//
////Type Annotation
//var clues = [String]() // instead of
//var cities: [String] = []
//var myset21 = Set<String>()
//
////Quiz: Array of string, print No of items and no of unique items
//let myrrr = Set(["jemmy", "khan", "khan"])
////print(myrrr.count)
//
//
////Conditions, if, logical oprators, switch, if-else, ternary opr
//enum Themes {
//    case dark,light
//}
//var theme = Themes.light
//var background = theme == .dark ? "Dark Theme": "Light Theme"
////print(background)
//
//
////Loops
////we do not know in advance how many times the loop will run
//var roll = 0
//while roll != 20 {
//    roll = Int.random(in: 1...20)
//    //print("I rolled \(roll)")
//}
////print("Critical Hit")
//
////continue and break statements
//let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]
//for filename in filenames {
//    if filename.hasSuffix(".jpg") == false {
//        // continue // it only skip the current matched loop and run the rest of the loop
//        break  // exits a loop immediately and skips all remaining iterations
//    }
//
//    print("Picture found \(filename)")
//}
//
//
//let number1 = 4
//let number2 = 14
//var multiples = [Int]()
//for i in 1...100_000 {
//    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
//        multiples.append(i)
//
//        if multiples.count == 10 {
//            break
//        }
//    }
//}
////print(multiples)
//
//
//
////Functions.
//func multiplyingg(num: Int) {
//    for i in 1...10 {
//        //print("Multiple is: \(i * num)")
//    }
//}
//multiplyingg(num: 3)
//
//func diceRoll() -> Int {
//    return Int.random(in: 1...10)
//}
////print(diceRoll())
////return from func
//func getTry(str1: String, str2: String) -> Bool {
//    return str1.sorted() == str2.sorted()  //no need to write 'return' keyword when there is one line of code in return.
////    if str1 == str2{
////        return true
////    }else{
////        return false
////    }
//}
//let res = getTry(str1: "abce ", str2: "abc")
//print(res)
////return multiple from func
//func getValues() -> [String: String] {//return a dictionary
//    return ["fname": "Mehmood Khan", "name": "Farid"]
//}
//let user = getValues()
////print("fname: \(user["fname", default: "nothing"])")
//
//func getUser() -> (fname: String, name: String){
//    //return (fname: "Mehmood", name: "Farid")
//    ("Mehmood", "Farid")
//}
//let user1 = getUser()
////print("fname: \(user1.fname) and Name: \(user1.name)")
//let (fname, _) = getUser() //  '_' means to skip this tuple
////print("fname: \(fname)")
//
//func rollDice(sides: Int, count: Int) -> [Int] {
//    var rolls = [Int]()
//
//    for _ in 1...count  {
//        let roll = Int.random(in: 1...sides)
//        rolls.append(roll)
//    }
//
//    return rolls
//}
//let rollss = rollDice(sides: 6, count: 3)
//print(rollss)
//let lyric = "I see a red door and I want it painted black"
//print(lyric.hasPrefix("I see"))
////we can use _ for the external parameter name so that it doesn’t get used, or add a second name there so that we have both external and internal parameter names.  values you pass in to a function are called “arguments”, and values you receive inside the function are called parameters.   We write for number: Int: the external name is for, the internal name is number, and it’s of type Int. When we call the function we use the external name for the parameter: printTimesTables(for: 5).
//
////Function throws error
//enum PassErrors: Error {
//    case short, abivous
//}
//func checkPassword(_ password: String) throws -> String {
//    if password.count < 5 {
//        throw PassErrors.short
//    }
//    if password == "abcdef" {
//        throw PassErrors.abivous
//    }
//
//    if password.count < 8 {
//        return "Okay"
//    } else {
//        return "Good"
//    }
//}
//let str = "abcdef"
//do {
//    let result = try checkPassword(str)
//    print("The result is: \(result)")
//}
////catch PassErrors.short{
////    print("It short")
////}
////catch PassErrors.abivous {
////    print("It is abvious")
////}
//catch let error {
//    //print("Error boommed \(error.localizedDescription)")
//}
////let result = try checkPassword(str) //use the '!' if you are sure that the func does not throw an error, but if it throw then Fettal error
////print("The result is: \(result)")
//
////CheckPoint 4
//enum FindSqr: Error {
//    case bound, range, notFound
//}
//func findSqroot(_ num: Int) throws -> Int {
//    var resso = 0
//    for _ in 1...100 {
//        if num*num == 10_000 {
//            throw FindSqr.bound
//            break
//        }
//        if num*num == 1{
//            throw FindSqr.range
//            break
//        }
//        if num > 100{
//            throw FindSqr.notFound
//        }
//
//        else {
//            resso = num*num
//        }
//    }
//    return resso
//}
//let val = 12
//do {
//    let resulltt = try findSqroot(val)
//    //print("The square root is: \(resulltt)")
//}
//catch FindSqr.bound {
//    //print("Error of Bound")
//}
//catch FindSqr.range {
//    //print("Error of range")
//}
//catch FindSqr.notFound {
//    //print("Square root not found")
//}
//
//
//
//
////func closure
//func getUser(for id: Int) -> String {
//    if id == 910 {
//        return " "
//    } else {
//        return "Jemmy"
//    }
//}
//
//let copyUser: (Int) -> String = getUser
//let userdata = copyUser(910)
////print(userdata)
//
//let sayHello = { (name: String) -> String in
//    return "Hi \(name)"
//}
////print(sayHello("Farid") )
//
//
//let team = ["ali", "khan", "captian", "farid", "asad"]
//let sortedTeam = team.sorted()
//print(sortedTeam)
//
//func captionFirst(name1: String, name2: String) -> Bool {
//    if name1 == "captian" {
//        return true
//    }else if name2 == "captian" {
//        return false
//    }
//
//    return name1 < name2
//}
//
////let captianSorted = team.sorted(by: captionFirst)
////print(captianSorted)
//
////let captainFirstSorted = team.sorted(by: { (name1: String, name2: String) -> Bool in
//let captainFirstSorted = team.sorted { name1, name2 in
//    if name1 == "captian" { //if $0 == "catian"
//        return true
//    }else if name2 == "captian" { //if $1 == "catian"
//        return false
//    }
//
//    return name1 < name2   // $0 < $1
//}
////)
//let reverseTeam = team.sorted { $0 > $1 }
////print(captainFirstSorted )
//let aOnly = team.filter { $0.hasPrefix("a") }
//print(aOnly)
////the map() function lets us transform every item in the array using some code of our choosing, and sends back a new array of all the transformed items:
//let transformAll_to_capital = team.map{ $0.uppercased() }
//print(transformAll_to_capital)
//
//
////func as a parameters
//func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
//    print("First func is about to start")
//    first()
//
//    print("second func is about to start")
//    second()
//
//    print("third func is about to start")
//    third()
//}
//doImportantWork {
//    //print("first is done")
//} second: {
//    //print("second is done")
//} third: {
//    //print("third is done")
//}
//
//func makeArrY(size: Int, using generator: () -> Int) -> [Int] {
//    var numbers = [Int]()
//
//    for _ in 0..<size {
//        let newNumber = generator()
//        numbers.append(newNumber)
//    }
//
//    return numbers
//}
//let rolls = makeArrY(size: 22) {
//    Int.random(in: 1...20)
//}
////print(rolls)
//func gererateNumbers()-> Int {
//    return Int.random(in: 1...20)
//}
//let gernnnn = {
//    return Int.random(in: 1...20)
//}// same as above
//let rooolls = makeArrY(size: 10, using: gernnnn)
////print(rooolls)
//
////check point 5
//let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
////print(luckyNumbers)
//var sorted_luckNumbers = luckyNumbers.sorted { $0 > $1 }
////print(sorted_luckNumbers)
//for i in sorted_luckNumbers {
//    if i.isMultiple(of: 2) {
//        //sorted_luckNumbers.remove(i)
//    }
//}
////print(sorted_luckNumbers)
//
//
//
//
//
//
////Swift’s structs let us create our own custom, complex data types, complete with their own variables and their own functions.
//struct Album {
//    let title: String
//    let year: Int
//    let artist: String
//
//    func resultfunc(){
//        //print("Title: \(title), Artist: \(artist) and Year: \(year)")
//    }
//}
//let red = Album(title: "red", year: 2020, artist: "taylor swift")
//print(red.artist)
//
////mutating. 1
//struct Employee {
//    let name: String
//    var vocationRemaining: Int
//
//   mutating func takeVocation(days: Int) {
//        if vocationRemaining > days {
//            vocationRemaining -= days //any functions that only read data are fine as they are, but any that change data belonging to the struct must be marked with a special mutating
//            //print("I am going on vocation")
//            //print("Ramaining vocations are \(vocationRemaining)")
//        }
//    }
//}
//var farid = Employee(name: "Farid", vocationRemaining: 15)
//farid.takeVocation(days: 3)
////print(farid.vocationRemaining)
////mutating. 2
//struct Stapler {
//    var stapleCount: Int
//   mutating func staple() {  //The staple() method modifies a struct's property without being marked mutating.
//        if stapleCount > 0 {
//            stapleCount -= 1
//            //print("It's stapled!")
//        } else {
//            //print("Please refill me.")
//        }
//    }
//}
//
//
////Compute property
//struct Govt_Servant {
//    var name: String
//    var alocated_voc: Int = 14
//    var takeVocation: Int = 0
//
//    //var remaining_Vocation: Int { // it is compute property. It calculate dynamically.
//     //   alocated_voc - takeVocation
//    //}
////    var rmmm = {
////        1 + 2
////    }
//
//    var remaining_Vocation: Int {
//        get{  //read this code
//            alocated_voc - takeVocation
//        }
//
//        set { //then set the code
//            alocated_voc = takeVocation + newValue
//        }
//    }
//}
//var jemmy = Govt_Servant(name: "Jemmy")
//jemmy.takeVocation += 5
////print(jemmy.remaining_Vocation)
////jemmy.takeVocation += 6
////print(jemmy.remaining_Vocation)
//jemmy.remaining_Vocation = 5
////print(jemmy.alocated_voc)
//
////stter take actions when a property changes. it runs when properties change.
//struct App {
//    var score = 0
//}
//var game = App()
//game.score += 3
////print(game.score)
//game.score += 44
////print(game.score)
////same example with didset
//struct Game {
//    var score = 0 {
//        didSet {
//            print("Score is now: \(score)")
//        }
//    }
//}
//var obj_game = Game()
//obj_game.score += 1
//obj_game.score += 2
//
//struct Contact {
//    var contacts = [String]() {
//        willSet {
//            //print("Current value is: \(contacts)")
//            //print("New Value is: \(newValue)")
//        }
//
//        didSet{ // do not try to put a lot of load here.
//            //print("There are now: \(contacts.count)")
//            //print("Old value is: \(oldValue)")
//
//        }
//    }
//}
//var contact_obj = Contact()
//contact_obj.contacts.append("Jemmy")
//contact_obj.contacts.append("Farid")
//contact_obj.contacts.append("Khan")
//
////custom initializer.
//struct Player {
//    var name_prop: String
//    var number_prop: Int
//
//    init(name_param: String, number_param: Int){
//        self.name_prop = name_param
//        self.number_prop = number_param
//    }
//}
//let player = Player(name_param: "Jemmy", number_param: 4)
////print(player)
//
////access conrtoll Private(set) bank Transactions program
//struct BankAccount{
//   private(set) var funds = 0
//
//   mutating func deposit(amount: Int) {
//        funds += amount
//    }
//
//   mutating func withdraw(amount: Int) -> Bool {
//        if funds >= amount {
//            funds -= amount
//            return true
//        }else {
//            return false
//        }
//    }
//}
//
//var account = BankAccount()
//account.deposit(amount: 100)
////print(account.funds)
////account.funds -= 50 // here is the problem. make it private(set) means only read not write from out side the scope
////print(account.funds)
//let success = account.withdraw(amount: 200)
//if success {
//    //print("Withdraw successfully done")
//}else{
//    //print("Failed due to insuficent money")
//}
//
////static.
////self -> current value of the struct. Self -> current data-type of the struct.
//struct School {
////both the std_tCount property and add() method belong to the School struct itself, rather than to individual instances of the struct. Because they don’t exist uniquely on instances of the struct. Directly access.
//    static var std_count = 0
//    static func addStudent(student: String){
//        //print("\(student) joined the school")
//        std_count += 1
//    }
//}
//School.addStudent(student: "Jemmy")
////print(School.std_count)
//
//struct Empployee {
//    let name: String
//    let password: String
//
//   static let employee = Empployee(name: "Jemmmy", password: "228jdddj")
//}
//
////CheckPoint 6: Create a struct to store info about a car. including its model, number of seats, and current gear, then add a method to change gears up or down
//enum Gears_Directions {
//    case up, down, neutral
//}
//struct Car {
//    let no_of_seats: Int
//    let model: String
//    var current_Gear: Int = 0
//
//    mutating func change_Gear(direction: Gears_Directions) {
//        switch direction {
//        case .up:
//            current_Gear += 1
//            if current_Gear < 0 { current_Gear = 0}
//        case .down:
//            current_Gear -= 1
//            if current_Gear > 10 { current_Gear = 10 }
//        case .neutral:
//            current_Gear = 0
//        }
//    }
//}
//
//var bmw = Car(no_of_seats: 5, model: "BMW", current_Gear: 3)
//bmw.change_Gear(direction: .neutral)
//print(bmw.current_Gear)
//
//struct Car2 {
//    let model: String
//    let numberOfSeat: Int
//    private(set) var gear = 0 {
//        didSet {
//            //print("Your \(model) car gear has changed from \(oldValue) to \(gear)")
//        }
//    }
//
//    mutating func changeGear (newGear:Int) {
//        if newGear >= 0 && newGear <= 10 {
//            self.gear = newGear
//        } else {
//            //print("This gear is out of bounds! Choose between 0 (neutral) and 10")
//            return
//        }
//    }
//}
//var myCar = Car2(model: "Audi Q3", numberOfSeat: 5)
//myCar.changeGear(newGear: 1)
//
//
//
//
////class.
///*
// This happens because classes are reference types in Swift, which means all copies of a class all refer back to the same underlying pot of data.
//1: The things that classes and structs have in common include:
//
// You get to create and name them.
// You can add properties and methods, including property observers and access control.
// You can create custom initializers to configure new instances however you want.
//
//2: classes differ from structs in five key places:
//
// You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. If you want to selectively override some methods, you can do that too.
// Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all your properties.
// When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.
// When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.
// Even if you make a class constant, you can still change its properties as long as they are variables.
//
// here are five key differences between structs and classes:
// Classes don’t come with a memberwise initializer; structs get these by default.
// Classes can use inheritance to build up functionality; structs cannot.
// If you copy a class, both copies point to the same data; copies of structs are always unique.
// Classes can have deinitializers; structs cannot.
// You can change variable properties inside constant classes; properties inside constant structs are fixed regardless of whether the properties are constants or variables.
// */
//
//class Game_g { //change to struct. Yes no difference here but will see in the next lecture
//    var score = 0 {
//        didSet {
//            //print("Score changes now \(score)")
//        }
//    }
//}
//var newGame = Game_g()
//newGame.score += 4
//
////examples
//class Employeee {
//    let hours: Int
//
//    init(hours: Int){
//        self.hours = hours
//    }
//    func summary(){
//        print("I work \(hours) hours per day")
//    }
//
//    func boolFunc_return() -> Bool{
//        return true
//    }
//}
//class Manager: Employeee {
//    func Work() {
//        print("Yes here is the hours \(hours) from the Employeee class in Manager class")
//    }
//
//    override func boolFunc_return() -> Bool {
//        return false
//    }
//}
//final class Dev: Employeee{ // final means that it does not inherite anything to childs.
//    func work(){
//        print("Yes here is the hours \(hours) from the Employeee class in Dev class")
//    }
//
//    override func summary() {
//        print("Here is the summary is updated \(hours) ")
//    }
//}
//let ali = Manager(hours: 4)
//let khan = Dev(hours: 9)
////ali.Work()
////khan.work()
////ali.summary()
////khan.summary()
////ali.summary()
////ali.boolFunc_return()
//
//
////init in class
//class Vehicle {
//    let isElectrical: Bool
//    init(isElectrical: Bool) {
//        self.isElectrical = isElectrical
//    }
//}
//class My_Car: Vehicle {
//    let isCovertable: Bool
//
//    init(isCovertable: Bool, isElectrical: Bool) {
//        self.isCovertable = isCovertable
//        //it allows us to call up to methods that belong to our parent class
//        super.init(isElectrical: isElectrical) //super.init' isn't called on all paths before returning from initializer
//        //super is another one of those values that Swift automatically provides for us, similar to self: it allows us to call up to methods that belong to our parent class, such as its initializer. You can use it with other methods if you want; it’s not limited to initializers
//    }
//}
//let vitiz = My_Car(isCovertable: true, isElectrical: false)
////print(vitiz.isCovertable)
//
////copy- reference type
//class User {  //change to struc then check
//    var name: String = "Jemmy"
//
//    func copy() -> User {
//        let user = User()
//        user.name = name
//        return user
//    }
//}
//var user_1 = User()
////var user2 = user_1
//var user2 = user_1.copy()
//user2.name = "Khan"
//print(user_1.name)
//print(user2.name)
//
////deinit
//class Userrr {
//    let id: Int
//    init(id: Int){
//        self.id = id
//        print("User \(id), I am alive")
//    }
//
//    deinit {
//        print("User \(id), I dead")
//    }
//}
//var users = [Userrr]()
//for i in 1...3 {
//    let user = Userrr(id: i)
//    print("User \(user.id), I am in control")
//    users.append(user)
//}
//print("Loop is finished")
//users.removeAll()
//print("Array is cleared!")
//
//
//class User_j {
//    var name: String = "Jemmy"
//}
//var user_j = User_j()
//user_j.name = "Khan"
//user_j = User_j()
//print(user_j.name)
//
////variables inside class
///*
// 1: So, we end up with four options:
// Constant instance, constant property – a signpost that always points to the same user, who always has the same name.
// Constant instance, variable property – a signpost that always points to the same user, but their name can change.
// Variable instance, constant property – a signpost that can point to different users, but their names never change.
// Variable instance, variable property – a signpost that can point to different users, and those users can also change their names.
// 2: methods inside class when changes does not require the mutating keyword for func
//
// Classes have lots of things in common with structs, including the ability to have properties and methods, but there are five key differences between classes and structs.
// First, classes can inherit from other classes, which means they get access to the properties and methods of their parent class. You can optionally override methods in child classes if you want, or mark a class as being final to stop others subclassing it.
// Second, Swift doesn’t generate a memberwise initializer for classes, so you need to do it yourself. If a subclass has its own initializer, it must always call the parent class’s initializer at some point.
// Third, if you create a class instance then take copies of it, all those copies point back to the same instance. This means changing some data in one of the copies changes them all.
// Fourth, classes can have deinitializers that run when the last copy of one instance is destroyed.
// Finally, variable properties inside class instances can be changed regardless of whether the instance itself was created as variable.
// */
//
////Checlpoit 7:
///* Question:
// Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.
//
// But there’s more:
//
// The Animal class should have a legs integer property that tracks how many legs the animal has.
// The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
// The Cat class should have a matching speak() method, again with each subclass printing something different.
// The Cat class should have an isTame Boolean property, provided using an initializer.
// */
//
//class Animal {
//    var legs: Int = 0
//    init(legs: Int){
//        self.legs = legs
//    }
//}
//class Dog: Animal{
//
//    func speak(){
//        print("The dog is barking")
//    }
//}
//class Corgi: Dog{
//    override func speak() {
//        print("The Corgi is barking")
//    }
//}
//class Poddle: Dog{
//    override func speak() {
//        print("The Poddle is barking")
//    }
//}
//
//class Cat: Animal {
//    var istame: Bool
//    init(istame: Bool, legs: Int) {
//        self.istame = istame
//        super.init(legs: legs)
//    }
//
//    func Catspeak(){
//        print("Cat is Mio Mio Mio")
//    }
//
//}
//
//class Persian: Cat{
//    override func Catspeak() {
//        print("Persian is Mio Mio Mio")
//    }
//}
//class Lion: Cat{
//    override func Catspeak() {
//        print("Lion is Mio Mio Mio")
//    }
//
//}
//
//
//
//
////Protocols: They define methods and properties that we want to use. It does not implement but just exist
//protocol Vehicle_protocol {
//    var name: String { get } // only read
//    var currentPassangers: Int { get set }// read and write
//    func estimateTime(distance: Int) -> Int //yes no need of {}-body
//    func travel(distance: Int)
//}
//struct Carr2: Vehicle_protocol {
//    var name: String = "Car"
//
//    var currentPassangers: Int = 1
//    //same as like inheritane for classes
//    func estimateTime(distance: Int) -> Int {
//        return distance/50
//    }
//
//    func travel(distance: Int) {
//        //print("\(distance)km distance hsa been covered")
//    }
//
//    func openSunRoof(){
//       // print("It is a sunny day ")
//    }
//}
//
//struct Bicycle: Vehicle_protocol{
//    var name: String = "Bicycle"
//
//    var currentPassangers: Int = 1
//
//    func estimateTime(distance: Int) -> Int {
//        distance/10
//    }
//
//    func travel(distance: Int) {
//        //print("I am on bicycle and covered \(distance)km")
//    }
//}
//
//func commute(distance: Int, using vehicle: Vehicle_protocol) {
//    if vehicle.estimateTime(distance: distance) > 100 {
//        //print("That is too slow, i want to buy new car")
//    } else {
//        vehicle.travel(distance: distance)
//    }
//}
//
//func getTravel_estimate(vehicles: [Vehicle_protocol], distance: Int){
//    for vehicle in vehicles {
//        let estimate = vehicle.estimateTime(distance: distance)
//        //print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
//    }
//}
//let myBMW = Carr2()
//commute(distance: 100, using: myBMW)
//let my_bicycle = Bicycle()
//commute(distance: 144, using: my_bicycle)
//getTravel_estimate(vehicles: [myBMW, my_bicycle], distance: 150)
//
////Equatable and opaque. A type that can be compared for equality
////func getRandom_Numbers() -> some Equatable {
////    Double.random(in: 1...9)
////}
//
////func getRandom_Bool() -> some Equatable {
////    Bool.random()
////}
////print(getRandom_Bool() == getRandom_Numbers())
//
//
////Extensions. Usage and creation
//var text = "   Jemmmy is  my nick name    "
////print(text)
////let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
////print(trimmed)
//
////func trim(textString: String) -> String { //globally func
////    textString.trimmingCharacters(in: .whitespacesAndNewlines)
////}
////let trimmed = trim(textString: text)
////print(trimmed)
//
//    //using extention
//extension String {
//    func trimmed() -> String {
//        self.trimmingCharacters(in: .whitespacesAndNewlines)
//    }
//}
//let trimmed = text.trimmed()
//print(trimmed)
//
//struct Boook {
//    let name: String
//    let fname: String
//    let sum: String
//
////    init(name: String, fname: String, address: String, phoNumber: Int){ //we need both the memberwise init and custom init
////        self.name = name
////        self.fname = fname
////        self.address = address
////        self.phoNumber = phoNumber
////    }
//}
////let obj = Boook(name: "jjd", fname: "dd", address: "dd", phoNumber: 33) //get an error because of no extention
//
//extension Boook {
//    init(name: String, fname: String){
//        self.name = name
//        self.fname = fname
//        self.sum = name + fname
//    }
//}
//Boook(name: "farid", fname: "Mehmood") //it is the main use of extention
//Boook(name: "asad", fname: "ali", sum: "d")
//let obj = Boook(name: "kk", fname: "ddd", sum: "bbb")
//print(obj.fname)
//
////extensions
//var myarr2: [String] = ["jemmy", "khan", "Lia"]
////if !myarr2.isEmpty {
////    print("There are \(myarr2.count) people in the my array2")
////}
//extension Collection {  //Collection contains all array, sets, etc
//    var isNotEmpty: Bool {
//        return isEmpty == false
//    }
//}
//if myarr2.isNotEmpty{
//    //print("There are \(myarr2.count) people in the my array2")
//}
//
//protocol Personn {
//    var name: String {get}
//    func sayHello()  //make for this a defualt extension
//}
//
//extension Personn {
//    func sayHello(){
//        //print("Hi, I am \(name)")
//    }
//}
//
//struct Employeee2: Personn {
//    var name: String
//
//}
//let khan2 = Employeee2(name: "Jemmy")
//khan2.sayHello()
//
//
//
//
//
////Optionals. if let= We can use if let to run some code if the optional has a value.
////if let runs the code inside its braces if the optional had a correct value.
//let opposites = [
//    "Hello": "Aloo",
//    "Tomato": "Apple"
//]
//let Potato_opposite = opposites["Potato"]
//
//if let mango_oposite = opposites["Hello"] { //opposites["wrong"]
//    print("Mango opposite is \(mango_oposite)")
//}
//
////ex1
//var userName: String? = nil
////userName = "Jemmy"
//if let name = userName {
//    print("We got a new user \(name)")
//}else {
//    print("There is no user yet")
//}
//
////ex2
//func square(num: Int) -> Int{
//    num*num
//}
//let num: Int? = nil
////print(square(num: num)) //Value of optional type 'Int?' must be unwrapped to a value of type 'Int' Sooooo
//if let num = num {
//    print(square(num: num))
//}else{
//    print("Please enter a number?")
//}
//
//
////guard let
///*
// guard let: to run some code if the optional doesn’t have a value
// – but with guard we must always exit the function afterwards.
// guard let runs the code inside its braces if the optional didn’t have a value
// guard is designed exactly for this style of programming, and in fact does two things to help:
// If you use guard to check a function’s inputs are valid, Swift will always require you to use return if the check fails.
// If the check passes and the optional you’re unwrapping has a value inside, you can use it after the guard code finishes.
// */
//func findSquare(num: Int?){
////    if let num = num {
////        let square = num*num
////        print("The square is: \(square)")
////    }
//
//    guard let num = num else {
//        //print("Sorry no value")
//        return
//    }
//    let sqr = num*num
//    //print("The square is: \(sqr)")
//}
//findSquare(num: 0)
//
////if let
//var myvar: Int? = 3
//if let myvar = myvar {
//    //print("Run this if myvar has a value inside. \(myvar)")
//}
//
////gaurd let
////guard let myvar = myvar else {
//    //print("Run this if myvar does not have a value inside.")
//    //return //We *must* exit the function here
////}
//var variable: Int?
//if let variable = variable {
//    //print("My variable has a value: \(variable)")
//}else{
//    //print("My vairable does not have a value")
//}
//
//func myvariable(variabless: Int?){
//    guard let variabless = variabless else{
//        //print("My variabless does not have a value")
//        return
//    }
//
//    //print("My variable has a value: \(variabless)")
//}
//myvariable(variabless: 3)
//
//
////optional chaining: “if the optional has a value inside, unwrap it then…”. i.e: “if we managed to get a random element from the array, then uppercase it.”
//var namesArray: [String] = ["ali", "khan", "jemmy"] // if empty = then it prints No one
//let chosen = namesArray.randomElement()?.uppercased() ?? "No one"
////print("Next in line: \(chosen)")
//
////example2
//struct Book_of {
//    let title: String
//    let author: String?
//    //let page: Int
//}
//var mybook: Book_of? = nil
//// “if we have a book, and the book has an author, and the author has a first letter, then uppercase it and send it back, otherwise send back A”.
//let author = mybook?.author?.first?.uppercased() ?? "A"
////print(author)
//
////nil coalescing:  it lets us unwrap an optional and provide a default value if the optional was empty.
//var mynewArray: [String] = ["Jemmy", "Khan", "ALi", "Asad"] //if the array is empty then it will print No random
//let myname = mynewArray.randomElement() ?? "No random"
////print(myname)
//
//struct Book_1 {
//    var name: String
//    var fname: String?
//}
//let book1 = Book_1(name: "Jemmy", fname: nil)
//let fnammee = book1.fname ?? "Anonymous"
////print(fnammee)
//
//let inputtt = "" //try with "3"
//let numbersss = Int(inputtt) ?? 0
//print(numbersss)
//
//
////You’ll find try? is mainly used in three places:
////In combination with guard let to exit the current function if the try? call returns nil.In combination with nil coalescing to attempt something or provide a default value on failure. When calling any throwing function without a return value, when you genuinely don’t care if it succeeded or not – maybe you’re writing to a log file or sending analytics to a server, for example.
//enum Usererror: Error {
//    case badID, networkIssue
//}
//func getUseer(id: Int) throws -> String {
//    throw Usererror.networkIssue //here due the error we get nothing.
//}
//if let user = try? getUseer(id: 3) {
//    print("User: \(user)")
//}
//let userrrr = (try? getUseer(id: 3)) ?? "Anonymous"
//print(userrrr)
//
///*
// Summary
// Let’s recap what we learned:
// Optionals let us represent the absence of data, which means we’re able to say “this integer has no value” – that’s different from a fixed number such as 0.
// As a result, everything that isn’t optional definitely has a value inside, even if that’s just an empty string.
// Unwrapping an optional is the process of looking inside a box to see what it contains: if there’s a value inside it’s sent back for use, otherwise there will be nil inside.
// We can use if let to run some code if the optional has a value, or guard let to run some code if the optional doesn’t have a value – but with guard we must always exit the function afterwards.
// The nil coalescing operator, ??, unwraps and returns an optional’s value, or uses a default value instead.
// Optional chaining lets us read an optional inside another optional with a convenient syntax.
// If a function might throw errors, you can convert it into an optional using try? – you’ll either get back the function’s return value, or nil if an error is thrown.
// */
//
////Check point: 9. Your challenge is this: write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.
//
//
//func myCool(myaray: [Int]?) -> Int {
//    return myaray?.randomElement() ?? Int.random(in: 1...100) //optional chaining.
//}
//let myarrrr = [2,4,5,6,7,8]
////print(myCool(myaray: nil))
//
//var x = 10
//x
//print(x)
