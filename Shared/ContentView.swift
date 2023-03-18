//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Rohrig on 12/19/21.
//

import SwiftUI
import Contacts

struct ContentView: View {
    
    @State var contacts = [ContactModel]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.contacts) { contact in
                    NavigationLink(destination: ContactDetailView(contact: contact.info)) {
                        ContactRowView(contact: contact.info)
                            .swipeActions {
                                Button {
                                    print("message")
                                } label: {
                                    Label("Message", systemImage: "message.fill")
                                }
                            }
                    }
                    .navigationTitle("Contatti")
                }
            }
        }
        .onAppear() {
            GetContactAccess()
        }
    }
    
    func GetContactAccess() {
        let store = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            print("contact access authorized")
            contacts = GetContacts().getContacts()
        case .denied:
            print("contact access not authorized")
        case .notDetermined:
            store.requestAccess(for: .contacts) {(granted, error) in
                if granted {
                    print("contact access authorized")
                    contacts = GetContacts().getContacts()
                }
            }
        case .restricted:
            print("user unable to view contacts")
        default:
            contacts = GetContacts().getContacts()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
