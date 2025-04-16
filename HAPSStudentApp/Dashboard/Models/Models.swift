//
//  Models.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 22/06/23.
//

import Foundation
import ObjectMapper

struct TimetableDateModel : Mappable {
    
    var dayid : String?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) { dayid <- map["dayid"] }
}

struct CircularModel : Mappable {
    var circularArr : [CircularModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { circularArr <- map["response"] }
}

struct CircularModelData : Mappable {
    var sno : Int?
    var circular,enrollno,dated,title,description,date,filetype,file : String?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {

        sno <- map["sno"]
        circular <- map["circular"]
        enrollno <- map["enrollno"]
        dated <- map["dated"]
        title <- map["title"]
        description <- map["description"]
        date <- map["date"]
        filetype <- map["filetype"]
        file <- map["file"]
    }
}

struct LeaveStatusModel : Mappable {
    var leaveStatusArr : [LeaveStatusModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { leaveStatusArr <- map["response"] }
}

struct LeaveStatusModelData : Mappable {
    var dateto,datefrom,reason,status : String?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {

        dateto <- map["dateto"]
        datefrom <- map["datefrom"]
        reason <- map["reason"]
        status <- map["status"]
    }
}

struct OverallAttendanceModel : Mappable {
    var status : Bool?
    var total : String?
    var present : String?
    var absent : String?
    var leave : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        status <- map["status"]
        total <- map["total"]
        present <- map["present"]
        absent <- map["absent"]
        leave <- map["leave"]
    }
}

struct MonthlyAttendanceModel : Mappable {
    var status : Bool?
    var monthlyAttendanceArr : [MonthlyAttendanceModelData]?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {

        status <- map["status"]
        monthlyAttendanceArr <- map["response"]
    }

}

struct MonthlyAttendanceModelData : Mappable {
    var month, total, present, absent, leave : String?

    init?(map: Map) {}
  
    mutating func mapping(map: Map) {
        month <- map["month"]
        total <- map["total"]
        present <- map["present"]
        absent <- map["absent"]
        leave <- map["leave"]
    }
}

struct DetailAttendanceModel : Mappable {
    var detailAtendanceArr : [DetailAtnModelData]?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) { detailAtendanceArr <- map["response"] }
}

struct DetailAtnModelData : Mappable {
    var date, day, attend : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        date <- map["date"]
        day <- map["day"]
        attend <- map["attend"]
    }
}

struct AssignmentsModel : Mappable {
    var assignmentsArr : [AssignmentsModelData]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) { assignmentsArr <- map["response"] }
}

struct AssignmentsModelData : Mappable {
    var id, filetype, imgpath, subject, teacher, dueDate, assignDate, shortname, Description   : String?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
         id <- map["id"]
        filetype <- map["jpg"]
        imgpath <- map["imgpath"]
        subject <- map["subject"]
        teacher <- map["teacher"]
        dueDate <- map["due_date"]
        assignDate <- map["assign_date"]
        shortname <- map["shortname"]
        Description <- map["Description"]
    }
}

struct SportsDetailModel : Mappable {
    var response : [SportsDetailModelData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) { response <- map["response"] }

}

struct SportsDetailModelData : Mappable {
    var adminno, stname, class_name, year, category, attacment, file, sports_name, level, level_id, prize_zone, des, status: String?


    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        adminno <- map["adminno"]
        stname <- map["stname"]
        class_name <- map["class_name"]
        year <- map["Year"]
        category <- map["category"]
        attacment <- map["attacment"]
        file <- map["file"]
        sports_name <- map["sports_name"]
        level <- map["level"]
        level_id <- map["level_id"]
        prize_zone <- map["prize_zone"]
        des <- map["des"]
        status <- map["Status"]
    }
}

