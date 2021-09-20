//
//  Persistence.swift
//  Marvel
//
//  Created by Luiz Felipe on 19/09/21.
//

import CoreData

struct PersistenceController: CharactersDataSource {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Marvel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    func loadCharacters(nameStartsWith: String?, offSet: Int, onSuccess: @escaping ([Results]) -> Void, onError: @escaping () -> Void) {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")

        // To do Add scroll view to offline
        //fetchRequest.fetchLimit = 20
        //fetchRequest.fetchOffset = offSet
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        do {
            let result = try self.container.viewContext.fetch(fetchRequest)

            var characters = [Results]()

            for entity in result {

                if let id = entity.value(forKey: "id") as? Int,
                   let path = entity.value(forKey: "path") as? String,
                   let ext = entity.value(forKey: "ext") as? String,
                   let name = entity.value(forKey: "name") as? String,
                   let description = entity.value(forKey: "resultDescription") as? String {

                    let thumbnail = Thumbnail(
                        path: path,
                        thumbnailExtension: ext
                    )

                    let character = Results(
                        id: id,
                        name: name,
                        resultDescription: description,
                        thumbnail: thumbnail,
                        resourceURI: nil,
                        comics: nil,
                        series: nil,
                        stories: nil,
                        events: nil,
                        urls: nil
                    )
                    characters.append(character)
                }
            }
            onSuccess(characters)
        } catch {
            onError()
        }
    }

    func saveCharacter(character: Results, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {

        if !searchCharacterById(character: character) {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Item",
                                                             into: self.container.viewContext)

            entity.setValue(character.id, forKey: "id")
            entity.setValue(character.name, forKey: "name")
            entity.setValue(character.thumbnail?.path, forKey: "path")
            entity.setValue(character.thumbnail?.thumbnailExtension, forKey: "ext")
            entity.setValue(character.resultDescription, forKey: "resultDescription")

            do {
                try self.container.viewContext.save()
                onSuccess()
            } catch {
                onError()
            }
        }
        else {
            onError()
        }
    }

    func deleteCharacter(character: Results, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "id == \(character.id)")

        do {
            let result = try self.container.viewContext.fetch(fetchRequest)

            for entity in result {
                if let id = entity.value(forKey: "id") as? Int, id == character.id {
                    self.container.viewContext.delete(entity)
                }
            }

            try self.container.viewContext.save()
            onSuccess()
        } catch {
            onError()
        }
    }

    func searchCharacterById(character: Results) -> Bool {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "id == \(character.id)")

        do {
            let result = try self.container.viewContext.fetch(fetchRequest)

            if !result.isEmpty {
                return true
            }
        } catch {
            // Todo
        }
        return false
    }

}
