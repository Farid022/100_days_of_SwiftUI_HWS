//
//  Practice.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 28/01/2023.
//

import SwiftUI
//1. How layout works in SwiftUI.
/*
 3 steps: The parent proposes a size, the child chooses its own size, and the parent positions it.
 How layout works in SwiftUI. It icludes The following 3 steps:
 A parent view proposes a size for its child.
 Based on that information, the child then chooses its own size and the parent must respect that choice.
 The parent then positions the child in its coordinate space.
 
 If we put this into the three-step layout system, we end up with a conversation a bit like this:

 SwiftUI: “Hey, ContentView, you have the whole screen to yourself – how much of it do you need?” (Parent view proposes a size)
 ContentView: “I don’t care; I’m layout neutral. Let me ask my child: hey, background, you have the whole screen to yourself – how much of it do you need?” (Parent view proposes a size)
 Background: “I also don’t care; I’m layout neutral too. Let me ask my child: hey, text, you can have the whole screen to yourself – how much of it do you need?” (Parent view proposes a size)
 Text: “Well, I have the letters ‘Hello, World’ in the default font, so I need exactly X pixels width by Y pixels height. I don’t need the whole screen, just that.” (Child chooses its size.)
 Background: “Got it. Hey, ContentView: I need X by Y pixels, please.”
 ContentView: “Right on. Hey, SwiftUI: I need X by Y pixels.”
 SwiftUI: “Nice. Well, that leaves lots of space, so I’m going to put you at your size in the center.” (Parent positions the child in its coordinate space.)
 So, when we say Text("Hello, World!").background(.red), the text view becomes a child of its background. SwiftUI effectively works its way from bottom to top when it comes to a view and its modifiers.
 
 
 
 Text("Hello, World!") //background's child. text chooses exact size as the words in it.
     .padding(20)
     .background(.red)
 
 So, it’s more like this:
 SwiftUI: You can have the whole screen, how much of it do you need, ContentView?
 ContentView: You can have the whole screen, how much of it do you need, background?
 Background: You can have the whole screen, how much of it do you need, padding?
 Padding: You can have the whole screen minus 20 points on each side, how much of it do you need, text?
 Text: I need X by Y.
 Padding: I need X by Y plus 20 points on each side.
 Background: I need X by Y plus 20 points on each side.
 ContentView: I need X by Y plus 20 points on each side.
 SwiftUI: OK; I’ll center you.
 Note: applying modifiers creates new views rather than just modifying existing views in-place.
 */
//2. Alignment and alignment guides.

//SwiftUI ask Practive, you have full screen, how much do you need.
struct Practice: View { //i don't care, let me ask my child view. i am layout neutral.
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/) //background's child. text chooses exact size as the words in it.
//            .padding(20)
//            .background(.red)//I don't care too, I am layout neutral.
        
        
        VStack {
            //Alignment and alignment guides
            HStack(alignment: .lastTextBaseline) { //align the text based on the last word
                Text("Live")
                        .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }
            
            VStack(alignment: .leading) {
                Text("Hello World!") //it is at leading.
                    .alignmentGuide(.leading) { viewdiamention in
                        viewdiamention[.trailing]
                    }
                Text("A littile phoney.")//want to make it at trailling.
                
                //another example.
                ForEach(0..<10, id: \.self) { item in
                    Text("Number \(item)")
                        .alignmentGuide(.leading) { di in
                            Double(item) * -10
                        }
                }
                
            }
            .background(.red)
            .frame(width: 100, height: 100)
            .background(.green)
            
            
            //How to create a custom alignment guide
            HStack(alignment: .midAccountAndName) {
                VStack {
                    Text("@FaridG022")
                        .font(.title3).bold()
                        .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    
                    Image("bean")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
                
                VStack {
                    Text("Farid Khan")
                    
                    Text("Jemmy Tech")
                        .font(.largeTitle)
                        .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] } //That will make sure they are vertically aligned regardless of what comes before or after
                }
            }
            .background(.gray)
            .foregroundColor(.white)
            
            
            //Absolute positioning for SwiftUI views
            Text("Absolute Positioning")
                .background(.purple)
                .position(x: 100, y: 100)
                //.background(.yellow)
            //1. When we use text, position, then background the position will take up all available space so it can position its text correctly, then the background will use that size for itself.
            //2. When we use text, background, then position, the background will use the text size for its size, then the position will take up all available space and place the background in the correct location.
            
            Text("Offset")
                .background(.blue)
                .offset(x: 30, y: 20)
                //.background(.green)//This means when we apply background() afterwards it uses the original position of the text, not its offset.
            
            GeometryReader { geo in
                Text("Geomatery Reader")
                    .frame(height: geo.size.height * 0.9)
                    .background(.tint)
            }
        }
        
       
    }
}
//alignment.
/*
 When I say “custom type” you might be thinking of a struct, but it’s actually a good idea to implement this as an enum instead as I’ll explain shortly. The AlignmentID protocol has only one requirement, which is that the conforming type must provide a static defaultValue(in:) method that accepts a ViewDimensions object and returns a CGFloat specifying how a view should be aligned if it doesn’t have an alignmentGuide() modifier. You’ll be given the existing ViewDimensions object for the view, so you can either pick one of those for your default or use a hard-coded value.
 */
extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}


