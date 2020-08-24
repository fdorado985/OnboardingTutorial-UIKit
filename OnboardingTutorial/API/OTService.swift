//
//  OTService.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

struct OTService {

  static private let dbReference = Database.database().reference()

  static func loginUser(_ email: String, _ password: String, completion: AuthDataResultCallback?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
  }

  static func createUser(_ email: String, _ password: String, _ fullName: String, completion: AuthDataResultCallback?) {
    Auth.auth().createUser(withEmail: email, password: password, completion: completion)
  }

  static func signInWithGoogle(user: GIDGoogleUser, completion: @escaping (Error?, DatabaseReference) -> Void) {
    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(
      withIDToken: authentication.idToken,
      accessToken: authentication.accessToken
    )

    Auth.auth().signIn(with: credential) { (result, error) in
      if let error = error {
        print("Error: \(#function) \(error.localizedDescription)")
        return
      }

      guard let uid = result?.user.uid else { return }
      guard let email = result?.user.email else { return }
      guard let displayName = result?.user.displayName else { return }
      let values: [String: Any] = [
        "email": email,
        "fullName": displayName,
        "hasSeenOnboarding": false
      ]

      addUserToDatabase(uid, values, completion: completion)
    }
  }

  static func addUserToDatabase(_ uid: String, _ values: [String: Any], completion: @escaping (Error?, DatabaseReference) -> Void) {
    dbReference.child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
  }

  static func fetchUser(_ completion: @escaping (User) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    dbReference.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
      guard let values = snapshot.value as? [String: Any] else { return }
      let user = User(uid: snapshot.key, values: values)
      completion(user)
    }
  }

  static func updateUserValuesOnDatabase(_ completion: @escaping (Error?, DatabaseReference) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    dbReference.child("users").child(uid).child("hasSeenOnboarding").setValue(true, withCompletionBlock: completion)
  }
}
