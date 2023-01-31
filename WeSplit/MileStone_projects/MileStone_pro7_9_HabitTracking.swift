//
//  MileStone_pro7_9_HabitTracking.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 03/12/2022.
//

import SwiftUI
import Foundation

struct Work: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var date: Date = Date()
    var completedTimes: Int = 0 {
        didSet {
            date = Date()
            if completedTimes < 0 {
                completedTimes = 0
            }
        }
    }
}
class Works: ObservableObject {
    static let workKey = "workKey"
    
    @Published var works = [Work]() {
        //A didSet property observer on the items property of Expenses, so that whenever an item gets added or removed we’ll write out changes.
        didSet {
            // save data each time the content of the array is modified.
            // addition, removal, but also when modifying an element of the array.
            
            //converting our data to JSON, try encoding our works array
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(works) {
                //UserDefaults.standard.set(tapCount, forKey: "tapkey")
                //when being taped, then save into tapKey - save data
                UserDefaults.standard.set(encoded, forKey: Self.workKey) //write that to UserDefaults using the key “workKey”.
            }
            
        }
    }
    
    
    //A custom initializer for the Expenses class, so that when we make an instance of it we load any saved data from UserDefaults. items are saved when the user adds them. However, it’s not effective by itself: the data might be saved, but it isn’t loaded again when the app relaunches.
    init() {
        // 4 Steps
        /*
         1. Attempt to read the “Items” key from UserDefaults.
         2. Create an instance of JSONDecoder, which lets us convert JSON data to Swift objects.
         3. Ask the decoder to convert the data we received from UserDefaults into an array of ExpenseItem objects.
         4. If that worked, assign the resulting array to items and exit. Otherwise, set items to be an empty array.
         */
        let decoder = JSONDecoder()
        if let savedWorks = UserDefaults.standard.data(forKey: Self.workKey) {
            if let decode_Works = try? decoder.decode([Work].self, from: savedWorks) {
                self.works = decode_Works
                return
            }
        }
        self.works = []
    }
    
    //CRUD operations
    func addWork(work: Work) {
        works.append(work)
        sort_works()
    }
    
    func update(work: Work) {
        //get index of the work you want to update, then update
        guard let index = getIndex(work: work) else { return }
        works[index] = work
        sort_works()
    }
    func getIndex(work: Work) -> Int? {
        return works.firstIndex(where: {$0.id == work.id})
    }
    
    func sort_works() {
        //works.sorted(by: {$0.completedTimes > $1.completedTimes})
        // sort by most recent modification
        works.sort(by: { $0.date > $1.date } )
    }
    
    func getWork(id: UUID) -> Work {
        guard let index = getIndex_work(id: id) else {
            return Work(title: "", description: "")
        }
        return works[index]
    }
    
    func getIndex_work(id: UUID) -> Int? {
        return works.firstIndex(where: { $0.id == id})
    }
}
struct MileStone_pro7_9_HabitTracking: View {
    @StateObject var works = Works()
    @State private var showAdd_workView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(works.works) { work in
                    NavigationLink {
                        Edit_Work(work_obj: works, work_id: work.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(work.title)
                                .font(.headline)
                            Text(work.description)
                                .font(.subheadline)
                            HStack {
                                Text("Completed")
                                Text("\(work.completedTimes)")
                                    .padding(.horizontal, -3)
                                    .foregroundColor(work.completedTimes > 0 ? .green : .red)
                                Text("times")
                            }.font(.subheadline)
                        }
                    }

                }
                .onDelete(perform: remove_work)
            }
            .navigationTitle("Works")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showAdd_workView = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
        .sheet(isPresented: $showAdd_workView) {
            Add_Work(work_obj: works)
        }
    }
    
    func remove_work(index: IndexSet) {
        return works.works.remove(atOffsets: index)
    }
}
struct Add_Work: View {
    @ObservedObject var work_obj: Works
    @State var title: String = ""
    @State var description: String = ""
    @Environment(\.dismiss) var dismiso
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Work")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let work = Work(title: title, description: description)
                        self.work_obj.addWork(work: work)
                        dismiso()
                    }
                }
            }
        }
    }
}
struct Edit_Work: View {
    @ObservedObject var work_obj: Works
    // binding the activity directly instead of passing habits + activityId would be cleaner
    // but @Binding has not yet been seen at this part of the 100 days of SwiftUI course
    // so here's a solution without it
    var work_id: UUID
    var work: Work {
        work_obj.getWork(id: work_id)
    }
    
    var body: some View {
        Form {
            Text(work.title)
            Text(work.description)
            
            Stepper(
                onIncrement: { self.update_work(by: 1) },
                onDecrement: { self.update_work(by: -1) },
                label: { Text("Completed \(work.completedTimes) times") }
            )
        }.navigationTitle("Edit Work")
    }
    
    func update_work(by change: Int) {
        var work = self.work
        work.completedTimes += change
        self.work_obj.update(work: work)
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        MileStone_pro7_9_HabitTracking()
    }
}
