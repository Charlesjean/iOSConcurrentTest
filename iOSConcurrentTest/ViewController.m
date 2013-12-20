//
//  ViewController.m
//  iOSConcurrentTest
//
//  Created by Chen, Duanjin on 12/19/13.
//  Copyright (c) 2013 Microstrategy. All rights reserved.
//

#import "ViewController.h"
#import "GCDTestViewController.h"
#import "NSOperationTestController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDispatchTest
{
    
}

- (void)loadNsoperationQueueTest
{
    
}

//delegate methods
- (void)testViewControllerDidClose:(UIViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isEqual:self.DispatchTestButton]) {
        GCDTestViewController* gcdController = segue.destinationViewController;
        gcdController.delegate = self;
    }
    else{
        NSOperationTestController* operationTestController = segue.destinationViewController;
        operationTestController.delegate = self;
    }
}
@end
