//
//  Drawing.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 28/11/2022.
//

import SwiftUI
//Here’s a quick recap of all the new things we covered in the last three projects:
/*
 Why @State only works with structs.
 How to use @ObservedObject to work with classes.
 How @Published lets us announce property changes to any SwiftUI views that are watching.
 Presenting and dismissing views using the sheet() modifier and presentationMode.
 Using onDelete(perform:) to enable swipe to delete.
 Adding EditButton to navigation bar items, to let users edit list data more easily.
 Reading and writing data with UserDefaults.
 Archiving and unarchiving data with Codable, including working with data stored in a hierarchy.
 Using the Identifiable protocol to make sure all items can be identified uniquely in our user interface.
 How to use GeometryReader to make content fit the screen.
 Using ScrollView to lay out custom views in a scrollable area.
 Pushing new views onto the navigation stack using NavigationLink.
 Using Swift’s generics system to write methods that work with different kinds of data.
 How to use Swift’s first(where:) method to find the first element in an array that matches a predicate.
 Using layoutPriority() to adjust how much space is allocated to a view.
 Creating custom paths and shapes.
 Creating shapes that can be inset and have their border stroked, using InsettableShape.
 Using CGAffineTransform to create rotations and translations.
 Making creative borders and fills using ImagePaint.
 Enabling Metal for drawing complex views using drawingGroup().
 Modifying blend modes and saturation.
 Animating shapes with animatableData and AnimatablePair.
 
 
 
 Topics:
 1: Path - the outline of a 2D shape
  paths, shapes -Shapes must be able to create a path.
 , strokes, transforms, drawing groups, animating values, and more
2: animatableData. If we want to animate a shape changing, we should add an animatableData property.
3: saturation: We can adjust the color saturation of any view in real-time.
4: stride. The stride() function lets us count through values using any step, such as counting in 3s, 5s, or 10s
 5: strokeBorder. You should use strokeBorder() if you want the stroke to be entirely within your shape
 6: ImagePaint: It has parameters that let us customize how much of the image is used and at what size.
 7: CGAffineTransform. It can be used to store rotation and translation data. It can also store shearing and scaling.
 8: AnimatablePair. It can only animate values that are animatable, which excludes integers.
 */
//Key points
/*
 1: struct(value) vs class(refernce)
 struct = data stored in the variable but using class = data store in RAM. This is where the name comes from: “reference types” are stored as a reference to some memory somewhere, a bit like a signpost. Rather than a variable pointing directly to my house.
 This is also why reference types and value types behave differently when used as constants. If we make a constant instance of a class, what we’ve done is make a constant signpost – we’ve said “this signpost always points to house number 24601, and can’t point to a different house.” However, that doesn’t stop us from remodeling the house: maybe we want to add an extra floor, or change the kitchen, or perhaps even demolish the house entirely and build a new one. If you want those things to be fixed – if you want the actual house itself to be constant – then you need to use constant properties for your class.
 So, we can make a constant signpost (let myHouse = House()) while having variable data (var numberOfFloors = 3). But we can also flip things around: we can make a variable signpost (var myHouse = House()) that has constant data (let numberOfFloors = 3), and that behaves very differently: we can move the signpost around so that it points to different houses, but we can’t remodel the houses themselves.
 
 2: UserDefaults lets us store small amounts of data easily – it’s automatically attached to our app, which means it’s there ready to load as soon as our app launches. While it’s very useful (and you’ll be relying on its heavily!) it does have two drawbacks:
 
 3: We used generics to create a decoding method that is capable of taking any JSON file from an app bundle and loading into a Codable type of our choosing. But – and this is a big but! – we first wrote the method to be non-generic: if you recall, it originally decoded an array of astronauts before being upgraded to load any kind of Codable type.
 
 func makeString() -> any Comparable { //if remove any then below discussion
     "Hello"
 } //This is why generic constraints are so useful: they let us say “this can be any kind of object, as long as…” then provide some restrictions. And – perhaps counterintuitively – adding restrictions often enables more functionality.
 So, the key to using generics well is not to use them at first, and when you do need them to add restrictions so that you get the most functionality you can.
 */



struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}
struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}
struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
}
struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    //.strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}
struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int
    
    //type conversion from int to double.
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column ).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}
//roulette
struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    //Calculating the GCD of two numbers is usually done with Euclid's algorithm,
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        //when it comes to drawing the roulette we need to use Double, so we’re also going to create Double copies of our inputs.
        let divisor = gcd(innerRadius, outerRadius)
            let outerRadius = Double(self.outerRadius)
            let innerRadius = Double(self.innerRadius)
            let distance = Double(self.distance)
            let difference = innerRadius - outerRadius
            let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        

        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }
}
//Challenge
struct Arrow: InsettableShape {
    var insetAmount = 0.0

    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.height - insetAmount))
        
        path.addLine(to: CGPoint(x: rect.midX, y: insetAmount))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.height * 0.30))
        path.move(to: CGPoint(x: rect.midX, y: insetAmount))
        path.addLine(to: CGPoint(x: rect.width - insetAmount, y: rect.height * 0.30))

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct Drawing: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var amount = 0.0
    
    @State private var colorCycle = 0.0
    
    @State private var rows = 6
    @State private var columns = 4
    
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount1 = 1.0
    @State private var hue = 0.6
    
    
    @State private var lineWidth = 1.0
    var body: some View {
        VStack(spacing: 20) {
//            Path { path in
//                path.move(to: CGPoint(x: 200, y: 100))
//                path.addLine(to: CGPoint(x: 100, y: 300))
//                path.addLine(to: CGPoint(x: 300, y: 300))
//                path.addLine(to: CGPoint(x: 200, y: 100))
//                path.closeSubpath()
//            }
            //.fill(.blue)
            //.stroke(.red, lineWidth: 10)
            //.stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            
            
//            Triangle()
//                .stroke(.green, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .frame(width: 100, height: 100)
//            Spacer()
            
            
//            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//                .stroke(.blue, lineWidth: 10)
//                .frame(width: 100, height: 100)
            
            //Circle()
                //.stroke(.red, lineWidth: 20)
                //.strokeBorder(.blue, lineWidth: 10)//all our border is visible, because Swift strokes the inside of the circle rather than centering on the line.
            
//            Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
//                .stroke(.blue, lineWidth: 30)
//                .padding(.horizontal)
                //.frame(width: 200, height: 200)
            
            
            
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                //.stroke(.red, lineWidth: 2)
//                .fill(.red, style: FillStyle(eoFill: true))
//                .frame(width: 300, height: 300)
//
//            Text("Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
            
            
//            Text("hello word!")
//                .frame(width: 300, height: 300)
//                //.border(.red, width: 30)
//                //.background(Image("apollo1"))
//                //.border(Image("apollo1"))
//                //.border(ImagePaint(image: Image("apollo1"), scale: 0.1), width: 30)
//                .border(ImagePaint(image: Image("apollo1"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
//
//            Capsule()
//                .strokeBorder(ImagePaint(image: Image("apollo1"), scale: 0.1), lineWidth: 20)
//                .frame(width: 300, height: 200)
            
            
//            ColorCyclingCircle(amount: colorCycle)
//                .frame(width: 200, height: 200)
//            Slider(value: $colorCycle)
//                .padding(.horizontal)
                
            //blendMode, colorMultiply
            ZStack {
                Image("apollo1")
                Rectangle()
                    .fill(.red)
                    .blendMode(.screen)
                Image("apollo1")
                    .colorMultiply(.white)
                
            }.frame(width: 50, height: 50)//.padding(.top)
            
            
            // blendMode(.screen)
//            VStack {
//                ZStack {
//                    Circle()
//                        //.fill(.red)
//                        .fill(Color(red: 1, green: 0, blue: 0))
//                        .frame(width: 200 * amount)
//                        .offset(x: -50, y: -80)
//                        .blendMode(.screen)
//
//                    Circle()
//                        //.fill(.green)
//                        .fill(Color(red: 0, green: 1, blue: 0))
//                        .frame(width: 200 * amount)
//                        .offset(x: 50, y: -80)
//                        .blendMode(.screen)
//
//                    Circle()
//                        .fill(.blue)
//                        //.fill(Color(red: 0, green: 0, blue: 1)) //If you want to see the full effect of blending red, green, and blue, you should use custom colors like these three:
//                        .frame(width: 200 * amount)
//                        .blendMode(.screen)
//                        //.offset(x: -10, y: 80)
//                }.frame(width: 300, height: 300)
//
//                Slider(value: $amount)
//                    .padding()
//
//            }
//            .frame(maxWidth: .infinity)
//            .background(.darkBackground)

            
                //saturation, blur
//            Image("apollo1")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 300, height: 300)
//                .saturation(amount) //saturation(), which adjusts how much color is used inside a view
//                .blur(radius:(1 - amount) * 20)
//            Slider(value: $amount)
//                .padding()
            
            
            //animatableData, AnimatablePair
//            CheckerBoard(rows: rows, columns: columns)
//                .onTapGesture {
//                    withAnimation(.easeIn(duration: 3)) {
//                        //Not works because, we have Int values, also they are integers. So swift do not animate integers value.
//                        rows = 7
//                        columns = 12
//                    }
//                }
            
            
            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount1)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                //.stroke(.red, lineWidth: 1)
                .frame(width: 300, height: 300)
            Group {
                Text("Inner Radius \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Distance \(Int(distance))")
                Slider(value: $distance)
                    .padding([.horizontal, .bottom])

                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])

                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)

            }
            
