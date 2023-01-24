//
//  CollapsableStack.swift
//  expand-collapse-abstraction
//
//  Created by Rohan  Gupta on 23/01/23.
//

import SwiftUI

struct CollapsableStack: View {
    var showStackView: Binding<Bool>
    var ecViews: [CollapsableView]
    var numberOfECViews: Int

    @State var indexOfTheOneAndOnlyExpandedView: Int = 0
    @State var showDone = false
    
    private let radius: CGFloat = 20
    private let verticalSpacing: CGFloat = -20
    private let nextButtonHeight: CGFloat = UIScreen.main.bounds.height * 0.1
    private let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    private let collapsedHeight: CGFloat = UIScreen.main.bounds.height * 0.15

    
    init<Views>(showStackView: Binding<Bool>, @ECViewBuilder content: @escaping () -> TupleView<Views>) {
        self.showStackView = showStackView
        self.ecViews = content().getViews
        self.numberOfECViews = self.ecViews.count
    }

    var body: some View {
        VStack(spacing: verticalSpacing) {
            if !showDone {
                Spacer()
                ForEach(0..<(indexOfTheOneAndOnlyExpandedView), id: \.self) { index in
                    ecViews[index].collpasedColor
                        .frame(height: collapsedHeight)
                        .overlay(alignment: .center) {
                            HStack {
                                Spacer()
                                Text(ecViews[index].collapsed.wrappedValue)
                                Spacer()
                            }
                        }
                        .cornerRadius(radius, corners: [.topRight, .topLeft])
                        .onTapGesture {
                            ecViews[index].expand()
                            collapseOtherViews(except: index)
                            if index >= 0 {
                                withAnimation {
                                    indexOfTheOneAndOnlyExpandedView = index
                                }
                            }
                        }
                        .transition(.move(edge: .bottom))
                }
                
                VStack {
                    ecViews[indexOfTheOneAndOnlyExpandedView].expanded
                    Spacer()
                        HStack {
                            Spacer()
                            Text(indexOfTheOneAndOnlyExpandedView < self.numberOfECViews - 1 ? ecViews[indexOfTheOneAndOnlyExpandedView + 1].buttonText : "Done")
                            Spacer()
                            if !ecViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue.isEmpty {
                                Image(systemName: "chevron.up")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .animation(.linear, value: ecViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue)
                            }
                        }
                        .frame(height: nextButtonHeight)
                        .background(content: {
                            Color.pink
                                .opacity(ecViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue.isEmpty ? 0.5 : 1)
                        })
                        .cornerRadius(radius, corners: [.topRight, .topLeft])
                        .onTapGesture {
                            if indexOfTheOneAndOnlyExpandedView < self.numberOfECViews - 1 && !ecViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue.isEmpty {
                                if let tappedView = self.ecViews.first(where: { $0.getID() == ecViews[indexOfTheOneAndOnlyExpandedView].getID() }) {
                                    tappedView.collapse()
                                }
                                
                                ecViews[indexOfTheOneAndOnlyExpandedView+1].expand()
                                withAnimation {
                                    indexOfTheOneAndOnlyExpandedView += 1
                                }
                                collapseOtherViews(except: indexOfTheOneAndOnlyExpandedView)
                            } else {
                                if !ecViews[indexOfTheOneAndOnlyExpandedView].collapsed.wrappedValue.isEmpty {
                                    withAnimation {
                                        showDone = true
                                    }
                                    collapseAllECViews()
                                }
                            }
                        }
                }
                .frame(height: sheetHeight)
                .background {
                    Color.primary
                }
                .cornerRadius(radius, corners: [.topRight, .topLeft])
            } else {
                Color.primary
                    .edgesIgnoringSafeArea(.all)
                    .overlay(alignment: .center) {
                        CustomButton(buttonText: "Close") {
                            withAnimation {
                                showStackView.wrappedValue.toggle()
                            }
                        }
                    }
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            withAnimation {
                collapseAllECViews()
            }
            withAnimation {
                expandFirstECView()
            }
        }
        .onDisappear() {
            withAnimation {
                collapseAllECViews()
            }
        }
    }
    
    //MARK:- Helper Functions
    
    private func collapseOtherViews(except index: Int) {
        for i in 0..<self.numberOfECViews {
            if i != index {
                withAnimation {
                    self.ecViews[i].collapse()
                }
            }
        }
    }
    
    private func expandFirstECView() {
        withAnimation {
            self.ecViews[0].expand()
        }
    }
    
    private func collapseAllECViews() {
        for i in 0..<self.numberOfECViews {
            withAnimation {
                self.ecViews[i].collapse()
            }
        }
    }
}





