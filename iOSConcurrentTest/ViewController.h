//
//  ViewController.h
//  iOSConcurrentTest
//
//  Created by Chen, Duanjin on 12/19/13.
//  Copyright (c) 2013 Microstrategy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TestViewControllerDelegate <NSObject>

- (void)testViewControllerDidClose:(UIViewController*) controller;

@end

@interface ViewController : UIViewController <TestViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *DispatchTestButton;

@property (weak, nonatomic) IBOutlet UIButton *NSOperationTestButton;

@end
