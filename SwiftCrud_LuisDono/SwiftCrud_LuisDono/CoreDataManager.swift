import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer: NSPersistentContainer

    init(){
        persistentContainer = NSPersistentContainer(name: "Mobiliario")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion, error) in
            if let error = error {
                fatalError("Core data failed \(error.localizedDescription)")
            }
        })
    }

    func guardarMobiliario(idMobiliario: String, nombre: String, precio: String, existencia: String, categoria: String){
        let mobiliaria = Mobiliario(context: persistentContainer.viewContext)
        mobiliaria.idMobiliario = idMobiliario
        mobiliaria.nombre = nombre
        mobiliaria.precio = precio
        mobiliaria.existencia = existencia
        mobiliaria.categoria = categoria

        do{
            try persistentContainer.viewContext.save()
            print("producto guardado")
        }
        catch{
            print("failed to save error")
        }
    }

    func leerTodosLosProductos() -> [Mobiliario]{
        let fetchRequest: NSFetchRequest<Mobiliario> = Mobiliario.fetchRequest()

        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return []
        }
    }

    func borrarMobiliario(mobiliario: Mobiliario){
        persistentContainer.viewContext.delete(mobiliario)

        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context")
        }
    }

    func actualizarProducto(mobiliario: Mobiliario){
        let fetchRequest: NSFetchRequest<Mobiliario> = Mobiliario.fetchRequest()
        let predicate = NSPredicate(format: "idMobiliario = %@", mobiliario.idMobiliario ?? "")
        fetchRequest.predicate = predicate


        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.nombre = mobiliario.nombre
            p?.precio = mobiliario.precio
            p?.categoria = mobiliario.categoria
            p?.existencia = mobiliario.existencia
            //Segui asi con los demas atributos
            try persistentContainer.viewContext.save()
            print("mobilaria guardada")
        }catch{
            print("failed to save error en \(error)")
        }
    }

    func leerMobilaria(idMobiliario: String) -> Mobiliario?{
        let fetchRequest: NSFetchRequest<Mobiliario> = Mobiliario.fetchRequest()
        let predicate = NSPredicate(format: "idmob = %@", idMobiliario)
        fetchRequest.predicate = predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }catch{
            print("failed to save error en \(error)")
        }
        return nil
    }
}
