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
import FirebaseFirestore
import GoogleSignIn

struct OTService {

  static private let dbReference = Database.database().reference()

  static func loginUser(_ email: String, _ password: String, completion: AuthDataResultCallback?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
  }

  @available(*, deprecated, message: "Use `createUserFirestore` instead")
  static func createUser(_ email: String, _ password: String, _ fullName: String, completion: AuthDataResultCallback?) {
    Auth.auth().createUser(withEmail: email, password: password, completion: completion)
  }

  static func createUserFirestore(_ email: String, _ password: String, _ fullName: String, completion: AuthDataResultCallback?) {
    Auth.auth().createUser(withEmail: email, password: password, completion: completion)
  }

  @available(*, deprecated, message: "Use `signInWithGoogleFirestore` instead")
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
      dbReference.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
        if !snapshot.exists() {
          guard let email = result?.user.email else { return }
          guard let displayName = result?.user.displayName else { return }
          let values: [String: Any] = [
            "email": email,
            "fullName": displayName,
            "hasSeenOnboarding": false
          ]
          addUserToDatabase(uid, values, completion: completion)
        } else {
          completion(error, dbReference.child("users").child(uid))
        }
      }
    }
  }

  static func signInWithGoogleFirestore(user: GIDGoogleUser, completion: ((Error?) -> Void)?) {
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
      dbReference.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
        if !snapshot.exists() {
          guard let email = result?.user.email else { return }
          guard let displayName = result?.user.displayName else { return }
          let values: [String: Any] = [
            "email": email,
            "fullName": displayName,
            "hasSeenOnboarding": false,
            "uid": uid
          ]
          addUserToFirestore(uid, values, completion: completion)
        }
      }
    }
  }

  @available(*, deprecated, message: "Use `addUserToFirestore` instead")
  static func addUserToDatabase(_ uid: String, _ values: [String: Any], completion: @escaping (Error?, DatabaseReference) -> Void) {
    dbReference.child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
  }

  static func addUserToFirestore(_ uid: String, _ values: [String: Any], completion: ((Error?) -> Void)?) {
    Firestore.firestore().collection("users").document(uid).setData(values, completion: completion)
  }

  @available(*, deprecated, message: "Use `fetchUserFirestore` instead")
  static func fetchUser(_ completion: @escaping (User) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    dbReference.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
      guard let values = snapshot.value as? [String: Any] else { return }
      let user = User(uid: snapshot.key, values: values)
      completion(user)
    }
  }

  static func fetchUserFirestore(_ completion: @escaping (Result<User, Error>) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
      if let error = error {
        completion(.failure(error))
        return
      }

      if let snapshot = snapshot, let values = snapshot.data() {
        let user = User(uid: snapshot.documentID, values: values)
        completion(.success(user))
        return
      }

    }
  }

  @available(*, deprecated, message: "Use `updateUserValuesOnFirestore` instead")
  static func updateUserValuesOnDatabase(_ completion: @escaping (Error?, DatabaseReference) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    dbReference.child("users").child(uid).child("hasSeenOnboarding").setValue(true, withCompletionBlock: completion)
  }

  static func updateUserValuesOnFirestore(_ completion: ((Error?) -> Void)?) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let data = ["hasSeenOnboarding": true]
    Firestore.firestore().collection("users").document(uid).updateData(data, completion: completion)
    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
  }

  static func resetPassword(for email: String, completion: SendPasswordResetCallback?) {
    Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
  }
}
