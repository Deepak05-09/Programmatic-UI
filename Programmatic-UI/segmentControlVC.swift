//
//  segmentControlVC.swift
//  Programmatic-UI
//
//  Created by deepak-pt6306 on 21/02/23.
//

import UIKit

class segmentControlVC: UIViewController {

    var segment = UISegmentedControl(items: ["one","two","Three"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSC()
    }
    
    func setUpSC(){
        view.addSubview(segment)
        segment.frame = CGRect(x: 40, y: 400, width: 300, height: 30)
        segment.center = view.center
        segment.selectedSegmentIndex = 1
        segment.backgroundColor = .gray
        segment.selectedSegmentTintColor = .green
        segment.setImage(UIImage(systemName: "pencil.and.outline"), forSegmentAt: 0)
        segment.setImage(UIImage(systemName: "pencil.and.outline"), forSegmentAt: 2)
        segment.setEnabled(false, forSegmentAt: 2)
        segment.addTarget(self, action: #selector(changed), for: .valueChanged)
        //segment.setDividerImage(UIImage(systemName: "sun.max"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    @objc func changed(_ sender : UISegmentedControl){
        switch(sender.selectedSegmentIndex){
        case 0 : segment.setEnabled(false, forSegmentAt: 1)
                 segment.setEnabled(true, forSegmentAt: 2)
        case 1 : segment.setEnabled(true, forSegmentAt: 2)
                 segment.setEnabled(true, forSegmentAt: 0)
        case 2 : segment.setEnabled(true, forSegmentAt: 1)
                 segment.setEnabled(false, forSegmentAt: 0)
        default: break
            
        }
    }


}
