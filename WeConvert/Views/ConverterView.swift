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
  @State private var fromUnitOfMeasurement: UnitOfMeasurement?
  @State private var toUnitOfMeasurement: UnitOfMeasurement?

  private var result: Double {
    guard
      let fromUnit = fromUnitOfMeasurement,
      let toUnit = toUnitOfMeasurement,
      let converter = Converter(measurementType: measurementType, fromUnit: fromUnit, value: inputValue)
    else { return 0 }

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
        }
        Section("From") {
          Picker("From", selection: $fromUnitOfMeasurement) {
            ForEach(measurementType.unitsOfMeasurement) {
              Text($0.rawValue.capitalized)
                .tag(Optional($0))
            }
          }
          .pickerStyle(.segmented)
          TextField("Value", value: $inputValue, format: .number)
        }
        Section("To") {
          Picker("To", selection: $toUnitOfMeasurement) {
            ForEach(measurementType.unitsOfMeasurement) {
              Text($0.rawValue.capitalized)
                .tag(Optional($0))
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
