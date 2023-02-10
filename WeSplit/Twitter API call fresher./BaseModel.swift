//
//  BaseModel.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 02/02/2023.
//

import Foundation
import SwiftUI

//struct Json4Swift_Base: Codable, Hashable {
//    static func == (lhs: Json4Swift_Base, rhs: Json4Swift_Base) -> Bool {
//        lhs.hashValue < rhs.hashValue
//    }
//
//    let fisheryManagement: String?
//    let habitat : String?
//    let habitatImpacts : String?
//    let imageGallery : [ImageGallery]?
//    let location : String?
//    let management : String?
//    let nOAAFisheriesRegion : String?
//    let population : String?
//    let populationStatus : String?
//    let scientificName : String?
//    let speciesAliases : String?
//    let speciesIllustrationPhoto : SpeciesIllustrationPhoto?
//    let speciesName : String?
//    let animalHealth : String?
//    let availability : String?
//    let biology : String?
//    let bycatch : String?
//    let calories : String?
//    let carbohydrate : String?
//    let cholesterol : String?
//    let color : String?
//    let diseaseTreatmentandPrevention : String?
//    let diseasesinSalmon : String?
//    let displayedSeafoodProfileIllustration : String?
//    let ecosystemServices : String?
//    let environmentalConsiderations : String?
//    let environmentalEffects : String?
//    let farmingMethods : String?
//    let farmingMethods_ : String?
//    let fatTotal : String?
//    let feeds_ : String?
//    let feeds : String?
//    let fiberTotalDietary : String?
//    let fishingRate : String?
//    let harvest : String?
//    let harvestType : String?
//    let healthBenefits : String?
//    let human_Health_ : String?
//    let humanHealth : String?
//    let physicalDescription : String?
//    let production : String?
//    let protein : String?
//    let quote : String?
//    let quoteBackgroundColor : String?
//    let research : String?
//    let saturatedFattyAcidsTotal : String?
//    let selenium : String?
//    let servingWeight : String?
//    let servings : String?
//    let sodium : String?
//    let source : String?
//    let sugarsTotal : String?
//    let taste : String?
//    let texture : String?
//    let path : String?
//    let last_update : String?
//
//    enum CodingKeys: String, CodingKey {
//        case fisheryManagement = "Fishery Management"
//        case habitat = "Habitat"
//        case habitatImpacts = "Habitat Impacts"
//        case imageGallery = "Image Gallery"
//        case location = "Location"
//        case management = "Management"
//        case nOAAFisheriesRegion = "NOAA Fisheries Region"
//        case population = "Population"
//        case populationStatus = "Population Status"
//        case scientificName = "Scientific Name"
//        case speciesAliases = "Species Aliases"
//        case speciesIllustrationPhoto = "Species Illustration Photo"
//        case speciesName = "Species Name"
//        case animalHealth = "Animal Health"
//        case availability = "Availability"
//        case biology = "Biology"
//        case bycatch = "Bycatch"
//        case calories = "Calories"
//        case carbohydrate = "Carbohydrate"
//        case cholesterol = "Cholesterol"
//        case color = "Color"
//        case diseaseTreatmentandPrevention = "Disease Treatment and Prevention"
//        case diseasesinSalmon = "Diseases in Salmon"
//        case displayedSeafoodProfileIllustration = "Displayed Seafood Profile Illustration"
//        case ecosystemServices = "Ecosystem Services"
//        case environmentalConsiderations = "Environmental Considerations"
//        case environmentalEffects = "Environmental Effects"
//        case farmingMethods = "Farming Methods"
//        case farmingMethods_ = "Farming Methods_"
//        case fatTotal = "Fat, Total"
//        case feeds_ = "Feeds_"
//        case feeds = "Feeds"
//        case fiberTotalDietary = "Fiber, Total Dietary"
//        case fishingRate = "Fishing Rate"
//        case harvest = "Harvest"
//        case harvestType = "Harvest Type"
//        case healthBenefits = "Health Benefits"
//        case human_Health_ = "Human_Health_"
//        case humanHealth = "Human Health"
//        case physicalDescription = "Physical Description"
//        case production = "Production"
//        case protein = "Protein"
//        case quote = "Quote"
//        case quoteBackgroundColor = "Quote Background Color"
//        case research = "Research"
//        case saturatedFattyAcidsTotal = "Saturated Fatty Acids, Total"
//        case selenium = "Selenium"
//        case servingWeight = "Serving Weight"
//        case servings = "Servings"
//        case sodium = "Sodium"
//        case source = "Source"
//        case sugarsTotal = "Sugars, Total"
//        case taste = "Taste"
//        case texture = "Texture"
//        case path = "Path"
//        case last_update = "last_update"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        fisheryManagement = try values.decodeIfPresent(String.self, forKey: .fisheryManagement)
//        habitat = try values.decodeIfPresent(String.self, forKey: .habitat)
//        habitatImpacts = try values.decodeIfPresent(String.self, forKey: .habitatImpacts)
//        imageGallery = try values.decodeIfPresent([ImageGallery].self, forKey: .imageGallery)
//        location = try values.decodeIfPresent(String.self, forKey: .location)
//        management = try values.decodeIfPresent(String.self, forKey: .management)
//        nOAAFisheriesRegion = try values.decodeIfPresent(String.self, forKey: .nOAAFisheriesRegion)
//        population = try values.decodeIfPresent(String.self, forKey: .population)
//        populationStatus = try values.decodeIfPresent(String.self, forKey: .populationStatus)
//        scientificName = try values.decodeIfPresent(String.self, forKey: .scientificName)
//        speciesAliases = try values.decodeIfPresent(String.self, forKey: .speciesAliases)
//        speciesIllustrationPhoto = try values.decodeIfPresent(SpeciesIllustrationPhoto.self, forKey: .speciesIllustrationPhoto)
//        speciesName = try values.decodeIfPresent(String.self, forKey: .speciesName)
//        animalHealth = try values.decodeIfPresent(String.self, forKey: .animalHealth)
//        availability = try values.decodeIfPresent(String.self, forKey: .availability)
//        biology = try values.decodeIfPresent(String.self, forKey: .biology)
//        bycatch = try values.decodeIfPresent(String.self, forKey: .bycatch)
//        calories = try values.decodeIfPresent(String.self, forKey: .calories)
//        carbohydrate = try values.decodeIfPresent(String.self, forKey: .carbohydrate)
//        cholesterol = try values.decodeIfPresent(String.self, forKey: .cholesterol)
//        color = try values.decodeIfPresent(String.self, forKey: .color)
//        diseaseTreatmentandPrevention = try values.decodeIfPresent(String.self, forKey: .diseaseTreatmentandPrevention)
//        diseasesinSalmon = try values.decodeIfPresent(String.self, forKey: .diseasesinSalmon)
//        displayedSeafoodProfileIllustration = try values.decodeIfPresent(String.self, forKey: .displayedSeafoodProfileIllustration)
//        ecosystemServices = try values.decodeIfPresent(String.self, forKey: .ecosystemServices)
//        environmentalConsiderations = try values.decodeIfPresent(String.self, forKey: .environmentalConsiderations)
//        environmentalEffects = try values.decodeIfPresent(String.self, forKey: .environmentalEffects)
//        farmingMethods = try values.decodeIfPresent(String.self, forKey: .farmingMethods)
//        farmingMethods_ = try values.decodeIfPresent(String.self, forKey: .farmingMethods_)
//        fatTotal = try values.decodeIfPresent(String.self, forKey: .fatTotal)
//        feeds_ = try values.decodeIfPresent(String.self, forKey: .feeds_)
//        feeds = try values.decodeIfPresent(String.self, forKey: .feeds)
//        fiberTotalDietary = try values.decodeIfPresent(String.self, forKey: .fiberTotalDietary)
//        fishingRate = try values.decodeIfPresent(String.self, forKey: .fishingRate)
//        harvest = try values.decodeIfPresent(String.self, forKey: .harvest)
//        harvestType = try values.decodeIfPresent(String.self, forKey: .harvestType)
//        healthBenefits = try values.decodeIfPresent(String.self, forKey: .healthBenefits)
//        human_Health_ = try values.decodeIfPresent(String.self, forKey: .human_Health_)
//        humanHealth = try values.decodeIfPresent(String.self, forKey: .humanHealth)
//        physicalDescription = try values.decodeIfPresent(String.self, forKey: .physicalDescription)
//        production = try values.decodeIfPresent(String.self, forKey: .production)
//        protein = try values.decodeIfPresent(String.self, forKey: .protein)
//        quote = try values.decodeIfPresent(String.self, forKey: .quote)
//        quoteBackgroundColor = try values.decodeIfPresent(String.self, forKey: .quoteBackgroundColor)
//        research = try values.decodeIfPresent(String.self, forKey: .research)
//        saturatedFattyAcidsTotal = try values.decodeIfPresent(String.self, forKey: .saturatedFattyAcidsTotal)
//        selenium = try values.decodeIfPresent(String.self, forKey: .selenium)
//        servingWeight = try values.decodeIfPresent(String.self, forKey: .servingWeight)
//        servings = try values.decodeIfPresent(String.self, forKey: .servings)
//        sodium = try values.decodeIfPresent(String.self, forKey: .sodium)
//        source = try values.decodeIfPresent(String.self, forKey: .source)
//        sugarsTotal = try values.decodeIfPresent(String.self, forKey: .sugarsTotal)
//        taste = try values.decodeIfPresent(String.self, forKey: .taste)
//        texture = try values.decodeIfPresent(String.self, forKey: .texture)
//        path = try values.decodeIfPresent(String.self, forKey: .path)
//        last_update = try values.decodeIfPresent(String.self, forKey: .last_update)
//    }
//
//}
//struct SpeciesIllustrationPhoto: Codable, Hashable {
//    let src : String
//    let alt : String
//    let title : String
//}
//
//
//struct ImageGallery: Codable, Hashable  {
//    let src : String
//    let alt : String
//    let title : String
//}

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let fisheryManagement, habitat, habitatImpacts: String?
    let imageGallery: ImageGallery
    let location, management: String?
    let noaaFisheriesRegion: NOAAFisheriesRegion
    let population, populationStatus: String?
    let scientificName, speciesAliases: String
    let speciesIllustrationPhoto: SpeciesIllustrationPhoto
    let speciesName: String
    let animalHealth: String?
    let availability, biology: String
    let bycatch, calories, carbohydrate, cholesterol: String?
    let color: String?
    let diseaseTreatmentAndPrevention: JSONNull?
    let diseasesInSalmon: String?
    let displayedSeafoodProfileIllustration: JSONNull?
    let ecosystemServices, environmentalConsiderations, environmentalEffects, farmingMethods: String?
    let welcomeFarmingMethods, fatTotal, welcomeFeeds, feeds: String?
    let fiberTotalDietary, fishingRate, harvest: String?
    let harvestType: HarvestType
    let healthBenefits, welcomeHumanHealth, humanHealth: String?
    let physicalDescription: String
    let production, protein: String?
    let quote, quoteBackgroundColor: String
    let research, saturatedFattyAcidsTotal, selenium: String?
    let servingWeight: ServingWeight?
    let servings, sodium: String?
    let source: String
    let sugarsTotal, taste, texture: String?
    let path, lastUpdate: String

    enum CodingKeys: String, CodingKey {
        case fisheryManagement = "Fishery Management"
        case habitat = "Habitat"
        case habitatImpacts = "Habitat Impacts"
        case imageGallery = "Image Gallery"
        case location = "Location"
        case management = "Management"
        case noaaFisheriesRegion = "NOAA Fisheries Region"
        case population = "Population"
        case populationStatus = "Population Status"
        case scientificName = "Scientific Name"
        case speciesAliases = "Species Aliases"
        case speciesIllustrationPhoto = "Species Illustration Photo"
        case speciesName = "Species Name"
        case animalHealth = "Animal Health"
        case availability = "Availability"
        case biology = "Biology"
        case bycatch = "Bycatch"
        case calories = "Calories"
        case carbohydrate = "Carbohydrate"
        case cholesterol = "Cholesterol"
        case color = "Color"
        case diseaseTreatmentAndPrevention = "Disease Treatment and Prevention"
        case diseasesInSalmon = "Diseases in Salmon"
        case displayedSeafoodProfileIllustration = "Displayed Seafood Profile Illustration"
        case ecosystemServices = "Ecosystem Services"
        case environmentalConsiderations = "Environmental Considerations"
        case environmentalEffects = "Environmental Effects"
        case farmingMethods = "Farming Methods"
        case welcomeFarmingMethods = "Farming Methods_"
        case fatTotal = "Fat, Total"
        case welcomeFeeds = "Feeds_"
        case feeds = "Feeds"
        case fiberTotalDietary = "Fiber, Total Dietary"
        case fishingRate = "Fishing Rate"
        case harvest = "Harvest"
        case harvestType = "Harvest Type"
        case healthBenefits = "Health Benefits"
        case welcomeHumanHealth = "Human_Health_"
        case humanHealth = "Human Health"
        case physicalDescription = "Physical Description"
        case production = "Production"
        case protein = "Protein"
        case quote = "Quote"
        case quoteBackgroundColor = "Quote Background Color"
        case research = "Research"
        case saturatedFattyAcidsTotal = "Saturated Fatty Acids, Total"
        case selenium = "Selenium"
        case servingWeight = "Serving Weight"
        case servings = "Servings"
        case sodium = "Sodium"
        case source = "Source"
        case sugarsTotal = "Sugars, Total"
        case taste = "Taste"
        case texture = "Texture"
        case path = "Path"
        case lastUpdate = "last_update"
    }
}

