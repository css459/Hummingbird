//
//  PageViewController.swift
//  Hummingbird
//
//  Created by Nauman Ahmad on 9/25/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit
import Firebase

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let ref =  FIRDatabase.database().reference(withPath: "posts")
    var items: [Humm] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        items.append(Humm(poster: "Test", posterUID: "tst", genre: "Rock", audioFilePath: "sss"))
        items.append(Humm(poster: "Hello", posterUID: "tst", genre: "Rock", audioFilePath: "sss"))
        
//        ref.observe(.value, with: { snapshot in
//            var newItems: [Humm] = []
//            
//            if let posts = snapshot.value as? [String: AnyObject] {
//                for post in posts as [String: AnyObject] {
//                    self.ref.child(post.0).observe(.value, with: { (snap) in
//                        if let hummItem = snap.value as? [String: AnyObject] {
//                            for item in hummItem as [String: AnyObject] {
//                                let newHumm = Humm(posterUID: post.0, key: item.key, snapshot: snap, data: item.value as! [String : AnyObject])
//                                newItems.append(newHumm)
//                            }
//                        }
//                    })
//                }
//            }
//            
//            self.items = newItems
//            self.dataSource = nil
//            self.dataSource = self
//        })
        
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getViewControllerAtIndex(index: NSInteger) -> HomeViewController {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        
        pageContentViewController.name = self.items[index].poster
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: HomeViewController = viewController as! HomeViewController
        var index = pageContent.pageIndex
        
        if (index == NSNotFound) {
            return nil;
        }
        
        index += 1;
        
        if (index == items.count) {
            return nil;
        }
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
}
