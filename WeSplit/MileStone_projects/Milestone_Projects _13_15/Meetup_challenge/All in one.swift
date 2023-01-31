//
//  All in one.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 23/01/2023.
//
import CoreLocation
import Foundation
import UIKit
import SwiftUI
import CoreLocation
import MapKit


//Models.
//Save user Image to the phot library.
class ImageSaver02: NSObject {

    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        }
        else {
            successHandler?()
        }
    }
}



struct MeetUp: Codable, Comparable {
    let id: UUID
    let name: String
    let description: String
    let image: Data?
    var latitude: Double
    var longitude: Double
    
    
    //convert UIImage to image. UIImage requires data. and Image(uiImage...)
    var wrappedImage: Image {
        if let imageData = image, let uiimage = UIImage(data: imageData) {
            return Image(uiImage: uiimage)
        }
        return Image(systemName: "camera.macro")
    }
    
    //a location var with init values of lati and longi
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //sorting the meetUps
    static func <(lhs: MeetUp, rhs: MeetUp) -> Bool {
        lhs.name < rhs.name
    }
    
    //Example for preViews.
    static let example = MeetUp(id: UUID(),
                                name: "Memory Example: Marsa",
                                description: "This is Marsa beach, after very very very heavy rain ⛈.. the sun came up 🌤 the weather was amazing, the beach looked fablous. We ate bambalouni and ice cream.",
                                image: UIImage(named: "Example-Memory")!.jpegData(compressionQuality: 0.8)!,
                                latitude: 37.33233141, longitude: -122.0312186)
    //The compressionQuality parameter can be any value between 0 (very low quality) and 1 (maximum quality); something like 0.8 gives a good trade off between size and quality.

}



//to support loading and saving of data for future use and to be persistent.
extension FileManager {
    //create a URL to a file in our documents directory wherever we want.
    static var documentsDirectory02: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
}




class LocationFetcher02: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var region = MKCoordinateRegion() //mapRegion
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("Location: started")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        region = MKCoordinateRegion(center: lastKnownLocation!, span: span) //initialising.
    }
}


struct Location02: Identifiable {
    let id = UUID()
    var cooredinate: CLLocationCoordinate2D
}


//ViewModels
//Pop up a sheet and show the phots, enable selecetion, handle cancel etc.
struct ImagePicker02: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker02
        
        init(_ parent: ImagePicker02) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //picker.dismiss(animated: true)
            
            // Camera
            if let editedImage = info[.editedImage] as? UIImage {
                self.parent.image = editedImage
            }
            
            // Photo library
            if let image = info[.originalImage] as? UIImage {
                self.parent.image = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = sourceType == .camera ? true : false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    //typealias UIViewControllerType = UIImagePickerController
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}



extension HomeView02 {
    @MainActor class HomeView_VM: ObservableObject {
        @Published private(set) var meetups = [MeetUp]()
        
        @Published var showingMeetup_addView = false
        
        //path for saving the user data to document directory.
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedMeetups")
        
        //create a new initializer and a new save() method that makes sure our data is saved automatically
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                meetups = try JSONDecoder().decode([MeetUp].self, from: data)
            } catch {
                meetups = []
            }
            print("Meetups \(meetups.count)")
        }
        //Save the gymers data to its local document directory
        func save() {
            do {
                let data = try JSONEncoder().encode(meetups)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        //what is going here...
        /*
         Meetup_addView { meetUp in homeview_vm.addMeetup(meetUp) }
         */
        func addMeetup(_ meetUp: MeetUp) {
            meetups.append(meetUp)
            save()
        }
        
        
        
        func deleteMeetUp(_ meetUp: MeetUp) {
            guard let index = meetups.firstIndex(of: meetUp) else { return }
            meetups.remove(at: index)
            save()
        }
        
        func updateMemory() { }
    }
}


extension MeetUp_DetailView {
    @MainActor class MeetUp_Detail_VM: ObservableObject {
        enum VisibleView: String {
            case photo, map
        }
        
        let meetUp: MeetUp
        var location: Location02?
        
