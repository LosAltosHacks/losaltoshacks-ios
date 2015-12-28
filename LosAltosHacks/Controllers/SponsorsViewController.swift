//
//  SponsorsViewController.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/25/15.
//  Copyright © 2015 Los Altos Hacks. All rights reserved.
//

import UIKit
import SnapKit

class SponsorsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        
        scrollView.snp_makeConstraints { make in
            
            make.height.equalTo(view.snp_height).multipliedBy(0.2)
            make.width.equalTo(view.snp_width)
            
            make.centerX.equalTo(view.snp_centerX)
        }
        
        pageControl.snp_makeConstraints { make in
            make.top.equalTo(scrollView.snp_bottom)
            make.width.equalTo(view.snp_width)
        }
        
        tableContainer.snp_makeConstraints { make in
            
            make.height.equalTo(view.snp_height).multipliedBy(0.8)
            make.width.equalTo(view.snp_width)
            
            make.top.equalTo(pageControl.snp_bottom)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
