//
//  FirebaseAuth.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

@MainActor
class FirebaseManager: ObservableObject {
    let auth = Auth.auth()
    let storage = Storage.storage()
    let firestore = Firestore.firestore()
    
    @Published var signedIn = false
    @Published var user: User?
    @Published var bookings: [Booking] = []
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func SignUp(name: String, email: String, city: String, state: String, phone: String, installer: Bool, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            guard let uid = self?.auth.currentUser?.uid else {return}
            let userData = [
                "name": name,
                "email": email,
                "city": city,
                "state": state,
                "phone": phone,
                "installer": String(installer),
            ]
            self?.firestore.collection("userInfo").document(uid).setData(userData) { error in
                if let error = error {
                    print(error)
                    return
                }
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            DispatchQueue.main.async {
                self.signedIn = false
            }
        } catch {
            print(error)
        }
    }
    
    func fetchCurrentUser() async {
        guard let uid = self.auth.currentUser?.uid else {return}
        do {
            let snapshot = try await firestore.collection("userInfo").document(uid).getDocument()
            guard let data = snapshot.data() else {return}
            let name = data["name"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let city = data["city"] as? String ?? ""
            let state = data["state"] as? String ?? ""
            let phone = data["phone"] as? String ?? ""
            let installer = data["installer"] as? String ?? ""
            let user = User(name: name, city: city, email: email, phone: phone, state: state, installer: installer == "true" ? true : false)
            print(user)
            self.user = user
        } catch {
            print("Failed to fetch current user", error)
        }
    }
    
    func bookNewInstallation(name: String, email: String, city: String, state: String, phone: String, date: Date, planID: Int) {
        let userData = [
            "name": name,
            "email": email,
            "city": city,
            "state": state,
            "phone": phone,
            "date": date,
            "planID": planID
        ] as [String : Any]
        self.firestore.collection("bookings").document(UUID().uuidString).setData(userData) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }
    
    func fetchInstallations() {
        firestore.collection("bookings").getDocuments(completion: { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            guard let docs = snapshot?.documents else {return}
            print(docs)
            var bookings: [Booking] = []
            docs.forEach { doc in
                let data = doc.data()
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let city = data["city"] as? String ?? ""
                let state = data["state"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                let date = data["date"] as? Date ?? Date()
                let planID = data["planID"] as? Int ?? 1
                let booking = Booking(name: name, city: city, email: email, phone: phone, state: state, date: date, planID: planID)
                bookings.append(booking)
            }
            self.bookings = bookings
        })
    }
}
