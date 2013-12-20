//
//  NSOperationTestController.h
//  iOSConcurrentTest
//
//  Created by Chen, Duanjin on 12/19/13.
//  Copyright (c) 2013 Microstrategy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ColorLabel.h"
@interface NSOperationTestController : UIViewController

@property(nonatomic,weak)id<TestViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet ColorLabel *SerialLabel1;
@property (weak, nonatomic) IBOutlet ColorLabel *SerialLabel2;
@property (weak, nonatomic) IBOutlet ColorLabel *ConcurrentLabel1;
@property (weak, nonatomic) IBOutlet ColorLabel *ConcurrentLabel2;
@property (weak, nonatomic) IBOutlet UIButton *RunTestButton;
@property (weak, nonatomic) IBOutlet UIButton *CancelButton;

@end
