//
//  ContentView.swift
//  tempСonverter
//
//  Created by Игорь Пачкин on 14/9/24.
//
import SwiftUI

struct ContentView: View {
    
    let temps = ["C", "F", "K"]
    @State private var temp = "C"
    @State private var amountTemp = 0.0
    @FocusState private var amountIsFocused: Bool
    
    // Вычисляемые свойства для конвертации
    var tempInCelsius: Double {
        switch temp {
        case "F":
            return (amountTemp - 32) * 5/9
        case "K":
            return amountTemp - 273.15
        default:
            return amountTemp
        }
    }
    
    var tempInFahrenheit: Double {
        switch temp {
        case "C":
            return tempInCelsius * 9/5 + 32
        case "K":
            return (amountTemp - 273.15) * 9/5 + 32
        default:
            return amountTemp
        }
    }
    
    var tempInKelvin: Double {
        switch temp {
        case "C":
            return tempInCelsius + 273.15
        case "F":
            return (amountTemp - 32) * 5/9 + 273.15
        default:
            return amountTemp
        }
    }
    
    var body: some View {
        Form{
            Section {
                Picker("Temp", selection: $temp){
                    ForEach(temps, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amountTemp, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            }
            
            Section("K"){
                Text("\(tempInKelvin, specifier: "%.2f") K")
            }
            Section("C"){
                Text("\(tempInCelsius, specifier: "%.2f") C")
            }
            Section("F"){
                Text("\(tempInFahrenheit, specifier: "%.2f") F")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
