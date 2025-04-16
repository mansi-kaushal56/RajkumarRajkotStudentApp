//
//  StringExtensions.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 04/07/23.
//

import Foundation
import UIKit

extension String {
    func hexStringToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //To convert html text to String
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        //Removing space at start and end of html
        let nonNewlines = CharacterSet.whitespacesAndNewlines.inverted
        let startRange = attributedString.string.rangeOfCharacter(from: nonNewlines)
        let endRange = attributedString.string.rangeOfCharacter(from: nonNewlines, options: .backwards)
        guard let startLocation = startRange?.lowerBound, let endLocation = endRange?.lowerBound else {
            self.init(attributedString.string)
            return
        }
        let range = NSRange(startLocation...endLocation, in: attributedString.string)
        self.init(attributedString.attributedSubstring(from: range).string)
        //        self.init(attributedString.string)
    }
    
    func htmlToAttributedText(color: UIColor) -> NSAttributedString? {
        //        print("---------------------------------------------")
        //        print("String")
        //        print(self)
        //        print("UL Tag text")
        //        print(sliceMultipleTimes(from: "<ul", to: "</ul>"))
        //        print("OL text")
        //        print(sliceMultipleTimes(from: "<ol", to: "</ol>"))
        //        print("---------------------------------------------")
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            let formatted = NSMutableAttributedString(attributedString: attributedString)
            
            formatted.addAttributes([
                NSAttributedString.Key.foregroundColor: color,
                .strokeColor: color,
                .strikethroughColor: color,
                .underlineColor: color,
                .backgroundColor: UIColor.clear,
                .strokeWidth: 0.0 as Any
            ], range: NSRange.init(location: 0, length: attributedString.length))
            formatted.removeAttribute(.link, range: NSRange.init(location: 0, length: attributedString.length))
            //Removing space at start and end of html
            let nonNewlines = CharacterSet.whitespacesAndNewlines.inverted
            let startRange = formatted.string.rangeOfCharacter(from: nonNewlines)
            let endRange = formatted.string.rangeOfCharacter(from: nonNewlines, options: .backwards)
            guard let startLocation = startRange?.lowerBound, let endLocation = endRange?.lowerBound else {
                return formatted
            }
            let range = NSRange(startLocation...endLocation, in: formatted.string)
            return formatted.attributedSubstring(from: range)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func htmlToAttributedText(color: UIColor, attributes: [NSAttributedString.Key : Any]?) -> NSAttributedString? {
        //        print("---------------------------------------------")
        //        print("String")
        //        print(self)
        //        print("UL Tag text")
        //        print(sliceMultipleTimes(from: "<ul", to: "</ul>"))
        //        print("OL text")
        //        print(sliceMultipleTimes(from: "<ol", to: "</ol>"))
        //        print("---------------------------------------------")
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            let formatted = NSMutableAttributedString(attributedString: attributedString)
            
            formatted.addAttributes([
                NSAttributedString.Key.foregroundColor: color,
                .strokeColor: color,
                .strikethroughColor: color,
                .underlineColor: color,
                .backgroundColor: UIColor.clear,
                //                .font: font as Any,
                .strokeWidth: 0.0 as Any
            ], range: NSRange.init(location: 0, length: attributedString.length))
            
            formatted.removeAttribute(.link, range: NSRange.init(location: 0, length: attributedString.length))
            if let attributes = attributes {
                formatted.addAttributes(attributes, range: NSRange.init(location: 0, length: attributedString.length))
            }
            //Removing space at start and end of html
            let nonNewlines = CharacterSet.whitespacesAndNewlines.inverted
            let startRange = formatted.string.rangeOfCharacter(from: nonNewlines)
            let endRange = formatted.string.rangeOfCharacter(from: nonNewlines, options: .backwards)
            guard let startLocation = startRange?.lowerBound, let endLocation = endRange?.lowerBound else {
                return formatted
            }
            let range = NSRange(startLocation...endLocation, in: formatted.string)
            return formatted.attributedSubstring(from: range)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height + 5
    }
    
    
    //    func alignBullets() {
    //        print("String---------------------------------------------------")
    //        print(self)
    //        if let lower = self.range(of: "<ul")?.upperBound,
    //           let upper = self.range(of: "</ul>", range: lower..<self.endIndex)?.lowerBound {
    //            print("List----------------------------------------")
    //            let text = self[lower..<upper]   //  "Indonesia"
    //            print(text)
    //            print("------------------------------------------------")
    //        }
    //    }
    func sliceMultipleTimes(from: String, to: String) -> [String] {
        components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
    
    
    func toCustomDate(withFormat format: String = "yyyy-MM-dd hh:mm:ss a")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .none
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        //        dateFormatter.locale = Locale(identifier: "fa-IR")
        //        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
//    func htmlAttributedString() -> NSAttributedString? {
//        let fontName = AppFonts.Roboto_Regular
//        let fontSize = 13
//        let fontColor = "#6C6C6C" // Hex color code
//        let htmlTemplate = """
//        <!doctype html>
//        <html>
//          <head>
//            <style>
//              body {
//                font-family: \(fontName);
//                font-size: \(fontSize)px;
//                color: \(fontColor);
//              }
//            </style>
//          </head>
//          <body>
//            \(self)
//          </body>
//        </html>
//        """
//
//        guard let data = htmlTemplate.data(using: .utf16) else {
//            return nil
//        }
//
//        guard let attributedString = try? NSAttributedString(
//            data: data,
//            options: [.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil
//        ) else {
//            return nil
//        }
//
//        return attributedString
//    }
    func htmlAttributedString() -> NSAttributedString? {
        // Define the font name, size, and color in HTML format
        let fontName = AppFonts.Roboto_Regular
        let fontSize = 13
        let fontColor = "#6C6C6C" // Hex color code

        // Create the HTML template with the provided font, size, and color
        let htmlTemplate = """
        
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                font-family: \(fontName);
                font-size: \(fontSize)px;
                color: \(fontColor);
              }
            </style>
          </head>
          <body>
            \(self) <!-- The string content is inserted here -->
          </body>
        </html>
        """

        // Convert the HTML template to Data
        guard let data = htmlTemplate.data(using: .utf16) else {
            return nil
        }

        // Convert the Data to NSAttributedString using the .html document type
        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.rtfd],
            documentAttributes: nil
        ) else {
            return nil
        }

        // Return the NSAttributedString with custom font, size, and color
        return attributedString
    }
    
    func convertToAttributedFromHTML() -> NSAttributedString? {
        var attributedText: NSAttributedString?
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        if let data = data(using: .unicode, allowLossyConversion: true), let attrStr = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attrStr
        }
        return attributedText
    }
}