struct ActivityDetailsModel : Mappable {
    var activityDetailsArr : [ActivityDetailsModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { activityDetailsArr <- map["response"] }
    
}

struct ActivityDetailsModelData : Mappable {
    var adminno : String?
    var stname : String?
    var class_name : String?
    var year : String?
    var category : String?
    var level : String?
    var level_id : String?
    var activity : String?
    var activity_id : String?
    var prize_zone : String?
    var des : String?
    var status : String?
    var attachment : String?
    var file : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        adminno <- map["adminno"]
        stname <- map["stname"]
        class_name <- map["class_name"]
        year <- map["Year"]
        category <- map["category"]
        level <- map["level"]
        level_id <- map["level_id"]
        activity <- map["activity"]
        activity_id <- map["activity_id"]
        prize_zone <- map["prize_zone"]
        des <- map["des"]
        status <- map["Status"]
        attachment <- map["attachment"]
        file <- map["file"]
    }

}
struct StudentInboxDetailModel : Mappable {
    var studentInboxDetailArr : [StudentInboxDetailModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { studentInboxDetailArr <- map["response"] }

}
struct StudentInboxDetailModelData : Mappable {
    var fileType : String?
    var extraFile : String?
    var file : String?
    var msg : String?
    var status : Bool?
    var desp : String?
    var date : String?
    var school : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        fileType <- map["FileType"]
        extraFile <- map["ExtraFile"]
        file <- map["file"]
        msg <- map["msg"]
        status <- map["status"]
        desp <- map["desp"]
        date <- map["date"]
        school <- map["school"]
    }
}
struct StudentInboxModel : Mappable {
    var studentInboxArr : [StudentInboxModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { studentInboxArr <- map["response"] }
}

struct StudentInboxModelData : Mappable {
    var desp : String?
    var id : String?
    var img : String?
    var date : String?
    var school : String?

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        desp <- map["desp"]
        id <- map["id"]
        img <- map["img"]
        date <- map["date"]
        school <- map["school"]
    }
}
struct StudentProfileModel : Mappable {
    var msg : String?
    var status : Bool?
    var studentId : String?
    var branch_id : String?
    var branch_name : String?
    var enrollNo : String?
    var className : String?
    var sectionName : String?
    var studentImage : String?
    var rollNo : String?
    var studentName : String?
    var dOB : String?
    var gender : String?
    var fatherName : String?
    var motherName : String?
    var permanentAddress : String?
    var phoneNo : String?
    var mobileNo : String?
    var pinNo : String?
    var state_name : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        msg <- map["msg"]
        status <- map["status"]
        studentId <- map["StudentId"]
        branch_id <- map["branch_id"]
        branch_name <- map["branch_name"]
        enrollNo <- map["EnrollNo"]
        className <- map["ClassName"]
        sectionName <- map["SectionName"]
        studentImage <- map["StudentImage"]
        rollNo <- map["RollNo"]
        studentName <- map["StudentName"]
        dOB <- map["DOB"]
        gender <- map["Gender"]
        fatherName <- map["FatherName"]
        motherName <- map["MotherName"]
        permanentAddress <- map["PermanentAddress"]
        phoneNo <- map["PhoneNo"]
        mobileNo <- map["MobileNo"]
        pinNo <- map["PinNo"]
        state_name <- map["state_name"]
    }
}
struct DisciplineCountModel : Mappable {
    var disciplineCountarr : [DisciplineCountModelData]?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        disciplineCountarr <- map["response"]
    }
}

struct DisciplineCountModelData : Mappable {
    var smilecount : Int?
    var frownycount : Int?
    var total : Int?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        smilecount <- map["smilecount"]
        frownycount <- map["Frownycount"]
        total <- map["total"]
    }
}
struct DisciplineDetailModel : Mappable {
    var disciplineDetailArr : [DisciplineDetailModelData]?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        disciplineDetailArr <- map["response"]
    }
}

struct DisciplineDetailModelData : Mappable {
    var parameter : String?
    var id : String?
    var level : String?
    var type : String?
    var created_Date : String?
    var empCode : String?

    init?(map: Map) { 
    }

    mutating func mapping(map: Map) {

        parameter <- map["Parameter"]
        id <- map["id"]
        level <- map["Level"]
        type <- map["Type"]
        created_Date <- map["Created_Date"]
        empCode <- map["EmpCode"]
    }
}

