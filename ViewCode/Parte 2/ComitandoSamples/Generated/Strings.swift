// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  /// Chip M2 Pro da Apple com CPU de 10 núcleos, GPU de 16 núcleos e Neural Engine de 16 núcleos
  internal static let bullet1 = Strings.tr("Localizable", "bullet1", fallback: "Chip M2 Pro da Apple com CPU de 10 núcleos, GPU de 16 núcleos e Neural Engine de 16 núcleos")
  /// Memória unificada de 16 GB
  internal static let bullet2 = Strings.tr("Localizable", "bullet2", fallback: "Memória unificada de 16 GB")
  /// SSD de 512 GB
  internal static let bullet3 = Strings.tr("Localizable", "bullet3", fallback: "SSD de 512 GB")
  /// Adaptador de energia USB-C de 67W
  internal static let bullet4 = Strings.tr("Localizable", "bullet4", fallback: "Adaptador de energia USB-C de 67W")
  /// Tela Liquid Retina XDR de 14 polegadas²
  internal static let bullet5 = Strings.tr("Localizable", "bullet5", fallback: "Tela Liquid Retina XDR de 14 polegadas²")
  /// comprar agora
  internal static let buttonBuy = Strings.tr("Localizable", "buttonBuy", fallback: "comprar agora")
  /// simulador de descontos
  internal static let buttonSimulateDiscount = Strings.tr("Localizable", "buttonSimulateDiscount", fallback: "simulador de descontos")
  /// O MacBook Pro de 14 polegadas com chips M2 Pro e M2 Max eleva a potência e a velocidade a um novo patamar, mesmo quando não está ligado na tomada. Com tela Liquid Retina XDR impressionante, um montão de conexões e bateria para o dia todo, é o notebook profissional que você pode levar para qualquer lugar.
  internal static let description = Strings.tr("Localizable", "description", fallback: "O MacBook Pro de 14 polegadas com chips M2 Pro e M2 Max eleva a potência e a velocidade a um novo patamar, mesmo quando não está ligado na tomada. Com tela Liquid Retina XDR impressionante, um montão de conexões e bateria para o dia todo, é o notebook profissional que você pode levar para qualquer lugar.")
  /// ou 10x de R$ 2.314,88 sem juros
  internal static let installmentsMessage = Strings.tr("Localizable", "installmentsMessage", fallback: "ou 10x de R$ 2.314,88 sem juros")
  /// Notebook MacBookPro 14", Chip M2 Pro da Apple com CPU de 10núcleos e GPU de 16 núcleos, 16GB, 512GB SSD - Cinza-espacial
  internal static let name = Strings.tr("Localizable", "name", fallback: "Notebook MacBookPro 14\", Chip M2 Pro da Apple com CPU de 10núcleos e GPU de 16 núcleos, 16GB, 512GB SSD - Cinza-espacial")
  /// MacBookPro 14" M2 Pro
  internal static let navigationTitle = Strings.tr("Localizable", "navigationTitle", fallback: "MacBookPro 14\" M2 Pro")
  /// (10%% de desconto)
  internal static let pixHighlight = Strings.tr("Localizable", "pixHighlight", fallback: "(10%% de desconto)")
  /// no PIX (10%% de desconto)
  internal static let pixMessage = Strings.tr("Localizable", "pixMessage", fallback: "no PIX (10%% de desconto)")
  /// R$ 20.833,94
  internal static let pixPrice = Strings.tr("Localizable", "pixPrice", fallback: "R$ 20.833,94")
  /// R$ 23.148,82
  internal static let price = Strings.tr("Localizable", "price", fallback: "R$ 23.148,82")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
