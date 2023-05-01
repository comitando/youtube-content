import UIKit

extension String {
    
    func getAttributedString(with highlights: [(text: String,
                                                attributes: [NSAttributedString.Key: Any])]? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attributedString.length)
        )
        
        if let highlights {
            highlights.forEach { item in
                attributedString.addAttributes(item.attributes,
                                               range: NSString(string: self).range(of: item.text))
            }
        }
        
        return attributedString
    }
}