//simple geomatery reader.
struct GeomateryReader: View {
    var body: some View {
        VStack {
            GeometryReader { geo in //geo contains the proposed size.
                Text("Geomatery Reader")
                    .frame(width: geo.size.width * 0.9)//use GeometryReader to make a text view have 90% of all available width regardless of its content:
                    //.frame(height: geo.size.height * 0.9)
                    .background(.red)
            }
            .background(.green)
            
            //You’ll see “Some More text” gets pushed right to the bottom of the screen, because the GeometryReader takes up all remaining space
            Text("Some more text")
                .font(.largeTitle)
            
            Text("Some more text")
                .font(.largeTitle)
            Text("Some more text")
                .font(.largeTitle)
            
            
        }
    }
}

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView_GeoM()
    }
}

//reading the frame of a view using geomateryReader.
/*
 When it comes to reading the frame of a view, GeometryProxy provides a frame(in:) method rather than simple properties. This is because the concept of a “frame” includes X and Y coordinates, which don’t make any sense in isolation – do you want the view’s absolute X and Y coordinates, or their X and Y coordinates compared to their parent?

 SwiftUI calls these options coordinate spaces, and those two in particular are called the global space (measuring our view’s frame relative to the whole screen), and the local space (measuring our view’s frame relative to its parent). We can also create custom coordinate spaces by attaching the coordinateSpace() modifier to a view – any children of that can then read its frame relative to that coordinate space.
 
 To demonstrate how coordinate spaces work, we could create some example views in various stacks, attach a custom coordinate space to the outermost view, then add an onTapGesture to one of the views inside it so it can print out the frame globally, locally, and using the custom coordinate space.
 */
struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct MainGeo_View: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}
//Expaination:
/*
 The output you get when that code runs depends on the device you’re using, but here’s what I got:

 Global center: 189.83 x 430.60
 Custom center: 189.83 x 383.60
 Local center: 152.17 x 350.96
 Those sizes are mostly different, so hopefully you can see the full range of how these frame work:

 A global center X of 189 means that the center of the geometry reader is 189 points from the left edge of the screen.
 A global center Y of 430 means the center of the text view is 430 points from the top edge of the screen. This isn’t dead in the center of the screen because there is more safe area at the top than the bottom.
 A custom center X of 189 means the center of the text view is 189 points from the left edge of whichever view owns the “Custom” coordinate space, which in our case is OuterView because we attach it in ContentView. This number matches the global position because OuterView runs edge to edge horizontally.
 A custom center Y of 383 means the center of the text view is 383 points from the top edge of OuterView. This value is smaller than the global center Y because OuterView doesn’t extend into the safe area.
 A local center X of 152 means the center of the text view is 152 points from the left edge of its direct container, which in this case is the GeometryReader.
 A local center Y of 350 means the center of the text view is 350 points from the top edge of its direct container, which again is the GeometryReader.
 
 Note: Which coordinate space you want to use depends on what question you want to answer:

 Want to know where this view is on the screen? Use the global space.
 Want to know where this view is relative to its parent? Use the local space.
 What to know where this view is relative to some other view? Use a custom space.
 */


//ScrollView effects using GeometryReader

struct ScrollView_GeoM: View {
    let colors: [Color] = [.red, .green, .blue, .black, .orange, .purple, .pink]
    var body: some View {
        ScrollView {
            ForEach(0..<30, id: \.self) { num in
                GeometryReader { geo in
                    Text("Number #\(num)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .background(colors[num % 7])
                        .rotation3DEffect(.degrees(geo.frame(in: .global).minY / 5), axis: (x: 0, y: 1, z: 0))
//it’s also problematic because the views only reach their natural orientation when they are at the very top.
                }
                .frame(height: 40)
            }
        }
    }
}


//Challenges.
//1. Make views near the top of the scroll view fade out to 0 opacity – I would suggest starting at about 200 points from the top.
//2. Make views adjust their scale depending on their vertical position, with views near the bottom being large and views near the top being small. I would suggest going no smaller than 50% of the regular size.
//3. For a real challenge make the views change color as you scroll. For the best effect, you should create colors using the Color(hue:saturation:brightness:) initializer, feeding in varying values for the hue.
//Each of those will require a little trial and error from you to find values that work well. Regardless, you should use max() to handle the scaling so that views don’t go smaller than half their size, and use min() with the hue so that hue values don’t go beyond 1.0.

struct ScrollView_GeoM_e2: View {
    let colors: [Color] = [.red, .green, .blue, .black, .orange, .purple, .pink]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<30, id: \.self) { num in
                    GeometryReader { geo in
                        Text("Number #\(num)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            //.background(colors[num % 7])
                            .background(Color(hue: Double(num) / 50, saturation: 1, brightness: 1))//chal 3
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(Double(geo.frame(in: .global).maxY) / 400)//challenge 1.
                            .scaleEffect(geo.frame(in: .global).maxY / fullView.size.height)//cha 2
                        
                    }
                    .frame(height: 50)
                }
            }
        }
    }
}


//spining rows.
struct ScrollView_GeoM_e3: View {
    let colors: [Color] = [.red, .green, .blue, .black, .orange, .purple, .pink]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<10, id: \.self) { card in
                    GeometryReader { geo in //a reader for every one number
                        Text("My Card \(card)")
                            .font(.largeTitle)
                            .padding()
                            .background(.white)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)
                            .onTapGesture {
                                print(geo.frame(in: .global).minX)
                            }
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}
