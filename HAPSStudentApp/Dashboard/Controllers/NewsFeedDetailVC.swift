//
//  NewsFeedDetailVC.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 27/06/24.
//

import UIKit
import Kingfisher

class NewsFeedDetailVC: UIViewController {

    @IBOutlet weak var imageTableView: UITableView!
    var detailData: NewsFeedResponse?
    var newsfeedData: NewsFeedListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Newsfeed")
        
        // Do any additional setup after loading the view.
    }
    func processHTMLString(_ htmlString: String) -> NSAttributedString {
        do {
            guard let data = htmlString.data(using: .utf8) else {
                return NSAttributedString()
            }
            
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            // Optionally, you can apply additional styling or modifications here
            
            return attributedString
        } catch {
            print("Error converting HTML string to attributed string: \(error.localizedDescription)")
            return NSAttributedString()
        }
    }
}
extension NewsFeedDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsfeedCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.newsFeedImgCell.getIdentifier, for: indexPath) as! NewsfeedImageTblCell
        
        newsfeedCell.dateLabel.text = detailData?.newsFeedDate ?? ""
        newsfeedCell.descriptionLabel.attributedText = processHTMLString(detailData?.newsDescription ?? "")
        
        newsfeedCell.newsfeedImgInfo = detailData
        
        
        return newsfeedCell
    }
    
    
}
