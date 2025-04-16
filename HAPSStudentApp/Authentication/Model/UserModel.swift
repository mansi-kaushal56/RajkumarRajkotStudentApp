//
//  UserModel.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 22/06/23.
//

import Foundation
import ObjectMapper

struct UserModel : Mappable {
    
    var sessionName : String?
    var session_id : String?
    var branch_id : String?
    var branch_name : String?
    var studentId : String?
    var enrollNo : String?
    var class_id : String?
    var className : String?
    var section_id : String?
    var sectionName : String?
    var studentstatus : String?
    var feeStartMonthId : String?
    var studentTypeId : String?
    var email : String?
    var studentImage : String?
    var lastUpdatedOn : String?
    var userId : String?
    var primaryNoBelongsTo : String?
    var loginId : String?
    var createdDate : String?
    var studentName : String?
    var dOB : String?
    var gender : String?
    var fatherName : String?
    var motherName : String?
    var permanentAddress : String?
    var phoneNo : String?
    var mobileNo : String?
    var correspondenceAddress : String?
    var cityId : String?
    var categoryId : String?
    var religionID : String?
    var motherTongueId : String?
    var nationalityID : String?
    var motherAnnualIncome : String?
    var pinNo : String?
    var stateId : String?
    var correspondanceStateId : String?
    var correspondancePinNo : String?
    var permanentDistict : String?
    var admissionClass : String?
    var fDOB : String?
    var mDOB : String?
    var studentDetailId : String?

    
    init?(map: Map) {}
        init() {
        }
    mutating func mapping(map: Map) {
        sessionName <- map["SessionName"]
        session_id <- map["session_id"]
        branch_id <- map["branch_id"]
        branch_name <- map["branch_name"]
        studentId <- map["StudentId"]
        enrollNo <- map["EnrollNo"]
        class_id <- map["class_id"]
        className <- map["ClassName"]
        section_id <- map["section_id"]
        sectionName <- map["SectionName"]
        studentstatus <- map["Studentstatus"]
        feeStartMonthId <- map["FeeStartMonthId"]
        studentTypeId <- map["StudentTypeId"]
        email <- map["Email"]
        studentImage <- map["StudentImage"]
        lastUpdatedOn <- map["LastUpdatedOn"]
        userId <- map["UserId"]
        primaryNoBelongsTo <- map["PrimaryNoBelongsTo"]
        loginId <- map["LoginId"]
        createdDate <- map["CreatedDate"]
        studentName <- map["StudentName"]
        dOB <- map["DOB"]
        gender <- map["Gender"]
        fatherName <- map["FatherName"]
        motherName <- map["MotherName"]
        permanentAddress <- map["PermanentAddress"]
        phoneNo <- map["PhoneNo"]
        mobileNo <- map["MobileNo"]
        correspondenceAddress <- map["CorrespondenceAddress"]
        cityId <- map["CityId"]
        categoryId <- map["CategoryId"]
        religionID <- map["ReligionID"]
        motherTongueId <- map["MotherTongueId"]
        nationalityID <- map["NationalityID"]
        motherAnnualIncome <- map["MotherAnnualIncome"]
        pinNo <- map["PinNo"]
        stateId <- map["StateId"]
        correspondanceStateId <- map["CorrespondanceStateId"]
        correspondancePinNo <- map["CorrespondancePinNo"]
        permanentDistict <- map["PermanentDistict"]
        admissionClass <- map["AdmissionClass"]
        fDOB <- map["FDOB"]
        mDOB <- map["MDOB"]
        studentDetailId <- map["StudentDetailId"]
    }
}


//struct SwitchUserLoginModel : Mappable {
//    var msg : String?
//    var status : Bool?
//    var response : [SwitchUserLoginModelData]?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//        msg <- map["msg"]
//        status <- map["status"]
//        response <- map["response"]
//    }
//
//}
//struct SwitchUserLoginModelData : Mappable {
//    var session_id : String?
//    var branch_id : String?
//    var branch_name : String?
//    var studentId : String?
//    var enrollNo : String?
//    var class_id : String?
//    var className : String?
//    var section_id : String?
//    var sectionName : String?
//    var studentstatus : String?
//    var feeStartMonthId : String?
//    var studentTypeId : String?
//    var email : String?
//    var studentImage : String?
//    var lastUpdatedOn : String?
//    var userId : String?
//    var primaryNoBelongsTo : String?
//    var loginId : String?
//    var createdDate : String?
//    var studentName : String?
//    var dOB : String?
//    var gender : String?
//    var fatherName : String?
//    var motherName : String?
//    var permanentAddress : String?
//    var phoneNo : String?
//    var mobileNo : String?
//    var correspondenceAddress : String?
//    var cityId : String?
//    var categoryId : String?
//    var religionID : String?
//    var motherTongueId : String?
//    var nationalityID : String?
//    var motherAnnualIncome : String?
//    var pinNo : String?
//    var stateId : String?
//    var correspondanceStateId : String?
//    var correspondancePinNo : String?
//    var permanentDistict : String?
//    var admissionClass : String?
//    var fDOB : String?
//    var mDOB : String?
//    var studentDetailId : String?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//        session_id <- map["session_id"]
//        branch_id <- map["branch_id"]
//        branch_name <- map["branch_name"]
//        studentId <- map["StudentId"]
//        enrollNo <- map["EnrollNo"]
//        class_id <- map["class_id"]
//        className <- map["ClassName"]
//        section_id <- map["section_id"]
//        sectionName <- map["SectionName"]
//        studentstatus <- map["Studentstatus"]
//        feeStartMonthId <- map["FeeStartMonthId"]
//        studentTypeId <- map["StudentTypeId"]
//        email <- map["Email"]
//        studentImage <- map["StudentImage"]
//        lastUpdatedOn <- map["LastUpdatedOn"]
//        userId <- map["UserId"]
//        primaryNoBelongsTo <- map["PrimaryNoBelongsTo"]
//        loginId <- map["LoginId"]
//        createdDate <- map["CreatedDate"]
//        studentName <- map["StudentName"]
//        dOB <- map["DOB"]
//        gender <- map["Gender"]
//        fatherName <- map["FatherName"]
//        motherName <- map["MotherName"]
//        permanentAddress <- map["PermanentAddress"]
//        phoneNo <- map["PhoneNo"]
//        mobileNo <- map["MobileNo"]
//        correspondenceAddress <- map["CorrespondenceAddress"]
//        cityId <- map["CityId"]
//        categoryId <- map["CategoryId"]
//        religionID <- map["ReligionID"]
//        motherTongueId <- map["MotherTongueId"]
//        nationalityID <- map["NationalityID"]
//        motherAnnualIncome <- map["MotherAnnualIncome"]
//        pinNo <- map["PinNo"]
//        stateId <- map["StateId"]
//        correspondanceStateId <- map["CorrespondanceStateId"]
//        correspondancePinNo <- map["CorrespondancePinNo"]
//        permanentDistict <- map["PermanentDistict"]
//        admissionClass <- map["AdmissionClass"]
//        fDOB <- map["FDOB"]
//        mDOB <- map["MDOB"]
//        studentDetailId <- map["StudentDetailId"]
//    }
//
//}
