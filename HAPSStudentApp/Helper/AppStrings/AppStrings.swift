//
//  AppStrings.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 22/06/23.
//

import Foundation


//App Fonts
struct AppStrings {
    struct SchoolName {
        static let schoolName = "The Rajkumar College"
    }

}

struct ImageType {
    static let pdf = "pdf"
    static let jpeg = "jpeg"
}

struct AppFonts {
    static let Roboto_Bold = "Roboto-Bold"
    static let Roboto_Medium = "Roboto-Medium"
    static let Roboto_Regular = "Roboto-Regular"
}

enum AppStoryboards {
    case main
    case dashboard
    
    var getDescription:String {
        get {
            switch self {
            case .main:
                return "Main"
            case .dashboard:
                return "Dashboard"
            }
        }
    }
}
enum AppViewControllerID {
    case splashVC
    case loginVC
    case dashboardVC
    case navigationVC
    case drawerVC
    case showImgVC
    case newsDetailVC
    //Date :: 29, Dec 2023
    case listAppearvc
    case newsFeedvc
    case studentDashboardvc
    case newsFeedDetailvc
    case likeListvc
    
    var getStoryboard : String {
        get {
            switch self {
            case .splashVC:
                return AppStoryboards.main.getDescription
            case .loginVC:
                return AppStoryboards.main.getDescription
            case .dashboardVC:
                return AppStoryboards.dashboard.getDescription
            case .navigationVC:
                return AppStoryboards.dashboard.getDescription
            case .drawerVC:
                return AppStoryboards.dashboard.getDescription
            case .showImgVC:
                return AppStoryboards.dashboard.getDescription
            case .newsDetailVC:
                return AppStoryboards.dashboard.getDescription
                //Date :: 29, Dec 2023
            case .listAppearvc:
                return AppStoryboards.dashboard.getDescription
            case .newsFeedvc:
                return AppStoryboards.dashboard.getDescription
            case .studentDashboardvc:
                return AppStoryboards.dashboard.getDescription
            case .newsFeedDetailvc:
                return AppStoryboards.dashboard.getDescription
            case .likeListvc:
                return AppStoryboards.dashboard.getDescription
            }
        }
    }
    var getIdentifier : String {
        get {
            switch self {
            case .splashVC:
                return "splashVC"
            case .loginVC:
                return "loginVC"
            case .dashboardVC:
                return "dashboardVC"
            case .navigationVC:
                return "navigationVC"
            case .drawerVC:
                return "drawerVC"
            case .showImgVC:
                return "showImgVC"
            case .newsDetailVC:
                return "newsDetailVC"
                //Date :: 29, Dec 2023
            case .listAppearvc:
                return "listAppearvc"
            case .newsFeedvc:
                return "newsFeedvc"
            case .studentDashboardvc:
                return "studentDashboardvc"
            case .newsFeedDetailvc:
                return "newsFeedDetailvc"
            case .likeListvc:
                return "likeListvc"
            }
        }
    }
}

