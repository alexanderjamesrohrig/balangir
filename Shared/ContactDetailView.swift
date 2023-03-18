//
//  SwiftUIView.swift
//  balangir
//
//  Created by Alexander Rohrig on 12/19/21.
//

import SwiftUI
import Contacts

struct ContactDetailView: View {
    var contact: CNContact
    let dFormat = DateFormatter()
    let cformat = CNContactFormatter()
    let cFormatPostal = CNPostalAddressFormatter()
    let nameFormat = PersonNameComponentsFormatter()
    let imageSize: CGFloat = 100
    
    var body: some View {
        ZStack {
        Form {
            Section {
                switch contact.contactType {
                case .person:
                    HStack {
                        Text(CNContact.localizedString(forKey: CNContactFamilyNameKey))
                        Spacer()
                        Text(contact.familyName)
                    }
                    HStack {
                        Text(CNContact.localizedString(forKey: CNContactGivenNameKey))
                        Spacer()
                        Text(contact.givenName)
                    }
                    if !contact.organizationName.isEmpty {
                        HStack {
                            Text(CNContact.localizedString(forKey: CNContactOrganizationNameKey))
                            Spacer()
                            Text(contact.organizationName)
                        }
                    }
                case .organization:
                    HStack {
                        Text(CNContact.localizedString(forKey: CNContactOrganizationNameKey))
                        Spacer()
                        Text(contact.organizationName)
                    }
                @unknown default:
                    Text("DISPLAY ERROR")
                }
            }
            Section {
                List(contact.phoneNumbers, id: \.identifier) { num in
                    let localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: num.label ?? "")
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(localizedLabel)
                        Spacer()
                        Text(GetContacts().formatPhoneNumber(fromString: num.value.stringValue))
//                        Text(num.value.stringValue)
                    }
                }
                List(contact.emailAddresses, id: \.identifier) { mail in
                    let localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: mail.label ?? "")
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text(localizedLabel)
                        Spacer()
                        Text(mail.value as String)
                    }
                }
                List(contact.postalAddresses, id: \.identifier) { add in
                    let localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: add.label ?? "")
                    HStack {
                        Image(systemName: "mappin")
                        Text(localizedLabel)
                        Spacer()
                        // TODO: Fix
                        Text("\(add.value.street)\n\(add.value.city)\n\(add.value.state)\n\(add.value.postalCode)\n\(add.value.country)")
                    }
                }
            }
            if let d = contact.birthday?.date {
                Section {
                    HStack {
                        Image(systemName: "calendar")
//                        Text(d.label ?? "")
                        Spacer()
                        Text(d.formatted(date: .long, time: .omitted))
                    }
                }
            }
            Text(contact.identifier)
//            Section("Family") {
//                Button("Add wife to create family") {
//                    // load person select
//                }
//            }
        }.navigationTitle(GetContacts().getLongLocalizedNameFrom(contact: contact, withStyle: .abbreviated))
//        HStack {
//            Button("Call") {
//                print("1")
//            }
//                .buttonStyle(ButtonStyleUno(image: Image(systemName: "phone.fill"), labelSecondo: nil))
//            Button("FaceTime") {
//                print("2")
//            }
//                .buttonStyle(ButtonStyleUno(image: Image(systemName: "video.fill"), labelSecondo: nil))
//            Button("Audio") {
//                print("3")
//            }
//                .buttonStyle(ButtonStyleUno(image: Image(systemName: "phone.fill"), labelSecondo: "FaceTime"))
//            Button("Message") {
//                print("4")
//            }
//                .buttonStyle(ButtonStyleUno(image: Image(systemName: "message.fill"), labelSecondo: nil))
//        }
    }
//            .padding()
//            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

//struct ContactDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