struct FeedbackListModel : Mappable {
    var feedbackListArr : [FeedbackListModelData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        feedbackListArr <- map["response"]
    }
}
struct FeedbackListModelData : Mappable {
    var msg : String?
    var status : Bool?
    var id : String?
    var feedback : String?
    var phone : String?
    var email : String?
    var relation : String?
    var gurdianname : String?
    var date : String?
    var fileType : String?
    var extraFile : String?
    var file : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        msg <- map["msg"]
        status <- map["status"]
        id <- map["id"]
        feedback <- map["feedback"]
        phone <- map["phone"]
        email <- map["email"]
        relation <- map["relation"]
        gurdianname <- map["gurdianname"]
        date <- map["date"]
        fileType <- map["FileType"]
        extraFile <- map["ExtraFile"]
        file <- map["file"]
    }

}
struct SchoolCalendarModel : Mappable {
    var schoolCalendarArr : [SchoolCalenderModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { schoolCalendarArr <- map["response"] }
}

struct SchoolCalenderModelData : Mappable {
    var id : String?
    var holidayName : String?
    var start : String?
    var end : String?
    var type : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        holidayName <- map["HolidayName"]
        start <- map["start"]
        end <- map["end"]
        type <- map["Type"]
    }

}
struct FeeLedgerModel : Mappable {
    var feeLedgerArr : [FeeLedgerModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { feeLedgerArr <- map["response"] }
}

struct FeeLedgerModelData : Mappable {
    var id : String?
    var receiptNo : String?
    var paydate : String?
    var amount : String?
    var pay_mode : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        receiptNo <- map["ReceiptNo"]
        paydate <- map["paydate"]
        amount <- map["amount"]
        pay_mode <- map["pay_mode"]
    }
}
struct FeeDetailModel : Mappable {
    var response : [FeeDetailModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { response <- map["response"] }
}

struct FeeDetailModelData : Mappable {
    var url : String?
    var id : String?
    var receiptNo : String?
    var studentname : String?
    var fathername : String?
    var paydate : String?
    var className : String?
    var rollno : String?
    var month : String?
    var branchAddress : String?
    var branchPhone : String?
    var branchMobile : String?
    var branchWebSite : String?
    var branchEmail : String?
    var enrollNo : String?
    var details : [DetailsModel]?
    var paymentdetails : [PaymentdetailsModel]?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        url <- map["url"]
        id <- map["id"]
        receiptNo <- map["ReceiptNo"]
        studentname <- map["studentname"]
        fathername <- map["fathername"]
        paydate <- map["paydate"]
        className <- map["class"]
        rollno <- map["rollno"]
        month <- map["month"]
        branchAddress <- map["BranchAddress"]
        branchPhone <- map["BranchPhone"]
        branchMobile <- map["BranchMobile"]
        branchWebSite <- map["BranchWebSite"]
        branchEmail <- map["BranchEmail"]
        enrollNo <- map["EnrollNo"]
        details <- map["details"]
        paymentdetails <- map["paymentdetails"]
    }
}

struct DetailsModel : Mappable {
    var particular : String?
    var payableAmount : String?
    var currentAmount : String?
    var outstanding : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        particular <- map["Particular"]
        payableAmount <- map["PayableAmount"]
        currentAmount <- map["CurrentAmount"]
        outstanding <- map["Outstanding"]
    }
}

struct PaymentdetailsModel : Mappable {
    var paymode : String?
    var bankName : String?
    var chequeno : String?
    var chequedate : String?
    var totalPayableAmount : Int?
    var totalPaidAmount : Int?
    var totalOutstanding : Int?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        paymode <- map["paymode"]
        bankName <- map["BankName"]
        chequeno <- map["chequeno"]
        chequedate <- map["chequedate"]
        totalPayableAmount <- map["TotalPayableAmount"]
        totalPaidAmount <- map["TotalPaidAmount"]
        totalOutstanding <- map["TotalOutstanding"]
    }
}

struct NewsModel : Mappable {
    var newsArr : [NewsModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { newsArr <- map["response"] }
}

struct NewsModelData : Mappable {
    var msg : String?
    var status : Bool?
    var id : String?
    var heading : String?
    var description : String?
    var file : String?
    var date : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        msg <- map["msg"]
        status <- map["status"]
        id <- map["id"]
        heading <- map["heading"]
        description <- map["description"]
        file <- map["file"]
        date <- map["date"]
    }
}

struct BooksModel : Mappable {
    var booksModelArr : [BooksModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { booksModelArr <- map["response"] }
}

struct BooksModelData : Mappable {
    var accessno : String?
    var booktitle : String?
    var issuedate : String?
    var returndate : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        accessno <- map["accessno"]
        booktitle <- map["booktitle"]
        issuedate <- map["issuedate"]
        returndate <- map["returndate"]
    }
}

