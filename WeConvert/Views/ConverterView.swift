//
//  ConverterView.swift
//  WeConvert
//
//  Created by Jereme Claussen on 10/19/23.
//

import Foundation
import SwiftUI

struct ConverterView: View {
  @State private var measurementType: MeasurementType = .distance
  @State private var inputValue: Double = 0.0
  @State private var fromUnit: Dimension = MeasurementType.distance.defaultFromDimension
  @State private var toUnit: Dimension = MeasurementType.distance.defaultToDimension

  private var result: Double {
    guard let converter = Converter(measurementType: measurementType, from: fromUnit, value: inputValue) else { return 0 }

    return converter.convert(to: toUnit)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          Picker("Measurement Type", selection: $measurementType) {
            ForEach(MeasurementType.allCases, id: \.id) {
              Text($0.rawValue.capitalized)
                .tag($0)
            }
          }
          .onChange(of: measurementType) { newValue in
            fromUnit = newValue.defaultFromDimension
            toUnit = newValue.defaultToDimension
          }
        }
        Section("From") {
          Picker("From", selection: $fromUnit) {
            ForEach(measurementType.dimensions) {
              Text($0.symbol)
                .tag($0)
            }
          }
          .pickerStyle(.segmented)
          TextField("Value", value: $inputValue, format: .number)
        }
        Section("To") {
          Picker("To", selection: $toUnit) {
            ForEach(measurementType.dimensions) {
              Text($0.symbol)
                .tag($0)
            }
          }
          .pickerStyle(.segmented)
          Text(result, format: .number)
        }
      }
      .navigationTitle("WeConvert")
    }
  }
}

struct ConverterView_Previews: PreviewProvider {
  static var previews: some View {
    ConverterView()
  }
}