        @Published var showingDeleteAlert = false
        @Published var currentVisibleView = VisibleView.photo
        @Published var mapRegion = MKCoordinateRegion()
        
        
        var pin: Location02 {
            location ?? Location02(cooredinate: CLLocationCoordinate2D(latitude: meetUp.latitude, longitude: meetUp.longitude))
        }
        
        
        init(meetUp: MeetUp) {
            self.meetUp = meetUp
            mapRegion = MKCoordinateRegion(center: meetUp.location, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
}


extension Meetup_addView {
    @MainActor class MeetUp_addview_VM: ObservableObject {
        @Published var inputImage: UIImage?
        @Published var image: Image?
        @Published var name: String = ""
        @Published var note: String = ""
        
        @Published var showingPhotoSelection = false
        @Published var showingPhotoLibrary = false
        @Published var showingCamera = false
        @Published var showingMapView = false
        
        let locationFetcher = LocationFetcher02()
        @Published var mapRegion = MKCoordinateRegion()
        var location: Location02?
        var wrappedPin: Location02 {
            location ?? Location02(cooredinate: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186))
        }
        
        init() {
            locationFetcher.start()
        }
        
        func save() {
            
        }
        
        func addMeetUp() -> MeetUp? {
            //you need to convert your UIImage to Data by calling its jpegData() method like this:
            guard let inputImage = inputImage,
                  let jpegData = inputImage.jpegData(compressionQuality: 0.8) else { return nil }
            
            readLocation()
            
            
            guard let location = location else { return nil }
            
            let newMeetUp = MeetUp(id: UUID(), name: name, description: note, image: jpegData, latitude: location.cooredinate.latitude, longitude: location.cooredinate.longitude)
            
            return newMeetUp
        }
        
        func readLocation() {
            if let currentlocation = locationFetcher.lastKnownLocation {
                mapRegion = MKCoordinateRegion(center: currentlocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                location = Location02(cooredinate: currentlocation)
                print("Location: \(currentlocation)")
            }
            else {
                print("Location unknown")
            }
        }
    }
}



//Views.
struct HomeView02: View {
    @StateObject private var homeview_vm = HomeView_VM()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(homeview_vm.meetups.sorted(), id: \.id) { meetUp in
                        NavigationLink {
                            MeetUp_DetailView(meetUp: meetUp) { meetUp_to_delete in
                                homeview_vm.deleteMeetUp(meetUp_to_delete)
                            }
                        } label: {
                            HStack {
                                meetUp.wrappedImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 52, height: 52)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.cyan, lineWidth: 2))
                                
                                Text(meetUp.name)
                            }
                        }

                    }
                }
            }
            .navigationTitle("MeetUps")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        homeview_vm.showingMeetup_addView = true
                    } label: {
                        Image(systemName: "plus")
                    }.foregroundColor(.black)

                }
            }
            .sheet(isPresented: $homeview_vm.showingMeetup_addView) {
                Meetup_addView { meetUp in  //take the meetUp from the addView and send to vm to append. So, that passes the meetUp into EditView, and also passes in a closure to run when the Save button is pressed.
                    homeview_vm.addMeetup(meetUp)
                }
            }
        }
    }
}

struct HomeView02_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



