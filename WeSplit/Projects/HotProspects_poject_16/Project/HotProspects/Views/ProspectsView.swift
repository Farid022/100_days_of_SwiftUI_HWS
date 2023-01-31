//
//  ProspectsView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 21/01/2023.
//

import SwiftUI
import CodeScanner

//we can fix that by customizing each view. Remember, we want the first one to show every person you’ve met, the second to show people you have contacted, and the third to show people you haven’t contacted, and we can represent that with an enum plus a property on ProspectsView.
enum FilterType {
    case none, contacted, nonContacted
}

struct ProspectsView: View {
    let filterType: FilterType
    //now we want all instances of ProspectsView to read that object back out of the environment when they are created.
    @EnvironmentObject var prospects: Prospects_VM //if not provided, app will crash.
    
    @State private var isShowingScanView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        
                        Text(prospect.emailaddress)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .swipeActions {
                        if !prospect.isContected {
                            Button {
                                prospects.toggle_peopeState(prospect: prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)

                        } else {
                            Button {
                                prospects.toggle_peopeState(prospect: prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(propect: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            
                        }
                    }
                    .contextMenu {
                        Button {
                            addNotification(propect: prospect)
                        } label: {
                            Label("Remind", systemImage: "bell")
                        }
                        Button {
                            prospects.toggle_peopeState(prospect: prospect)
                        } label: {
                            Label("Contact", systemImage: "person")
                        }

                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanView = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanView) {
//                CodeScannerView(codeTypes: [.qr], simulatedData: "Farid Khan\nFarid@icloud.com", completion: handleScan)
                //Explaination
                /*
                 Creating a CodeScanner view takes three parameters:

                 1. An array of the types of codes we want to scan. We’re only scanning QR codes in this app so [.qr] is fine, but iOS supports lots of other types too.
                 2. A string to use as simulated data. Xcode’s simulator doesn’t support using the camera to scan codes, so CodeScannerView automatically presents a replacement UI so we can still test that things work. This replacement UI will automatically send back whatever we pass in as simulated data.
                 3. A completion function to use. This could be a closure, but we just wrote the handleScan() method so we’ll use that.
                 */
            }
            
        }
    }
    
    //filtering on the title.
    var title: String {
        switch filterType {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .nonContacted:
            return "Uncontacted People"
        }
    }
    
    //filtering on the pepple
    var filteredProspects: [Prospect] {
        switch filterType {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContected }
        case .nonContacted:
            return prospects.people.filter { !$0.isContected }
        }
    }
    // how does SwiftUI know to refresh the view when the property changed?. It does not know.
    /*
     When we added an @EnvironmentObject property to ProspectsView, we also asked SwiftUI to reinvoke the body property whenever that property changes. So, whenever we insert a new person into the people array its @Published property wrapper will announce the update to all views that are watching it, and SwiftUI will reinvoke the body property of ProspectsView. That in turn will calculate our computed property again, so the List will change
     */
    
    //It is used to handle the scan to check whether it is matched or not.
//    func handleScan(result: Result<ScanResult, ScanError>) {
//        isShowingScanView = false
//
//        switch result {
//        case .success(let success):
//            let details = success.string.components(separatedBy: "\n") //name \n and email in details
//            guard details.count == 2 else { return } //so if it is 2 then go
//
//            //add the person
//            let person = Prospect()
//            person.name = details[0]
//            person.emailaddress = details[1]
//            prospects.addPerson(propect: person)
//
//        case .failure(let failure):
//            print("Scanning failed: \(failure.localizedDescription)")
//        }
//    }

    
    func addNotification(propect: Prospect) {
        //Explain:
        /*
         we can request the current authorization settings, and use that to determine whether we should schedule a notification or request permission. The reason it’s helpful to use this approach rather than just requesting permission repeatedly, is that the settings object handed back to us includes properties such as alertSetting to check whether we can show an alert or not – the user might have restricted this so all we can do is display a numbered badge on our icon.
         */
        let center = UNUserNotificationCenter.current()
        
        //This puts all the code to create a notification for the current prospect into a closure
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(propect.name)"
            content.subtitle = propect.emailaddress
            content.sound = UNNotificationSound.default
            
            var dateComponent = DateComponents()
            dateComponent.hour = 9
            //UNCalendarNotificationTrigger-> it lets us specify a custom DateComponents instance.
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        
        //we’re going to use both getNotificationSettings() and requestAuthorization() together, to make sure we only schedule notifications when allowed.
        center.getNotificationSettings { settings in
            //The same code can be used if we have permission already or if we ask and have been granted permission.
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.sound, .alert, .badge]) { succes, error in
                    if succes {
                        addRequest()
                    } else {
                        print("Error")
                    }
                }
            }
        }
        
        
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filterType: .none)
            .environmentObject(Prospects_VM())
    }
}
