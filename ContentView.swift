//
//  ContentView.swift
//  spaceStuff
//
//  Created by Ryan Saelens on 11/30/19.
//  Copyright © 2019 Ryan Saelens. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //image/name array
    @State private var spaceImages = ["a Black Hole", "Earth", "Earth's moon", "Jupiter", "Mars", "Mercury", "Neptune", "Saturn", "The Sun", "Titan", "Uranus", "Venus"].shuffled()
    
    @State private var correct = Int.random(in: 0...2)
    @State private var score = 0
    @State private var alertTitle = ""
    
    //pop-up alert status
    @State private var showingAlert = false
    @State private var winAlert = false
    @State private var exploreAlert = false
    //@State private var neededTaps = 6
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Spacer()
            
                
                Spacer(minLength: 30.00)
                
                
                //loop code that displays images from array
                ForEach((0...2), id: \.self) { number in
                    Image(self.spaceImages[number]).resizable()
                        .frame(width: 180, height: 180.0)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 0.5))
                        .shadow(radius: 33)
                        .aspectRatio(contentMode: .fit)
                     
                    //tap code
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                    self.itemTapped(number)
                                
                    })

                    
                }
            }

            //here is the top navigation view code
                .navigationBarTitle(Text("spaceStuff"))
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .padding(.top, 70)
                .lineLimit(nil)
                
                .navigationBarItems(trailing:
                    Button(action: explore) {
                        
                        Text("Explore")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            
                        //message that pops up when user taps on 'EXPLORE' Button
                        .alert(isPresented: $exploreAlert) {
                                Alert(title: Text("\(alertTitle)"), message: Text("Im looking for ") + Text(spaceImages[correct]), dismissButton: .default(Text("Okay")))
                                }
                        
                    }
                )
                    
                .padding()
                
                
                
                //message that pops up after user taps on image
                 .alert(isPresented: $showingAlert) {
                    Alert(title: Text("\(alertTitle)"), message: Text("Your score is " + "\(score)"), dismissButton: .default(Text("Continue Exploring!")))
                }
                
            //background image (cosmos)
            .background(
                Image("universe")
                    .resizable()
                    .frame(width: 1030, height: 1150.0)

                    .scaledToFill())
                    .edgesIgnoringSafeArea([.top])

        }
            
        //game over alert message when user score equals 6
         .alert(isPresented: $winAlert) {
            Alert(title: Text("Game Over"), message: Text("Your score is " + "\(score)"), dismissButton: .destructive(Text("Done")))
        }
        
    }
       
    
    // explore button function
    func explore() {
        
        showingAlert = false
        exploreAlert = true
        alertTitle = "Let's Explore!"
        self.askQuestion()
        return

    }
    //tap function
    func itemTapped(_ tap: Int) {
           
       
        if tap == correct && score < 6 {
            //the user is correct
            score += 1
            alertTitle = "Great Job!"
            
        }
        
        if tap != correct {
            score -= 1
            alertTitle = "Wrong. Try Again!"
        }
        
        showingAlert = true
        
        if score == 6 {
            winAlert = true
            showingAlert = false
            exploreAlert = false
            return
        }
        if score > 6 {
            winAlert = false
            showingAlert = false
            exploreAlert = false
            return
        }
    }
    
    //new question function
    func askQuestion() {
        
        spaceImages.shuffle()
        correct = Int.random(in: 0...2)
        return
        
    }
    
}





#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
