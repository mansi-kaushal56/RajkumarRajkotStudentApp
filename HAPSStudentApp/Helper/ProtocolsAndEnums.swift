//
//  ProtocolsAndEnums.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 15/07/23.
//

import Foundation

enum ScreenType {
    case StudentGallery,ArtWorkGallery,StudentGalleryDetail,ArtWorkDetail,ClassGallery,ClassGalleryDetail,BooksList,AcademicCalendar, LeaveReasons, Accompany, NewsFeed, Dashboard
}
//Date :: 29, Dec 2023
protocol SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?)
}
