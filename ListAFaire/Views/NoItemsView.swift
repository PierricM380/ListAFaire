//
//  NoItemsView.swift
//  ListAFaire
//
//  Created by Pierric Marye on 21/12/2021.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    @State var showSheet = false
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                .easeOut(duration: 2)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20)  {
                Text("Votre liste est vide")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Commencez à ajouter une tâche en cliquant sur le bouton.")
                    .padding(.bottom, 50)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
            NavigationLink(
                destination: AddView(),
                label: {
                    Text("Ajouter")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(height: 55)
                        .frame(width: 150)
                        .background(animate ? secondaryAccentColor : Color.accentColor)
                        .cornerRadius(15.0)
                        .onTapGesture {
                            showSheet.toggle()
                        }
                        .sheet(isPresented: $showSheet, content: {
                            AddView()
                        })
                })
                .padding(.horizontal)
                .shadow(
                    color: animate ? secondaryAccentColor.opacity(0.5) : Color.accentColor.opacity(0.5),
                    radius: animate ? 20 : 10,
                    x: 0,
                    y: animate ? 20 : 10)
                .scaleEffect(animate ? 1.1 : 1.0 )
                .offset(y: animate ? -7 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoItemsView()
                .navigationTitle("Ma liste 🗒")
        }
    }
}