enum AppSegue {
    case loginSegue
    case dashboardSegue
    case noticeSegue
    case leaveRequestSegue
    case leaveStatusSegue
    case attendanceSegue
    case overallAttendanceSegue
    case monthlyAttendanceSegue
    case presentSegue
    case leaveSegue
    case monthlyAttendanceDetailsSegue
    case assignmentsSegue
    case academicCalenderSegue
    case bookListSegue
    case studentPortfolioSegue
    case sportsDetailSegue
    case showImgSegue
    case activityDetailsSegue
    case appointmentEntrySegue
    case studentInboxSegue
    case studentinboxDetailSegue
    case profileSegue
    case disciplineSegue
    case smileySegue
    case frowneySegue
    case feedbackSuggestionSegue
    case feedbackListSegue
    case schoolCalenderSegue
    case feeLedgerSegue
    case newsSegue
    case newsDetailSegue
    case librarySegue
    case issuedBooksSegue
    case returnedBooksSegue
    case resultSegue
    case switchUserSegue
    case timeTableSegue
    case notificationsListSegue
    case notificationsDetailSegue
    case studentGallerySegue
    case stGalleryDetailSegue
    case studentArtWorkSegue
    case artWorkDetailSegue
    case libBooksSegue
    case homeWorkSegue
    case classGallerySegue
    case classGalleryDetailSegue
    case conversationSegue
    case homeWorkDetailSegue
    case pocketMoneySegue
    case feeDetailSegue
    case reportCardSegue
    case webViewSegue
    case gatePassSegue
    case applyGatePassSegue
    case gatePassStatusSegue
    case studentDashboardSegue
    case newsFeedCellSegue
    case likeListSegue
    case changePswdSegue
    var getDescription:String {
        get {
            switch self {
            case .loginSegue:
                return "loginSegue"
            case .dashboardSegue:
                return "dashboardSegue"
            case .noticeSegue:
                return "noticeSegue"
            case .leaveRequestSegue:
                return "leaveRequestSegue"
            case .leaveStatusSegue:
                return "leaveStatusSegue"
            case .attendanceSegue:
                return "attendanceSegue"
            case .overallAttendanceSegue:
                return "overallAttendanceSegue"
            case .monthlyAttendanceSegue:
                return "monthlyAttendanceSegue"
            case .presentSegue:
                return "presentSegue"
            case .leaveSegue:
                return "leaveSegue"
            case .monthlyAttendanceDetailsSegue:
                return "monthlyAttendanceDetailsSegue"
            case .assignmentsSegue:
                return "assignmentsSegue"
            case .academicCalenderSegue:
                return "academicCalenderSegue"
            case .bookListSegue:
                return "bookListSegue"
            case .studentPortfolioSegue:
                return "studentPortfolioSegue"
            case .sportsDetailSegue:
                return "sportsDetailSegue"
            case .showImgSegue:
                return "showImgSegue"
            case .activityDetailsSegue:
                return "activityDetailsSegue"
            case .appointmentEntrySegue:
                return "appointmentEntrySegue"
            case .studentInboxSegue:
                return "studentInboxSegue"
            case .studentinboxDetailSegue:
                return "inboxDetailSegue"
            case .profileSegue:
                return "profileSegue"
            case .disciplineSegue:
                return "disciplineSegue"
            case .smileySegue:
                return "smileySegue"
            case .frowneySegue:
                return "frowneySegue"
            case .feedbackSuggestionSegue:
                return "feedbackSuggestionSegue"
            case .feedbackListSegue:
                return "feedbackListSegue"
            case .schoolCalenderSegue:
                return "schoolCalenderSegue"
            case .feeLedgerSegue:
                return "feeLedgerSegue"
            case .newsSegue:
                return "newsSegue"
            case .newsDetailSegue:
                return "newsDetailSegue"
            case .librarySegue:
                return "librarySegue"
            case .issuedBooksSegue:
                 return "issuedBooksSegue"
            case .returnedBooksSegue:
                return "returnedBooksSegue"
            case .resultSegue:
                return "resultSegue"
            case .switchUserSegue:
                return "switchUserSegue"
            case .timeTableSegue:
                return "timeTableSegue"
            case .notificationsListSegue:
                return "notificationsListSegue"
            case .notificationsDetailSegue:
                return "notificationsDetailSegue"
            case .studentGallerySegue:
                return "studentGallerySegue"
            case .stGalleryDetailSegue:
                return "stGalleryDetailSegue"
            case .studentArtWorkSegue:
                return "studentArtWorkSegue"
            case .artWorkDetailSegue:
                return "artWorkDetailSegue"
            case .libBooksSegue:
                return "libBooksSegue"
            case .homeWorkSegue:
                return "homeWorkSegue"
            case .classGallerySegue:
                return "classGallerySegue"
            case .classGalleryDetailSegue:
                return "classGalleryDetailSegue"
            case .conversationSegue:
                return "conversationSegue"
            case .homeWorkDetailSegue:
                return "homeWorkDetailSegue"
            case .pocketMoneySegue:
                return "pocketMoneySegue"
            case .feeDetailSegue:
                return "feeDetailSegue"
            case .reportCardSegue:
                return "reportCardSegue"
            case .webViewSegue:
                return "webViewSegue"
            case .gatePassSegue:
                return "gatePassSegue"
            case .applyGatePassSegue:
                return "applyGatePassSegue"
            case .gatePassStatusSegue:
                return "gatePassStatusSegue"
            case .studentDashboardSegue:
                return "studentDashboardSegue"
            case .newsFeedCellSegue:
                return "newsFeedCellSegue"
            case .likeListSegue:
                return "likeListSegue"
            case .changePswdSegue:
                return "changePswdSegue"
            }
            
        }
    }
}


enum AppCVCells{
    case homeCVCell
    case attendanceCVCell
    case overallAttendanceCell
    case timeTableCVCell
    case studentGalleryCell
    case studentGalleryDetailCell
    case pocketMoneyCVCell
    case newsFeedImageCell
    
