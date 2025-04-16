//
//  ListAppearVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/12/23.
//

import UIKit

class ListAppearVC: UIViewController {
    var type : ScreenType?
    var delegate : SenderVCDelegate?
    var reasonOfLeaveListObj: LeaveReasonsModel?
    var accompanyWithListObj: LeaveReasonsModel?
   
    @IBOutlet var fullScreenView: UIView!
    @IBOutlet weak var listAppearTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
extension ListAppearVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentingViewController!.dismiss(animated: true)
        switch type  {
        case .LeaveReasons:
            self.delegate?.messageData(data: reasonOfLeaveListObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        case .Accompany:
            self.delegate?.messageData(data: accompanyWithListObj?.response?.rest?[indexPath.row] as AnyObject, type: type)
        default:
            print("Unknown type")
            break
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .LeaveReasons:
           return reasonOfLeaveListObj?.response?.rest?.count ?? 0
        case .Accompany:
            return accompanyWithListObj?.response?.rest?.count ?? 0
        default :
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.listTblCell.getIdentifier, for: indexPath) as! ListAppearTableCell
        switch type {
        case .LeaveReasons:
            listCell.listLabel.text = reasonOfLeaveListObj?.response?.rest?[indexPath.row].reason
        case .Accompany:
            listCell.listLabel.text = accompanyWithListObj?.response?.rest?[indexPath.row].name
            
        default:
             return listCell
        }
        return listCell
    }
}

extension ListAppearVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.fullScreenView {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

