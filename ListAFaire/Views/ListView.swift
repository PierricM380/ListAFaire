//
//  ListView.swift
//  ListAFaire
//
//  Created by Pierric Marye on 19/12/2021.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var showModal = false
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink(
                destination: AddView(),
                label: {
                    Text("Ajouter")
                        .onTapGesture {
                            showModal.toggle()
                        }
                        .sheet(isPresented: $showModal, content: {
                            AddView()
                        })
                })
        )
        .navigationTitle(("Ma liste 📝"))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