enum HarvestType: String, Codable {
    case farmed = "Farmed"
    case wild = "Wild"
}

enum ImageGallery: Codable {
    case speciesIllustrationPhoto(SpeciesIllustrationPhoto)
    case speciesIllustrationPhotoArray([SpeciesIllustrationPhoto])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([SpeciesIllustrationPhoto].self) {
            self = .speciesIllustrationPhotoArray(x)
            return
        }
        if let x = try? container.decode(SpeciesIllustrationPhoto.self) {
            self = .speciesIllustrationPhoto(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(ImageGallery.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ImageGallery"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .speciesIllustrationPhoto(let x):
            try container.encode(x)
        case .speciesIllustrationPhotoArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - SpeciesIllustrationPhoto
struct SpeciesIllustrationPhoto: Codable {
    let src: String
    let alt, title: String
}

enum NOAAFisheriesRegion: String, Codable {
    case alaska = "Alaska"
    case greaterAtlantic = "Greater Atlantic"
    case greaterAtlanticSoutheast = "Greater Atlantic, Southeast"
    case pacificIslands = "Pacific Islands"
    case southeast = "Southeast"
    case westCoast = "West Coast"
    case westCoastAlaska = "West Coast, Alaska"
    case westCoastGreaterAtlanticAlaska = "West Coast, Greater Atlantic, Alaska"
    case westCoastGreaterAtlanticSoutheast = "West Coast, Greater Atlantic, Southeast"
    case westCoastPacificIslands = "West Coast, Pacific Islands"
}

enum ServingWeight: String, Codable {
    case nA = "n/a"
    case servingWeight100GRaw = "100 g (raw) "
    case the100G = "100 g"
    case the100G3½OzRaw = "100 g (3½ oz) raw"
    case the100GRaw = "100 g (raw)"
    case the113G = "113 g"
    case the113G4OzFresh = "113 g / 4 oz (fresh)"
    case the113GFresh = "113 g (fresh)"
    case the114GRaw = "114 g (raw)"
    case the4OzRaw = "4 oz. (raw)"
}

typealias Welcome = [WelcomeElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}







class MyObservableClass: ObservableObject {
    @Published var myData = [WelcomeElement]()
    
//    init() async {
//        await loadData()
//    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.fishwatch.gov/api/species") else {
            print("There was an error while loading the url...")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            if let decodeData = try? JSONDecoder().decode([WelcomeElement].self, from: data) {
                myData = decodeData
                print(decodeData)
            }
        } catch {
            print("There was an error while loading the data...")
        }
    }
}

struct MyView_twitterHelp: View {
    @StateObject private var mybase_vm = MyObservableClass()
    var body: some View {
        VStack {
            Text("Species Names are loaded").font(.title.bold())
            ScrollView  {
                ForEach(mybase_vm.myData, id: \.speciesName){ item in
                    Text(item.speciesName)
                }
            }
        }
        .task {
            await mybase_vm.loadData()
        }
    }
}


