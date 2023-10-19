//
//  Converter.swift
//  WeConvert
//
//  Created by Jereme Claussen on 10/19/23.
//

import Foundation

struct Converter {
  let measurementType: MeasurementType
  let fromUnit: UnitOfMeasurement
  let value: Double

  init?(measurementType: MeasurementType, fromUnit: UnitOfMeasurement, value: Double) {
    guard measurementType.unitsOfMeasurement.contains(fromUnit) else { return nil }

    self.measurementType = measurementType
    self.fromUnit = fromUnit
    self.value = value
  }

  func convert(to toUnit: UnitOfMeasurement) -> Double {
    guard measurementType.unitsOfMeasurement.contains(toUnit) else { return 0 }

    let measurement = Measurement(value: value, unit: fromUnit.dimension)
    return measurement.converted(to: toUnit.dimension).value
  }
}

enum MeasurementType: String, CaseIterable, Identifiable {
  var id: String { rawValue }

  case temperature
  case distance
  case time
  case volume

  var unitsOfMeasurement: [UnitOfMeasurement] {
    switch self {
    case .temperature:
      return [.celsius, .fahrenheit, .kelvin]
    case .distance:
      return [.meters, .kilometers, .feet, .yards, .miles]
    case .time:
      return [.seconds, .minutes, .hours, .days]
    case .volume:
      return [.milliliters, .liters, .cups, .pints, .gallons]
    }
  }
}

enum UnitOfMeasurement: String, Identifiable {
  var id: String { rawValue }

  case meters
  case kilometers
  case feet
  case yards
  case miles
  case celsius
  case fahrenheit
  case kelvin
  case seconds
  case minutes
  case hours
  case days
  case milliliters
  case liters
  case cups
  case pints
  case gallons

  var dimension: Dimension {
    switch self {

    case .meters:       return UnitLength.meters
    case .kilometers:   return UnitLength.kilometers
    case .feet:         return UnitLength.feet
    case .yards:        return UnitLength.yards
    case .miles:        return UnitLength.miles
    case .celsius:      return UnitTemperature.celsius
    case .fahrenheit:   return UnitTemperature.fahrenheit
    case .kelvin:       return UnitTemperature.kelvin
    case .seconds:      return UnitDuration.seconds
    case .minutes:      return UnitDuration.minutes
    case .hours:        return UnitDuration.hours
    case .days:         return UnitDuration.days
    case .milliliters:  return UnitVolume.milliliters
    case .liters:       return UnitVolume.liters
    case .cups:         return UnitVolume.cups
    case .pints:        return UnitVolume.pints
    case .gallons:      return UnitVolume.gallons
    }
  }
}

extension UnitDuration {
  static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: 86_400))
}
