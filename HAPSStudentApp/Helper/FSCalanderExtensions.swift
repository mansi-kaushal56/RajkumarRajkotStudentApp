//
//  FSCalanderExtensions.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 17/07/23.
//

import Foundation
import FSCalendar
import UIKit

extension FSCalendar {
    func customizeCalenderAppearance(calenderType : String) {
        self.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        
        self.appearance.headerTitleFont      = UIFont.init(name: AppFonts.Roboto_Bold, size: 16)
        self.appearance.weekdayFont          = UIFont.init(name: AppFonts.Roboto_Medium, size: 12)
        self.appearance.titleFont            = UIFont.init(name: AppFonts.Roboto_Regular, size: 12)
        
        self.appearance.headerTitleColor     = .black
        self.appearance.weekdayTextColor     = .AppRed
        self.appearance.eventDefaultColor    = UIColor.init(named: "#0098EE")
        self.appearance.selectionColor       = UIColor.init(named: "#0098EE")
//        self.appearance.titleSelectionColor  = Colors.NavTitleColor
        
        if calenderType == "Month" {
            self.appearance.titleTodayColor           = UIColor.init(named: "#FFFFFF")
            self.appearance.todayColor           = UIColor.init(named: "#6C6C6C")
            self.appearance.todaySelectionColor  = UIColor.init(named: "#C7EAF3")
        } else {
//            self.appearance.titleTodayColor           = UIColor.init(hexString: "#000000")
//            self.appearance.todayColor           = UIColor.init(hexString: "#FFFFFF")
//            self.appearance.todaySelectionColor  = UIColor.init(hexString: "#FFFFFF")
            self.appearance.titleTodayColor           = UIColor.init(named: "#000000")
            self.appearance.todayColor           = UIColor.init(named: "#C7EAF3")
            self.appearance.todaySelectionColor  = UIColor.init(named: "#C7EAF3")
        }
        
        self.appearance.headerDateFormat = "MMM yyyy"
        
        self.appearance.headerTitleAlignment = .center
        
        self.appearance.headerMinimumDissolvedAlpha = 0.0
        self.appearance.separators = .interRows
    }
}
