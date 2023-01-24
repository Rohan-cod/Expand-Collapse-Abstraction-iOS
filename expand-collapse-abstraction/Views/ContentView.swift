//
//  ContentView.swift
//  expand-collapse-abstraction
//
//  Created by Rohan  Gupta on 23/01/23.
//

import SwiftUI

struct ContentView: View {

    @State var showStackView: Bool = false
    @State var name: String = ""
    @State var age: String = ""
    @State var anime: String = ""
    
    var body: some View {
        ZStack {
            CustomButton(buttonText: "Add Details") {
                withAnimation {
                    showStackView.toggle()
                }
            }
            .opacity(showStackView ? 0 : 1)

            if showStackView {
                CollapsableStack(showStackView: $showStackView) {
                    CollapsableView(expanded: AnyView(
                        VStack {
                            TextField("Name", text: $name)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: 40)
                                .background {
                                    Color.orange
                                }
                                .cornerRadius(20)
                                .padding()
                        }
                    ), collapsed: $name, buttonText: "Name", collapsedColor: .red)

                    CollapsableView(expanded: AnyView(
                        VStack {
                            TextField("Age", text: $age)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: 40)
                                .background {
                                    Color.orange
                                }
                                .cornerRadius(20)
                                .padding()
                        }
                    ), collapsed: $age, buttonText: "Age", collapsedColor: .orange)

                    CollapsableView(expanded: AnyView(
                        VStack {
                            TextField("Anime", text: $anime)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: 40)
                                .background {
                                    Color.orange
                                }
                                .cornerRadius(20)
                                .padding()
                        }
                    ), collapsed: $anime, buttonText: "Anime", collapsedColor: .purple)
                }
                .transition(.move(edge: .bottom))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

