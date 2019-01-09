//
//  FAQViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/10/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit
import ExpandableCell

class FAQViewController: UIViewController {

    let faqTitle = ["상가에 마음 놓고 짐을 보관할 수 있을까요?","짐의 크기에는 제한이 있나요?","보관이 안되는 물건도 있나요?","서비스를 이용할 수 있는 상가가 몇 개 없어요","예약한 보관을 시간을 지키지 않아도 상관 없나요?","사정이 생겨 짐을 못 찾아가는 경우가 생기면 어떻게 해요?","예약한 본인이 아닌, 다른 사람이 짐을 보관하거나 찾아갈 수 있나요?","핸드폰을 분실한 경우 짐을 찾을 수 있나요?"]
    
    @IBOutlet weak var faqExpandableTableView: ExpandableTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faqExpandableTableView!.expandableDelegate = self
        faqExpandableTableView!.animation = .automatic
        faqExpandableTableView!.tableFooterView = UIView()
        faqExpandableTableView!.register(UINib(nibName: "FAQTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQTitleTableViewCell")
        faqExpandableTableView!.register(UINib(nibName: "FAQContentsTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQContentsTableViewCell")
        
    }
    


}
extension FAQViewController: ExpandableDelegate
{
    
    //상위 셀
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "FAQTitleTableViewCell") as! FAQTitleTableViewCell
        cell.faqTitleLabel.text = faqTitle[indexPath.row]
       
        return cell
    }
    
    
    //하위 셀
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "FAQContentsTableViewCell") as! FAQContentsTableViewCell
        cell.faqContentsTextView.text = "안녕"
        return [cell]
       
    }
    
    //하위 셀 사이즈
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        
        return [50]
    }
    
    //섹션 개수
    func numberOfSections(in tableView: ExpandableTableView) -> Int {
        return 1
    }
    
    //하위 셀 개수
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
       
        return faqTitle.count
    }
    
    //하위 셀 selection event
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
        
    }
    
    // 섹션 이름 설정
    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForHeaderInSection section: Int) -> String? {
      
        return ""
    }
    
    //섹션 헤더 크기
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //섹션 상위 셀 크기
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func expandableTableView(_ expandableTableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
    }
}