struct ResultModel : Mappable {
    var result : [ResultModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { result <- map["result"] }
}

struct ResultModelData : Mappable {
    var dated : String?
    var head : String?
    var totmax : String?
    var totmm : String?
    var res : [ResData]?
    var classTot : Int?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        dated <- map["dated"]
        head <- map["head"]
        totmax <- map["totmax"]
        totmm <- map["totmm"]
        res <- map["res"]
        classTot <- map["ClassTot"]
    }
}

struct ResData : Mappable {
    var sno : String?
    var subjectName : String?
    var max : String?
    var attendence : String?
    var marks : String?
    var high : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        sno <- map["sno"]
        subjectName <- map["SubjectName"]
        max <- map["max"]
        attendence <- map["Attendence"]
        marks <- map["marks"]
        high <- map["high"]
    }
}
struct StudentAppointmentModel : Mappable {
    var studentAppointmentArr : [StudentAppointmentModelData]?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) { studentAppointmentArr <- map["response"] }
}
struct StudentAppointmentModelData : Mappable {
    var adminno : String?
    var stname : String?
    var class_name : String?
    var year : String?
    var post : String?
    var post_id : String?
    var des : String?
    var status : String?
    var attachment : String?
    var file : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        adminno <- map["adminno"]
        stname <- map["stname"]
        class_name <- map["class_name"]
        year <- map["Year"]
        post <- map["post"]
        post_id <- map["post_id"]
        des <- map["des"]
        status <- map["Status"]
        attachment <- map["attachment"]
        file <- map["file"]
    }
}

struct SwitchUserModel : Mappable {
    var msg : String?
    var status : Bool?
    var switchUserArr : [SwitchUserModelData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        msg <- map["msg"]
        status <- map["status"]
        switchUserArr <- map["response"]
    }

}
struct SwitchUserModelData : Mappable {
    var studentName : String?
    var className : String?
    var sectionName : String?
    var siblingStudentDetailId : String?
    var enrollNo : String?
    var rollNo : String?
    var relation : String?
    var dob : String?
    var studentImage : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        studentName <- map["StudentName"]
        className <- map["ClassName"]
        sectionName <- map["SectionName"]
        siblingStudentDetailId <- map["SiblingStudentDetailId"]
        enrollNo <- map["EnrollNo"]
        rollNo <- map["RollNo"]
        relation <- map["Relation"]
        dob <- map["dob"]
        studentImage <- map["StudentImage"]
    }

}
struct PeriodModel : Mappable {
    var periodArr : [PeriodModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { periodArr <- map["response"] }
}

struct PeriodModelData : Mappable {
    var periodID : String?
    var periodName : String?
    var isBreakPeriod : String?
    var time : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        periodID <- map["PeriodID"]
        periodName <- map["PeriodName"]
        isBreakPeriod <- map["IsBreakPeriod"]
        time <- map["time"]
    }
}

struct TimeTableModel : Mappable {
    var timeTableArr : [TimeTableModelData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) { timeTableArr <- map["response"] }

}

struct TimeTableModelData : Mappable {
    var sub1 : String?
    var day1 : String?
    var teacher1 : String?
    var sub2 : String?
    var day2 : String?
    var teacher2 : String?
    var sub3 : String?
    var day3 : String?
    var teacher3 : String?
    var sub4 : String?
    var day4 : String?
    var teacher4 : String?
    var sub5 : String?
    var day5 : String?
    var teacher5 : String?
    var sub6 : String?
    var day6 : String?
    var teacher6 : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        sub1 <- map["sub1"]
        day1 <- map["Day1"]
        teacher1 <- map["Teacher1"]
        sub2 <- map["sub2"]
        day2 <- map["Day2"]
        teacher2 <- map["Teacher2"]
        sub3 <- map["sub3"]
        day3 <- map["Day3"]
        teacher3 <- map["Teacher3"]
        sub4 <- map["sub4"]
        day4 <- map["Day4"]
        teacher4 <- map["Teacher4"]
        sub5 <- map["sub5"]
        day5 <- map["Day5"]
        teacher5 <- map["Teacher5"]
        sub6 <- map["sub6"]
        day6 <- map["Day6"]
        teacher6 <- map["Teacher6"]
    }
}
struct DayListModel : Mappable {
    var response : [DayListModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { response <- map["response"] }
}

struct DayListModelData : Mappable {
    var daysID : String?
    var daysName : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        daysID <- map["DaysID"]
        daysName <- map["DaysName"]
    }
}

