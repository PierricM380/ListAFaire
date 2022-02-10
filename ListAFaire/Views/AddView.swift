//
//  AddView.swift
//  ListAFaire
//
//  Created by Pierric Marye on 19/12/2021.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
                   presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "😱 Votre nouvelle tâche doit contenir au moins 3 caractères ! "
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Ajouter une tâche 🖊")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                TextField("Entrer quelque chose à faire ...", text: $textFieldText)
                    .padding(.all)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("PrimaryAccentColor")/*@END_MENU_TOKEN@*/)
                Button (action: saveButtonPressed, label: {
                    Text("Enregistrer".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 20)
            }
            .multilineTextAlignment(.center)
            .padding(15)
        }
        .alert(isPresented: $showAlert, content: getAlert)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
            
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
        }
    }
}
