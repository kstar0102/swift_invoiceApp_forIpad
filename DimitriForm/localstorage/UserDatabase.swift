//
//  UserData.swift
//  DimitriForm
//
//  Created by Kei on 5/15/22.
//

import Foundation
import CoreData

class UserDatabase : NSObject {
    
    static var persistentContainer: NSPersistentContainer = {
       
           let container = NSPersistentContainer(name: "DimitriForm")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {

                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()
       
       static func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror)")
               }
           }
       }
    
    static func getInvoiceDatas() -> [InvoiceData] {
            var InData:[InvoiceData] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InvoiceData")
        
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(key: "title", ascending: true)
            ]

            let fetchData = try! context.fetch(fetchRequest)

            if(!fetchData.isEmpty){
                for i in 0..<fetchData.count{
                    InData.append(fetchData[i] as! InvoiceData)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }

            return InData
        }
    
    static func getCurrentInvoiceDatas(Sid:UUID) -> [InvoiceData] {
            var InData:[InvoiceData] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InvoiceData")
        
            fetchRequest.predicate = NSPredicate(format: "id == %@", Sid as CVarArg)

            let fetchData = try! context.fetch(fetchRequest)

            if(!fetchData.isEmpty){
                for i in 0..<fetchData.count{
                    InData.append(fetchData[i] as! InvoiceData)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }

            return InData
        }
    
    
    static func getUserDatas() -> [UserData] {
            var userData:[UserData] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(key: "firstname", ascending: true)
            ]

            let fetchData = try! context.fetch(fetchRequest)

            if(!fetchData.isEmpty){
                for i in 0..<fetchData.count{
                    userData.append(fetchData[i] as! UserData)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }

            return userData
        }
    
    static func getCurrentUserDatas(Sid:UUID) -> [UserData] {
            var userData:[UserData] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", Sid as CVarArg)

            let fetchData = try! context.fetch(fetchRequest)

            if(!fetchData.isEmpty){
                for i in 0..<fetchData.count{
                    userData.append(fetchData[i] as! UserData)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }

            return userData
        }
    
    static func getCurrentPhoneDatas(phoneNumaber:String) -> [UserData] {
            var userData:[UserData] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        fetchRequest.predicate = NSPredicate(format: "primary == %@", phoneNumaber)

            let fetchData = try! context.fetch(fetchRequest)

            if(!fetchData.isEmpty){
                for i in 0..<fetchData.count{
                    userData.append(fetchData[i] as! UserData)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }

            return userData
        }
    
    static func getCurrentsecondaryDatas(phoneNumaber:String) -> [UserData] {
            var userData:[UserData] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        fetchRequest.predicate = NSPredicate(format: "secondary == %@", phoneNumaber)

            let fetchData = try! context.fetch(fetchRequest)

            if(!fetchData.isEmpty){
                for i in 0..<fetchData.count{
                    userData.append(fetchData[i] as! UserData)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }

            return userData
        }
    
    static func deleteCurrentUserData(Did:UUID) {
        
        let managedContext = persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        let predicate = NSPredicate(format: "id == %@", Did as CVarArg)
        deleteFetch.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

       do {
          try managedContext.execute(deleteRequest)
          try managedContext.save()
       } catch {
          print ("There was an error")
       }
    }
    
    static func updataUserdata(UserId:UUID, firstname:String, lastname:String, postal:String, address:String, secondary:String,
                               primary:String, division:String, employer:String, note:String, city:String, cce:String, cpp:String,
                               company:String, birth:String, gender:String){
        
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "UserData")
          fetchRequest.predicate = NSPredicate(format: "id = %@", UserId as CVarArg)

        do {
          let test = try managedContext.fetch(fetchRequest)
          if test.count != 0 {
            let objectUpdate = test[0] as! NSManagedObject
              objectUpdate.setValue(firstname, forKey: "firstname")
              objectUpdate.setValue(lastname, forKey: "lastname")
              objectUpdate.setValue(postal, forKey: "postal")
              objectUpdate.setValue(address, forKey: "address")
              objectUpdate.setValue(secondary, forKey: "secondary")
              objectUpdate.setValue(primary, forKey: "primary")
              objectUpdate.setValue(division, forKey: "division")
              objectUpdate.setValue(employer, forKey: "employer")
              objectUpdate.setValue(note, forKey: "note")
              objectUpdate.setValue(city, forKey: "city")
              objectUpdate.setValue(cce, forKey: "cce")
              objectUpdate.setValue(cpp, forKey: "cpp")
              objectUpdate.setValue(company, forKey: "company")
              objectUpdate.setValue(birth, forKey: "birth")
              objectUpdate.setValue(gender, forKey: "gender")
              try managedContext.save()// look in AppDelegate.swift for this function
          }
        } catch {
          print(error)
        }
    }
    
    static func getProductDatas() -> [ProductData] {
            var productData:[ProductData] = []
            let context = persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(key: "productname", ascending: true)
            ]

            let fetchData = try! context.fetch(fetchRequest)

            if(!fetchData.isEmpty){
                for i in 0..<fetchData.count{
                    productData.append(fetchData[i] as! ProductData)
                }
                do{
                    try context.save()
                }catch{
                    print(error)
                }
            }

            return productData
        }
    
    static func getCurrentProductDatas(Sid:UUID) -> [ProductData] {
        var PData:[ProductData] = []
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
    
        fetchRequest.predicate = NSPredicate(format: "id == %@", Sid as CVarArg)

        let fetchData = try! context.fetch(fetchRequest)

        if(!fetchData.isEmpty){
            for i in 0..<fetchData.count{
                PData.append(fetchData[i] as! ProductData)
            }
            do{
                try context.save()
            }catch{
                print(error)
            }
        }

        return PData
    }
    
    static func deleteCurrentProductData(Did:UUID) {
        
        let managedContext = persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        let predicate = NSPredicate(format: "id == %@", Did as CVarArg)
        deleteFetch.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

       do {
          try managedContext.execute(deleteRequest)
          try managedContext.save()
       } catch {
          print ("There was an error")
       }
    }
    
    static func updataProductdata(PId:UUID, name:String, unit:String, des:String){
        
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ProductData")
          fetchRequest.predicate = NSPredicate(format: "id = %@", PId as CVarArg)

        do {
          let test = try managedContext.fetch(fetchRequest)
          if test.count != 0 {
            let objectUpdate = test[0] as! NSManagedObject
              objectUpdate.setValue(name, forKey: "productname")
              objectUpdate.setValue(unit, forKey: "productunit")
              objectUpdate.setValue(des, forKey: "productdes")
              try managedContext.save()
          }
        } catch {
          print(error)
        }
    }
}
