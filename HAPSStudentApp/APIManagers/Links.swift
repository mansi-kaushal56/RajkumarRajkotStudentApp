//
//  Links.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 21/06/23.
//

import Foundation

let Base_Url = "https://www.rkcerp.in/student-app/"
let Report_Card_Url = "https://www.rkcerp.in/admin/admin/haps-report/"

enum End_Points {
    case Api_login
    case Api_Timetable_day
    case Api_circular
    case Api_Applyleave
    case Api_LeaveStatus
    case Api_Overall_Attendance
    case Api_Monthly_Attendance
    case Api_Detail_Attendance
    case Api_Day_Attendance
    case Api_Assignments
    case Api_Student_Sports_Entry
    case APi_Student_Activity_Entry
    case Api_Student_Appointment
    case Api_Student_Inbox
    case Api_Inbox_Detail
    case Api_Get_Profile
    case Api_Count_Discipline
    case Api_Discipline_Detail
    case Api_Feedback_List
    case Api_Events
    case Api_calendar
    case Api_feeleadger
    case Api_FeeDetail
    case Api_News
    case Api_Returned_Books
    case Api_Issued_Books
    case Api_Available_Books
    case Api_View_Marks
    case Api_Switch_User
    case Api_Periods
    case Api_Time_Table
    case Api_Academic_Calendar_list
    case Api_Notifications_Stu
    case Api_Student_Gallery
    case Api_Student_Sub_Gallery
    case Api_Artwork
    case Api_Art_Images
    case Api_Lib_Books
    case Api_Search_Books
    case Api_Student_Class_Gallery
    case Api_Student_Sub_Class_Gallery
    case Api_Days_Master
    case Api_Feedback_Submit
    case Api_Feedbackchat
    case Api_Savefeedback_Chat
    case Api_Homework_List
    case Api_Homework_Detail
    case Api_Pocketledger
    case Api_Switch_User_Login
    case Api_Update_login
    case Api_Books_List
    case Api_Reportcard_App
    //29, Dec 2023 - Apply gate pass module
    case Api_Leave_Reasons
    case Api_Accompanied_With
    case Api_Gate_Pass_Request
    //03, Jan 2024 
    case Api_Gate_Pass_Status
    
    // 28 JUN 2024
    case Api_News_Feed
    case Api_News_Feed_Like
    case Api_News_Feed_Share
    case Api_News_Feed_Like_List
    case Api_News_Feed_Detail
    case Api_Change_Password
    

    var getEndpoints : String {
        get {
            switch self {
            case .Api_login:
                return "login"
            case .Api_Switch_User_Login:
                return "switchuserlogin"
            case .Api_Timetable_day:
                return "Timetable_day"
            case.Api_circular:
                //return "circular"
                return "circularios"
            case .Api_Applyleave:
                return "applyleave"
            case .Api_LeaveStatus:
                return "leavestatus_ios"
            case .Api_Overall_Attendance:
                return "overall_attendance"
            case .Api_Monthly_Attendance:
                return "monthly_attendance"
            case .Api_Detail_Attendance:
                return "detail_attendance"
            case .Api_Day_Attendance:
                return "day_attendance"
            case .Api_Assignments:
                return "assignment"
            case .Api_Student_Sports_Entry:
                return "student_sports_entry"
            case .APi_Student_Activity_Entry:
                return "student_activity_entry"
            case .Api_Student_Appointment:
                return "student_appointment"
            case .Api_Student_Inbox:
                //return "student_inbox"
                return "student_inbox_ios"
            case .Api_Inbox_Detail:
                //return "inboxdetail"
                return "inboxios"
            case .Api_Get_Profile:
                return "get_profile"
            case .Api_Count_Discipline:
                //return "countDiscipline"
                return "countDisciplineios"
            case .Api_Discipline_Detail:
                return "Discipline"
            case .Api_Feedback_Submit:
                return "feedback"
            case .Api_Feedback_List:
                //return "feedbacklist" //Android App API
                return "feedbacklistios"
            case .Api_Savefeedback_Chat:
                return "savefeedbackchat"
            case .Api_Events:
                return "eventsios"
                //return "events" //Android App API
            case .Api_calendar:
                return "calender"
            case .Api_feeleadger:
                return "feeleadger_ios"
            case .Api_FeeDetail:
                return "FeeDetail_ios"
            case .Api_News:
                return "news"
            case .Api_Returned_Books:
                return "returnedbooks"
            case .Api_Issued_Books:
                return "issuedbooks"
            case .Api_Available_Books:
                return ""
            case .Api_View_Marks:
                return "viewmarks"
            case .Api_Switch_User:
                //return "switchuser" // Android API
                return "switchuserios"
            case .Api_Periods:
                return "Periods"
            case .Api_Time_Table:
                return "Timetablee"
            case .Api_Academic_Calendar_list:
                return "calendar"
            case .Api_Notifications_Stu:
                return "notifications-stu"
            case .Api_Student_Gallery:
//                return "student_gallery" // Android API
                return "student_gallery_ios"
            case .Api_Student_Sub_Gallery:
               // return "student_sub_gallery"// Android API
                return "student_sub_gallery_ios"
            case .Api_Artwork:
                //return "artwork"// Android API
                return "artwork_ios"
            case .Api_Art_Images:
                return "artimages_ios"
            case .Api_Lib_Books:
                //return "libbooks" // Android API
                return "libbooksios"
            case .Api_Search_Books:
                //return "searchbooks" //Android API
                return "searchbooksios"
            case .Api_Student_Class_Gallery:
                //return "student_class_gallery" // Android API
                return "student_class_gallery_ios"
            case .Api_Student_Sub_Class_Gallery:
                //return "student_sub_class_gallery" //Android API
                return "student_sub_class_gallery_ios"
            case .Api_Days_Master:
                return "daysmaster"
            case .Api_Feedbackchat:
                return "feedbackchat"
            case .Api_Homework_List:
                return "homework_ios"
            case .Api_Homework_Detail:
                return "homeworkdetail"
            case .Api_Pocketledger:
                return "pocketledger"
            case .Api_Update_login:
                return "updatelogin"
            case .Api_Books_List:
                return "bookslist"
            case .Api_Reportcard_App:
                return "reportcard_app"
            //29, Dec 2023 - Apply gate pass module
            case .Api_Leave_Reasons:
                return "leavereasons"
            case .Api_Accompanied_With:
                return "accompany"
            case .Api_Gate_Pass_Request:
                return "gatepassrequest"
            //03, Jan 2024
            case .Api_Gate_Pass_Status:
                return "gatepassstatus"
                
            case .Api_News_Feed:
                return "newsfeed"
            case .Api_News_Feed_Like:
                return "newsfeedlike"
            case .Api_News_Feed_Share:
                return "newsfeedshare"
            case .Api_News_Feed_Like_List:
                return "newsfeedlikelist"
            case .Api_News_Feed_Detail:
                return "newsfeeddetail"
            case .Api_Change_Password:
                return "changepassword"
            }
        }
    }
}
