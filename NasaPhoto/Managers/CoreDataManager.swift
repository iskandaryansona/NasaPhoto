//
//  CoreDataManager.swift
//  NasaPhoto
//
//  Created by Sona on 18.03.24.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()
    private init() {}

    
    var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "NasaPhoto")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func savePhotos(data: Info){
        
        guard let description = NSEntityDescription.entity(forEntityName: "PhotoInfo", in: context) else { return }
        
        let ph = PhotoInfo(entity: description, insertInto: context)
        ph.id = Int16(data.id)
        ph.imgSrc = data.imgSrc
        ph.earthDate = data.earthDate
        
        ph.rover = saveRover(data: data.rover)
        
        ph.camera = saveCamera(data: data.camera)
        
        saveContext()
    }
    
    
    func saveFilters(data: FilterModel){
        
        guard let description = NSEntityDescription.entity(forEntityName: "FilterInfo", in: context) else { return }
        
        let fl = FilterInfo(entity: description, insertInto: context)
        fl.camera = data.camera
        fl.date = data.date
        fl.rover = data.rover
        fl.id = data.id
        
        saveContext()
    }
    
    func saveRover(data: Rover) -> RoverInfo{
        
        guard let description = NSEntityDescription.entity(forEntityName: "RoverInfo", in: context) else { return RoverInfo(context: context)}
        
        let rv = RoverInfo(entity: description, insertInto: context)
        rv.id = Int16(data.id)
        rv.name = data.name
        rv.launchDate = data.launchDate
        rv.landingDate = data.landingDate
        rv.status = data.status
        
        saveContext()
        
        return rv
    }
    
    func saveCamera(data: Camera) -> CameraInfo{
        
        guard let description = NSEntityDescription.entity(forEntityName: "CameraInfo", in: context) else { return CameraInfo(context: context)}
        
        let cm = CameraInfo(entity: description, insertInto: context)
        cm.id = Int16(data.id)
        cm.name = data.name
        cm.roverID = Int16(data.roverID)
        cm.fullName = data.fullName
        
        saveContext()
        return cm
    }
    
    func fetchData() -> [PhotoInfo]{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoInfo")
        do {
            return (try? context.fetch(fetchRequest) as? [PhotoInfo]) ?? []
        }
    }
    
    
    func fetchLocalFilters() -> [FilterModel] {
        var filterModels: [FilterModel] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FilterInfo")
        do {
            
            let filterInfos = try context.fetch(fetchRequest) as? [FilterInfo] ?? []
            for fl in filterInfos {
                let filterModel = FilterModel(camera: fl.camera,
                                              rover: fl.rover,
                                              date: fl.date,
                                              id: fl.id)
                filterModels.append(filterModel)
            }
        }catch {
            //TODO ALERT
            print(error.localizedDescription)
        }
        return filterModels
    }
    
    func deleteFilter(with id: UUID){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FilterInfo")
        do {
            guard let filters = try? context.fetch(fetchRequest) as? [FilterInfo], let ft = filters.first(where: {
                $0.id == id
            }) else { return }
            context.delete(ft)
        }
        saveContext()
    }
    
    
}