struct Meetup_addView: View {
    @StateObject private var vm = MeetUp_addview_VM()
    @Environment(\.dismiss) var dismiss
    var onSave: (MeetUp) -> Void //Explained below
    /*
     Problem: when we’re done editing the MeetUp, how can we pass the new MeetUp data back?
     1. Can we use binding -> No, we have optionals, so we want EditView to be bound to a real value rather than an optional value, because otherwise it would get confusing.
     2. we require a function to call where we can pass back whatever new location we want. This means any other SwiftUI can send us some data, and get back some new data to process however we want.
     3. That asks for a function that accepts a single location and returns nothing, which is perfect for our usage. We need to accept that in our initializer, like this:
     4. escaping is needed. it might not called immediatly
     */
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if vm.image == nil {
                        Button {
                            vm.showingPhotoSelection = true
                        } label: {
                            Label("Select Image", systemImage: "photo.on.rectangle.angled")
                        }.foregroundColor(.cyan)
                    } else {
                        vm.image?
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .padding()
                
                VStack {
                    //we have a second problem: when we’re done editing the location, how can we pass the new location data back?
                    TextField("Enter name", text: $vm.name)
                    TextField("Enter Description", text: $vm.note)
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                
                
                Spacer()
                Button {
                    //we need to update the Save button to create a new meetUp with the modified details, and send it back with onSave()
                    if let newMeetUp = vm.addMeetUp() {
                        onSave(newMeetUp)
                        dismiss()
                    }
                } label: {
                    Label("Save MeetUp", systemImage: "square.and.arrow.down")
                }
                .buttonStyle(.borderedProminent)
                .tint(.cyan)
                .disabled(vm.image == nil || vm.name.isEmpty)
                
                Spacer()

            }
            .navigationTitle("Add New MeetUp")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let newMeetUp = vm.addMeetUp() {
                            onSave(newMeetUp)
                            dismiss()
                        }
                    }
                }
            }
            .confirmationDialog("Select source", isPresented: $vm.showingPhotoSelection) {
                Button {
                    vm.showingPhotoLibrary = true
                } label: {
                    Label("Photo Library", systemImage: "photo")
                }
                Button {
                    vm.showingCamera = true
                } label: {
                    Label("Camera", systemImage: "camera")
                }.disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
            }
            .sheet(isPresented: $vm.showingPhotoLibrary) {
                ImagePicker(image: $vm.inputImage)
            }
            .sheet(isPresented: $vm.showingCamera) {
                ImagePicker02(image: $vm.inputImage, sourceType: .camera)
            }
            .onChange(of: vm.inputImage) { _ in loadImage() }
        }
    }
    
    func loadImage() {
        guard let inputImage = vm.inputImage else { return }
        vm.image = Image(uiImage: inputImage)
    }
    init(onSave: @escaping (MeetUp) -> Void) {
        self.onSave = onSave
//        _viewModel = StateObject(wrappedValue: ViewModel(memory: memory))
    }
}

//struct Meetup_addView_Previews: PreviewProvider {
//    static var previews: some View {
//        Meetup_addView()
//    }
//}




struct MeetUp_DetailView: View {
    @StateObject var vm: MeetUp_Detail_VM
    @Environment(\.dismiss) var dismiss
    var onDelete: (MeetUp) -> Void
    
    var body: some View {
        VStack {
            Picker("Current View", selection: $vm.currentVisibleView) {
                Image(systemName: "photo")
                    .tag(MeetUp_Detail_VM.VisibleView.photo)
                
                Image(systemName: "map")
                    .tag(MeetUp_Detail_VM.VisibleView.map)
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
            
            if vm.currentVisibleView == .photo {
                vm.meetUp.wrappedImage
                    .resizable()
                    .scaledToFit()
            } else if vm.currentVisibleView == .map {
                ZStack {
                    Map(coordinateRegion: $vm.mapRegion, annotationItems: [vm.pin]) { pin in
                        //MapMarker(coordinate: pin.cooredinate)
                        MapAnnotation(coordinate: pin.cooredinate) {
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .font(.title)
                        }
                    }
                }
                //.frame(maxWidth: .infinity, maxHeight: 300)
            }
            
            Text(vm.meetUp.name)
                .padding()
            
            Spacer()
        }
        .alert("Delete MeetUp", isPresented: $vm.showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteMeetUp)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete '\(vm.meetUp.name)'?")
        }
        .navigationTitle(vm.meetUp.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                vm.showingDeleteAlert = true
            } label: {
                Label("Delete this meetUp", systemImage: "trash")
                    .foregroundColor(.cyan)
            }
        }
    }
    
    func deleteMeetUp() {
        onDelete(vm.meetUp)
        dismiss()
    }
    
    init(meetUp: MeetUp, onDelete: @escaping (MeetUp) -> Void) {
        self.onDelete = onDelete
        _vm = StateObject(wrappedValue: MeetUp_Detail_VM(meetUp: meetUp))
    }
}

//struct MeetUp_DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MeetUp_DetailView()
//    }
//}
