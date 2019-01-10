//
//  AppGuideViewController.swift
//  Travely_iOS
//
//  Created by 신동규 on 1/5/19.
//  Copyright © 2019 신동규. All rights reserved.
//

import UIKit

class AppGuideViewController: UIViewController {
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    var tutorialPageViewController: AppGuidePageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(didChangePageControlValue), for: .valueChanged)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        let titleImageView = UIImageView.init(image: UIImage.init(named: "logoWhite"))
        self.navigationItem.titleView = titleImageView
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? AppGuidePageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    @objc func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension AppGuideViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: AppGuidePageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: AppGuidePageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
