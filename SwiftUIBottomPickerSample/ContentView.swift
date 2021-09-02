//
//  ContentView.swift
//  SwiftUIBottomPickerSample
//
//  Created by Daisuke TONOSAKI on 2021/09/02.
//

import SwiftUI

struct ContentView: View {
    @State var onAppeared: Bool = false
    @State var showingFruit: Bool = false
    @State var showingAnimal: Bool = false
    @State var selectIndexFruit: Int = 0
    @State var selectIndexAnimal: Int = 0
    
    private let fruits: [String] = [
        "Peach 🍑",
        "Grape 🍇",
        "Pear 🍐",
    ]

    private let animals: [String] = [
        "Turtle 🐢",
        "Whale 🐳",
        "Penguin 🐧",
    ]
    
    
    var body: some View {
        NavigationView {
            
            GeometryReader { geometry in
                ZStack {
                    ScrollView(.vertical, showsIndicators: true) {
                        // Button
                        VStack {
                            HStack {
                                Text("Fruit")
                                    .font(.title2)
                                    .frame(width: 100)

                                Spacer().frame(width: 10)
                                
                                Button(action: {
                                    showingFruit = true
                                    showingAnimal = false
                                }, label: {
                                        Text(fruits[selectIndexFruit])
                                            .font(.title2)
                                })
                                .frame(idealWidth: .infinity, maxWidth: .infinity)
                            }
                            
                            Spacer().frame(height: 10)
                            
                            HStack {
                                Text("Animal")
                                    .font(.title2)
                                    .frame(width: 100)

                                Spacer().frame(width: 10)

                                Button(action: {
                                    showingFruit = false
                                    showingAnimal = true
                                }, label: {
                                    Text(animals[selectIndexAnimal])
                                        .font(.title2)
                                })
                                .frame(idealWidth: .infinity, maxWidth: .infinity)
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    }
                    
                    
                    // Picker
                    if onAppeared {
                        VStack {
                            Spacer()
                            
                            SelectPicker(selectIndex: $selectIndexFruit,
                                         isShowing: $showingFruit,
                                         elements: fruits)
                                .animation(.easeOut)
                                .offset(y: showingFruit ? geometry.safeAreaInsets.bottom : SelectPicker.viewHeight + geometry.safeAreaInsets.bottom)
                                .frame(height: SelectPicker.viewHeight)
                                .ignoresSafeArea()
                        }
                        
                        VStack {
                            Spacer()
                            
                            SelectPicker(selectIndex: $selectIndexAnimal,
                                         isShowing: $showingAnimal,
                                         elements: animals)
                                .animation(.easeOut)
                                .offset(y: showingAnimal ? geometry.safeAreaInsets.bottom : SelectPicker.viewHeight + geometry.safeAreaInsets.bottom)
                                .frame(height: SelectPicker.viewHeight)
                                .ignoresSafeArea()
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle(Text("SwiftUIBottomPickerSample"))
                .navigationBarHidden(false)
                .navigationBarBackButtonHidden(false)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            // NOTE:
            // When put the animation View in the NavigationView, it gets strange (Picker movement is visible at startup)
            // Display the picker when onAppear is finished.
            // https://stackoverflow.com/questions/66642367/swiftui-animation-inside-navigationview
            DispatchQueue.main.async {
                onAppeared = true
            }
        }
    }
}

struct SelectPicker: View {
    static let viewHeight: CGFloat = 253
    
    @Binding var selectIndex: Int
    @Binding var isShowing: Bool
    var elements: [String]
    
    var body: some View {
        VStack {
            VStack {
                Rectangle().fill(Color(UIColor.systemGray4)).frame(height: 1)
                
                Spacer().frame(height: 10)
                
                Button(action: {
                    self.isShowing = false
                }) {
                    HStack {
                        Spacer()
                        
                        Text("Done")
                            .font(.headline)
                        
                        Spacer().frame(width: 20)
                    }
                }
                
                Spacer().frame(height: 10)
            }
            .background(Color(UIColor.systemGray6))
            
            Picker(selection: $selectIndex, label: Text("")) {
                ForEach(0..<elements.count) { i in
                    Text(elements[i]).tag(i)
                        .font(.title2)
                }
            }
            .background(Color(UIColor.systemGray4))
            .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
