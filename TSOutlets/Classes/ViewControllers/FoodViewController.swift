//
//  FoodViewController.swift
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

import UIKit

class FoodViewController: MotherViewController, FoodViewDelegate {
    var foodView: FoodView!

    override func initFirstViewWithParameter(parameter: [NSObject : AnyObject]!) {
        foodView = FoodView(frame: view.bounds);
        foodView.delegate = self;
        view.addSubview(foodView);
        self.foodView.showLoadingView()
        
        let operation: NSBlockOperation = NSBlockOperation(block: {
            self.foodView.foodListArray = ArticleCoreDataHelper.getFoodList()
        })
        
        operation.completionBlock = {NSOperationQueue.mainQueue().addOperationWithBlock({
            self.foodView.createFoodList()
            self.foodView.hideLoadingView()
        })}
        
        addOperationToCoredateOperationWithOperation(operation)
        
        currentView = foodView
        
        NSNotificationCenter.defaultCenter().postNotificationName("shouldRecordLog", object: "Reserve List")
        
//        let mat: FoodAPITool = FoodAPITool()
//        mat.getQueueList()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getReserveList:", name: "getReserveList", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getReserveListFailed", name: "getReserveListFailed", object: nil)
    }
    
// MARK: - Food View Delegate
    
    func foodViewDidTappedFoodButton(parameter: NSDictionary) {
        self .pushViewControllerWithViewControllerType(ViewControllerType.FoodReserve, andParameter: parameter as [NSObject: AnyObject])
    }
    
    func foodViewDidRefresh() {
        let mat: FoodAPITool = FoodAPITool()
        mat.getQueueList()
    }
    
// MARK: - Notification
    
    func getReserveList(noti: NSNotification) {
        self.foodView.foodListArray = (noti.object as! NSArray)
        self.foodView.refreshFoodList()
    }
    
    func getReserveListFailed() {
        self.foodView.refreshFoodList()
    }
}
