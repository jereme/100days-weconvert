//
//  Converter.swift
//  WeConvert
//
//  Created by Jereme Claussen on 10/19/23.
//

import Foundation

struct Converter {
  let measurementType: MeasurementType
  let fromDimension: Dimension
  let value: Double

  init?(measurementType: MeasurementType, from fromDimension: Dimension, value: Double) {
    guard measurementType.dimensions.contains(fromDimension) else { return nil }

    self.measurementType = measurementType
    self.fromDimension = fromDimension
    self.value = value
  }

  func convert(to toDimension: Dimension) -> Double {
    guard measurementType.dimensions.contains(toDimension) else { return 0 }

    let measurement = Measurement(value: value, unit: fromDimension)
    return measurement.converted(to: toDimension).value
  }
}

enum MeasurementType: String, CaseIterable, Identifiable {
  var id: String { rawValue }

  case temperature
  case distance
  case time
  case volume

  var dimensions: [Dimension] {
    switch self {
    case .temperature:
      return [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    case .distance:
      return [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    case .time:
      return [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours, UnitDuration.days]
    case .volume:
      return [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
    }
  }

  var defaultFromDimension: Dimension {
    switch self {
    case .temperature:
      return UnitTemperature.fahrenheit
    case .distance:
      return UnitLength.miles
    case .time:
      return UnitDuration.seconds
    case .volume:
      return UnitVolume.milliliters
    }
  }

  var defaultToDimension: Dimension {
    switch self {
    case .temperature:
      return UnitTemperature.celsius
    case .distance:
      return UnitLength.kilometers
    case .time:
      return UnitDuration.days
    case .volume:
      return UnitVolume.cups
    }
  }
}

extension Dimension: Identifiable {
  public var id: String { symbol }
}

extension UnitDuration {
  static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: 86_400))
}
