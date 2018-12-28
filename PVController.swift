//
//  PVController.swift
//  Atelier
//
//  Created by Fujia Ren on 7/21/18.
//  Copyright © 2018 Fujia Ren. All rights reserved.
//  code concept credited to Paul Tangen https://www.linkedin.com/pulse/using-ios-pageviewcontroller-without-storyboards-paul-tangen
//
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pages: Array<UIViewController>!
    var pageC: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dataSource = self
        self.delegate = self
        let initPage = 0
        let page1 = ViewController()
        let page2 = DetailNavController()
        //let page3 = ViewController3()
        
        pages = Array<UIViewController>()
        pages.append(page1)
        pages.append(page2)
        //self.pages.append(page3)
        setViewControllers([pages[initPage]], direction: .forward, animated: true, completion: nil)
        
        pageC = UIPageControl()
        pageC.frame = CGRect()
        pageC.currentPageIndicatorTintColor = UIColor.black
        pageC.pageIndicatorTintColor = UIColor.lightGray
        pageC.numberOfPages = self.pages.count
        pageC.currentPage = initPage
        
        self.view.addSubview(pageC)
        
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageC.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5),
            pageC.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20),
            pageC.heightAnchor.constraint(equalToConstant: 20),
            pageC.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageC.currentPage = viewControllerIndex
            }
        }
    }
}