    var getIdentifier:String {
        get {
            switch self {
            case .homeCVCell:
                return "homeCVCell"
            case .attendanceCVCell:
                return "attendanceCVCell"
            case .overallAttendanceCell:
                return "overallAttendanceCell"
            case .timeTableCVCell:
                return "timeTableCVCell"
            case .studentGalleryCell:
                return "studentGalleryCell"
            case .studentGalleryDetailCell:
                return "studentGalleryDetailCell"
            case .pocketMoneyCVCell:
                return "pocketMoneyCVCell"
            case .newsFeedImageCell:
                return "newsFeedImage"
            }
        }
    }
}

enum AppTblCells {
    case noticeCell
    case homeCell
    case leaveStatusCell
    case monthlyAttendanceCell
    case headerCell
    case absentDetailsCell
    case monthlyAttendanceDetailCell
    case dayAttendanceCell
    case assignmantsCell
    case portfolioCell
    case sportsDetailCell
    case activityDetailCell
    case appointmentEntryCell
    case studentIndexCell
    case studentInboxDetailCell
    case disciplineDetailCell
    case feedbackListCell
    case schoolCalendarCell
    case eventsCell
    case feeLedgerCell
    case newsCell
    case newsDetailCell
    case moreNewsCell
    case issuedBooksCell
    case libraryheaderCell
    case switchUserCell
    case periodsCell
    case notificationsListCell
    case libBookListCell
    case timeTableCell
    case homeWorkCell
    case homeWorkDetailCell
    case pocketMoneyTVCell
    case resultHeaderCell
    case totalResultCell
    case resultCell
    case feedbackChatCell
    case feeDetailCell
    case paymentDetailCell
    case gatePassStatusCell
    case listTblCell
    case academicCalendarCell
    case newsFeedCell
    case newsFeedImgCell
    case likeListCell
    case newsFeedDetailImgCell
    
    var getIdentifier:String {
        get {
            switch self {
            case .noticeCell:
                return "noticeCell"
            case .homeCell:
                return "homeCell"
            case .leaveStatusCell:
                return "leaveStatusCell"
            case .monthlyAttendanceCell:
                return "monthlyAttendanceCell"
            case .absentDetailsCell:
                return "absentDetailsCell"
            case .headerCell:
                return "headerCell"
            case .monthlyAttendanceDetailCell:
                return "monthlyAttendanceDetailCell"
            case .dayAttendanceCell:
                return "dayAttendanceCell"
            case .assignmantsCell:
                return "assignmantsCell"
            case .portfolioCell:
                return "portfolioCell"
            case .sportsDetailCell:
                return "sportsDetailCell"
            case .activityDetailCell:
                return "activityDetailCell"
            case .appointmentEntryCell:
                return "appointmentEntryCell"
            case .studentIndexCell:
                return "studentIndexCell"
            case .studentInboxDetailCell:
                return "studentInboxDetailCell"
            case .disciplineDetailCell:
                return "disciplineDetailCell"
            case .feedbackListCell:
                return "feedbackListCell"
            case .schoolCalendarCell:
                return "schoolCalendarCell"
            case .eventsCell:
                return "eventsCell"
            case .feeLedgerCell:
                return "feeLedgerCell"
            case .newsCell:
                return "newsCell"
            case .newsDetailCell:
                return "newsDetailCell"
            case .moreNewsCell:
                return "moreNewsCell"
            case .issuedBooksCell:
                return "issuedBooksCell"
            case .libraryheaderCell:
                return "libraryheaderCell"
            case .switchUserCell:
                return "switchUserCell"
            case .periodsCell:
                return "periodsCell"
            case .notificationsListCell:
                return "notificationsListCell"
            case .libBookListCell:
                return "libBookListCell"
            case .timeTableCell:
                return "timeTableCell"
            case .homeWorkCell:
                return "homeWorkCell"
            case .homeWorkDetailCell:
                return "homeWorkDetailCell"
            case .pocketMoneyTVCell:
                return "pocketMoneyTVCell"
            case .resultHeaderCell:
                return "resultHeaderCell"
            case .totalResultCell:
                return "totalResultCell"
            case .resultCell:
                return "resultCell"
            case .feedbackChatCell:
                return "feedbackChatCell"
            case .feeDetailCell:
                return "feeDetailCell"
            case .paymentDetailCell:
                return "paymentDetailCell"
            case .gatePassStatusCell:
                return "gatePassStatusCell"
            case .listTblCell:
                return "listTblCell"
            case .academicCalendarCell:
                return "academicCalendarCell"
            case .newsFeedCell:
                return "newsFeedCell"
            case .newsFeedImgCell:
                return "newsFeedImgCell"
            case .likeListCell:
                return "likeListCell"
            case .newsFeedDetailImgCell:
                return "newsFeedDetailImgCell"
            }
        }
    }
}