//Academic calander Screen model

struct AcademicCalendarModel: Mappable {
    var status : String?
    var academicCalendarArr : [AcademicCalendarModelData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        status <- map["status"]
        academicCalendarArr <- map["response"]
    }
}
struct AcademicCalendarModelData : Mappable {
    var id : String?
    var description : String?
    var file : String?
    var pic : String?
    var createdDate : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        description <- map["description"]
        file <- map["file"]
        pic <- map["pic"]
        createdDate <- map["createddate"]
    }
}
struct NotificationsListModel: Mappable {
    var notificationsListArr : [NotificationsListModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { notificationsListArr <- map["response"] }

}
struct NotificationsListModelData : Mappable {
    var id : String?
    var messages : String?
    var type : String?
    var view : String?
    var taskid : String?
    var taskname : String?
    var sendby : String?
    var createdate : String?
    var branchId : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        messages <- map["messages"]
        type <- map["type"]
        view <- map["view"]
        taskid <- map["taskid"]
        taskname <- map["taskname"]
        sendby <- map["sendby"]
        createdate <- map["createdate"]
        branchId <- map["BranchId"]
    }
}

struct StudentGalleryModel : Mappable {
    var studentGalleryArr : [StudentGalleryModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { studentGalleryArr <- map["response"] }

}

struct StudentGalleryModelData : Mappable {
    var categery_name : String?
    var count : Int?
    var image : String?
    var image_id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        categery_name <- map["categery_name"]
        count <- map["count"]
        image <- map["image"]
        image_id <- map["image_id"]
    }
}
struct StudentGalleryDetailModel : Mappable {
    var studentGalleryDetailArr : [StudentGalleryDetailModelData]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) { studentGalleryDetailArr <- map["response"] }
}

struct StudentGalleryDetailModelData : Mappable {
    var image_id : String?
    var image_name : String?
    var image_cat : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        image_id <- map["image_id"]
        image_name <- map["image_name"]
        image_cat <- map["image_cat"]
    }
}

struct AvailableBooksListModel : Mappable {
    var availableBooksListArr : [AvailableBooksListModelData]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) { availableBooksListArr <- map["response"] }
}

struct AvailableBooksListModelData : Mappable {
    var accessno : String?
    var book_title : String?
    var autname : String?
    var status : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        accessno <- map["accessno"]
        book_title <- map["book_title"]
        autname <- map["autname"]
        status <- map["Status"]
    }
}

struct FeedbackChatModel : Mappable {
    var name : String?
    var feedback : String?
    var feedbackdate : String?
    var fileType : String?
    var file : String?
    var extraFile : String?
    var msg : String?
    var status : Bool?
    var response : [FeedbackChatModelData]?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        name <- map["name"]
        feedback <- map["feedback"]
        feedbackdate <- map["feedbackdate"]
        fileType <- map["FileType"]
        file <- map["file"]
        extraFile <- map["ExtraFile"]
        msg <- map["msg"]
        status <- map["status"]
        response <- map["response"]
    }
}

struct FeedbackChatModelData : Mappable {
    var id : String?
    var msg : String?
    var date : String?
    var sentby : String?
    var fileType : String?
    var extraFile : String?
    var file : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        msg <- map["msg"]
        date <- map["date"]
        sentby <- map["sentby"]
        fileType <- map["FileType"]
        extraFile <- map["ExtraFile"]
        file <- map["file"]
    }
}

struct HomeWorkListModel : Mappable {
    var response : [HomeWorkListModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { response <- map["response"] }
}

struct HomeWorkListModelData : Mappable {
    var id : String?
    var subject : String?
    var teacher : String?
    var due_date : String?
    var shortname : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        subject <- map["subject"]
        teacher <- map["teacher"]
        due_date <- map["due_date"]
        shortname <- map["shortname"]
    }
}

