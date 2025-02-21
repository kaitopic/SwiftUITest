//
//  CallAnswerView.swift
//  SwiftUIText
//
//  Created by Ethan on 27/11/2024.
//

import SwiftUI

struct CallAnswerView: View {
    
    let callerName: String
    var onAnswer: () -> Void
    var onDecline: () -> Void
    @State private var isConnecting = false
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack {
           
            Spacer()
           
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(.primary)
                        .frame(width: 105, height: 105)

                    UIImageViewRepresentable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .background(.secondary)
                        .clipShape(Circle())
                }
                
                Text(callerName)
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            HStack(spacing: 100) {
                Button(action: {
                    onDecline()
                }) {
                    Image(systemName: "phone.down.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    .frame(width: 64, height: 64)
                    .background(Color.red)
                    .clipShape(Circle())
                }
                
                Button(action: {
                    if !isConnecting {
                        isConnecting = true
                        onAnswer()
                    }
                }) {
                    if isConnecting {
                        LoadingAnimationView(rotation: $rotation)
                    } else {
                        Image(systemName: "phone.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                }
                .disabled(isConnecting)
                .frame(width: 64, height: 64)
                .background(Color.green)
                .clipShape(Circle())
            }
            
            Spacer()
                .frame(height: 50)
            
        }
        .background(.quaternary)
    }
    
}








struct LoadingAnimationView: View {
    @Binding var rotation: Double
    
    var body: some View {
        Circle()
            .stroke(Color.white.opacity(0.2), style: StrokeStyle(lineWidth: 3, lineCap: .round))
            .frame(width: 36, height: 36)
            .overlay(
                Circle()
                    .trim(from: 0, to: 0.9)
                    .stroke(
                        AngularGradient(gradient: Gradient(colors: [.white, .clear]), center: .center, startAngle: .degrees(0), endAngle: .degrees(300)),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                    )
                    .rotationEffect(.degrees(rotation))
            )
            .onAppear {
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                    rotation += 360
                }
            }
    }
}

struct UIImageViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pain_mask")
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])

        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        // update ui
    }
    
}

#Preview {
    CallAnswerView(callerName: "George") {
        print("接听")
    } onDecline: {
        print("挂断")
    }
}
