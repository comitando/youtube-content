//
//  DecimalFormatter.swift
//  SDUI
//
//  Created by Julio Junior on 01/03/23.
//

import Foundation

public final class DecimalFormatter {
    
    private var decimalFormatter: NumberFormatter?
    
    public static let shared: DecimalFormatter = DecimalFormatter()
    
    private init() {
        setup(locale: "pt_BR")
    }
    
    private func setup(locale: String) {
        decimalFormatter = NumberFormatter()
        decimalFormatter?.locale = Locale(identifier: locale)
        decimalFormatter?.numberStyle = .currencyAccounting
        decimalFormatter?.generatesDecimalNumbers = true
        decimalFormatter?.maximumFractionDigits = 0
        decimalFormatter?.currencySymbol = ""
    }
    
    public func changeCharactersInRangeFormatter(_ range: NSRange, string: String, currentString: NSString) -> String {
        var newText = currentString.replacingCharacters(in: range, with: string)
        newText = newText.nonnumeric()
        if newText.count < 21 { return replacingOccurrences(currentString: newText)
        } else { return replacingOccurrences(currentString: currentString as String) }
    }
    
    public func currencyFormatterWithoutSymbol(_ range: NSRange, string: String, currentString: NSString, hasFractionDigits: Bool = true) -> String {
        objc_sync_enter(decimalFormatter!)
        var newText = changeCharactersInRangeFormatter(range, string: string, currentString: currentString)
        
        if let doubleValue = decimalStringToDecimalNumberFormatter(newText) {
            newText = doubleToDecimalStringFormatter(doubleValue.doubleValue / ( hasFractionDigits ? 100 : 1 ))
        }
        
        objc_sync_exit(decimalFormatter!)
        return newText
    }
    
    public func doubleToDecimalStringFormatter(_ number: Double, maximumFractionDigits: Int = 2) -> String {
        return doubleToDecimalStringFormatterAndMaximumFractionDigits(number, maximumFractionDigits: maximumFractionDigits)
    }
    
    public func doubleToDecimal(_ number: Double, maximumFractionDigits: Int = 2) -> Decimal {
        let currentString = doubleToDecimalStringFormatterAndMaximumFractionDigits(number, maximumFractionDigits: maximumFractionDigits)
        let decimal = currentString.replacingOccurrences(of: ".", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        return decimalFormatter!.number(from: decimal)?.decimalValue ?? 0
    }
    
    public func doubleToDecimalStringFormatterAndMaximumFractionDigits(_ number: Double, maximumFractionDigits: Int) -> String {
        
        objc_sync_enter(decimalFormatter!)
        decimalFormatter!.generatesDecimalNumbers = maximumFractionDigits > 0
        decimalFormatter!.maximumFractionDigits = maximumFractionDigits
        decimalFormatter!.minimumFractionDigits = maximumFractionDigits
        
        objc_sync_exit(decimalFormatter!)
        
        return decimalFormatter!.string(from: NSNumber(value: number as Double))!
    }
    
    public func decimalStringToDecimalNumberFormatter(_ decimalString: String) -> NSDecimalNumber? {
        let decimal = decimalString.replacingOccurrences(of: ".", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        if let value = decimalFormatter!.number(from: decimal) {
            return NSDecimalNumber(decimal: value.decimalValue)
        }
        
        return nil
    }
    
    public func adding(value: Double, currentString: String) -> String {
        let decimal = currentString.replacingOccurrences(of: ".", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        if let decimalNumber = decimalFormatter!.number(from: decimal) {
            let number = NSDecimalNumber(value: value).adding(NSDecimalNumber(value: decimalNumber.doubleValue))
            if number.doubleValue < 9E12 {
                return doubleToDecimalStringFormatter(number.doubleValue)
            } else {
                return doubleToDecimalStringFormatter(decimalNumber.doubleValue)
            }
        }
        return doubleToDecimalStringFormatter(value)
    }
}

// MARK: - Private method
extension DecimalFormatter {
    private func replacingOccurrences(currentString: String) -> String {
        objc_sync_enter(decimalFormatter!)
        let text = currentString
            .replacingOccurrences(of: decimalFormatter!.currencySymbol!, with: String())
            .replacingOccurrences(of: decimalFormatter!.groupingSeparator!, with: String())
            .replacingOccurrences(of: decimalFormatter!.decimalSeparator!, with: String())
        objc_sync_exit(decimalFormatter!)
        return text
    }
}

extension String {
    func nonnumeric() -> String {
        return self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
    }
}