struct HomeWorkDetailModel : Mappable {
    var response : [HomeWorkDetailModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { response <- map["response"] }
}

struct HomeWorkDetailModelData : Mappable {
    var id : String?
    var subject : String?
    var teacher : String?
    var due_date : String?
    var assigned_date : String?
    var desp : String?
    var fileType : String?
    var extraFile : String?
    var file : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        subject <- map["subject"]
        teacher <- map["teacher"]
        due_date <- map["due_date"]
        assigned_date <- map["assigned_date"]
        desp <- map["desp"]
        fileType <- map["FileType"]
        extraFile <- map["ExtraFile"]
        file <- map["file"]
    }
}

struct PocketMoneyModel : Mappable {
    var msg : String?
    var status : Bool?
    var name : String?
    var enrollNo : String?
    var father : String?
    var className : String?
    var response : [PocketMoneyModelData]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        msg <- map["msg"]
        status <- map["status"]
        name <- map["Name"]
        enrollNo <- map["EnrollNo"]
        father <- map["Father"]
        className <- map["Class"]
        response <- map["response"]
    }
}

struct PocketMoneyModelData : Mappable {
    var date, receipt_no, remarks, trasactionName,dr, cr, bal: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        date <- map["Date"]
        receipt_no <- map["receipt_no"]
        remarks <- map["Remarks"]
        trasactionName <- map["TrasactionName"]
        dr <- map["Dr"]
        cr <- map["Cr"]
        bal <- map["bal"]
    }
}
struct ReportCardModel: Mappable {
    var url : String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) { url <- map["url"] }
}

//MARK: 29, Dec 2023 - This is the two compine Model LeaveReasonsModel , AccompanyModel
struct LeaveReasonsModel : Mappable {
    var response : LeaveReasonsResponse?

    init?(map: Map) {}

    mutating func mapping(map: Map) { response <- map["response"] }
}
struct LeaveReasonsResponse : Mappable {
    var rest : [LeaveReasonsRest]?

    init?(map: Map) {}

    mutating func mapping(map: Map) { rest <- map["rest"] }
}
struct LeaveReasonsRest : Mappable {
    var id : String?
    var reason : String?
    var name : String? // AccompanyModel

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        id <- map["id"]
        reason <- map["reason"]
        name <- map["name"] //AccompanyModel
    }
}
//Vijay 03 Jan 2024 - Make the GatePassStatus model
struct GatePassStatusModel : Mappable {
    var response : GatePassStatusResponse?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) { response <- map["response"] }
}
struct GatePassStatusResponse : Mappable {
    var rest : [GatePassStatusRest]?

    init?(map: Map) {}
    mutating func mapping(map: Map) { rest <- map["rest"] }
}

struct GatePassStatusRest : Mappable {
    var regId, dateFrom, dateTo, reason, accompany, status : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {

        regId <- map["regId"]
        dateFrom <- map["dateFrom"]
        dateTo <- map["dateTo"]
        reason <- map["reason"]
        accompany <- map["accompany"]
        status <- map["Status"]
    }
}
//Vijay End ------

//MARK: 27 JUN 2024 Newsfeed Api Model

struct NewsFeedListModel : Mappable {
    var response : [NewsFeedResponse]?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) { response <- map["response"] }
}
struct NewsFeedResponse : Mappable {
    var id, newsFeedDate, newsDescription, totalImages, totalLikes, totalComments, totalShare, like, image1, image2, image3, image4   : String?

    init?(map: Map) {}
    mutating func mapping(map: Map) {
        id <- map["id"]
        newsFeedDate <- map["newsFeedDate"]
        newsDescription <- map["newsDescription"]
        totalImages <- map["totalImages"]
        totalLikes <- map["totalLikes"]
        totalComments <- map["totalComments"]
        totalShare <- map["totalShare"]
        like <- map["like"]
        image1 <- map["image1"]
        image2 <- map["image2"]
        image3 <- map["image3"]
        image4 <- map["image4"]
        
    }
}
//MARK: 28 JUN 2024 Like List Api Model

struct LikeListModel : Mappable {
    var response : [LikeListResponse]?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) { response <- map["response"] }
}
struct LikeListResponse : Mappable {
    var EntrollNo, StudentName, ClassName, SectionName, StudentImage  : String?

    init?(map: Map) {}
    mutating func mapping(map: Map) {
        EntrollNo <- map["EntrollNo"]
        StudentName <- map["StudentName"]
        ClassName <- map["ClassName"]
        SectionName <- map["SectionName"]
        StudentImage <- map["StudentImage"]
    }
}