//            VStack {
//                Arrow()
//                    .strokeBorder(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
//
//
//                Button("Press Me!") {
//                        withAnimation(.easeOut(duration: 4)) {
//                            lineWidth = Double.random(in: 10...100)
//                        }
//                    }
//            }
            
            
            Spacer()
            
            
        }
        
    }
}

struct ColorsView: View {
    @State private var colorCycle = 0.0
    @State private var locX = 50.0
    @State private var locY = 50.0
    @State private var useGradient = true

    let baseCornerRadius = 25.0

    var body: some View {
        VStack {
            Toggle("Use gradient?", isOn: $useGradient)
                .padding(.horizontal)
            ZStack {
                GeometryReader { geo in
                    let w = geo.size.width
                    let h = geo.size.height
                    let m = min(w,h)
                    let centerX = locX * w / 100
                    let centerY = locY * h / 100
                    VStack {
                        if useGradient {
                            let center = UnitPoint(x: centerX / w, y: centerY / h)
                            RoundedRectangle(cornerRadius: baseCornerRadius)
                                .fill(
                                    RadialGradient(gradient: Gradient(colors: colors(steps: Int(m), amount: colorCycle)), center: center, startRadius: 0, endRadius: m/2))
                        } else {
                            ZStack {
                                ForEach(0..<Int(m), id: \.self) { value in
                                    let v = CGFloat(value)
                                    let cornerRadius = baseCornerRadius * (m - Double(value)) / m
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .size(width: w-(v*w/m), height: h-(v*h/m))
                                        .offset(x: v*(centerX/m), y: v*(centerY/m))
                                        .stroke(color(for: value, amount: colorCycle, steps: Int(m)), lineWidth: 2)

                                }
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .vertical])

            Text("Color cycle")
            Slider(value: $colorCycle)
                .padding([.horizontal])

            Text("centerX")
            Slider(value: $locX, in: 5...95, step: 1)
                .padding([.horizontal])

            Text("centerY")
            Slider(value: $locY, in: 5...95, step: 1)
                .padding([.horizontal])
        }
    }

    func color(for value: Int, amount: Double, steps: Int) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        targetHue = targetHue.truncatingRemainder(dividingBy: 1)

        return Color(hue: targetHue, saturation: 1, brightness: 1)
    }

    func colors(steps: Int, amount: Double) -> [Color] {
        var colors = [Color]()

        for i in 0..<steps {
            colors.append(color(for: i, amount: amount, steps: steps))
        }

        return colors
    }
}


struct Drawing_Previews: PreviewProvider {
    static var previews: some View {
        Drawing()
    }
}
