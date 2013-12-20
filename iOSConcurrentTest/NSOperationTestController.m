//
//  NSOperationTestController.m
//  iOSConcurrentTest
//
//  Created by Chen, Duanjin on 12/19/13.
//  Copyright (c) 2013 Microstrategy. All rights reserved.
//

#import "NSOperationTestController.h"
#import "ColorLabel.h"

@interface NSOperationTestController ()
{
    NSOperationQueue* serialQueue;
    NSOperationQueue* concurrentQueue;
    
}

@end

@implementation NSOperationTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	serialQueue = [[NSOperationQueue alloc] init];
    [serialQueue setMaxConcurrentOperationCount:1];
    concurrentQueue = [[NSOperationQueue alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender
{
    [serialQueue cancelAllOperations];
    [concurrentQueue cancelAllOperations];
    [self.delegate testViewControllerDidClose:self];
}

- (IBAction)RunTest:(id)sender
{
    [self runSerialTest];
    [self runConcurrentTest];
}

- (void)progressView:(ColorLabel*)label
{
    NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];

    for (int i = 0; i < 100; ++i) {
        
        for (int j = 0; j < 10000000; ++j) {
            ;
        }
        NSInvocationOperation* upateOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(updateView:) object:label];
        label.progress++;
        [mainQueue addOperation:upateOperation];
    }
}

- (void)updateView:(ColorLabel*)label
{
    [label setNeedsDisplay];
}

- (void)runSerialTest
{
    if([serialQueue operationCount] > 0)
        return;
    self.SerialLabel1.progress = 0;
    self.SerialLabel1.fillColor = [UIColor greenColor];
    self.SerialLabel2.progress = 0;
    self.SerialLabel2.fillColor = [UIColor redColor];
    [self.SerialLabel1 setNeedsDisplay];
    [self.SerialLabel2 setNeedsDisplay];
    
    NSInvocationOperation* operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(progressView:) object:self.SerialLabel1];
    
    NSInvocationOperation* operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(progressView:) object:self.SerialLabel2];
    [operation2 addDependency:operation];
    [serialQueue addOperation:operation];
    [serialQueue addOperation:operation2];
    
}

- (void)runConcurrentTest
{
    if ([concurrentQueue operationCount] > 0) {// if operation is already in queue, return
        return;
    }
    self.ConcurrentLabel1.progress = 0;
    self.ConcurrentLabel1.fillColor = [UIColor yellowColor];
    self.ConcurrentLabel2.progress = 0;
    self.ConcurrentLabel2.fillColor = [UIColor blueColor];
    [self.ConcurrentLabel1 setNeedsDisplay];
    [self.ConcurrentLabel2 setNeedsDisplay];
    
    NSInvocationOperation* operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(progressView:) object:self.ConcurrentLabel1];
    NSInvocationOperation* operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(progressView:) object:self.ConcurrentLabel2];
    [concurrentQueue addOperation:operation];
    [concurrentQueue addOperation:operation2];
}

- (IBAction)CancelTest:(id)sender
{
    [serialQueue cancelAllOperations];
    [concurrentQueue cancelAllOperations];
}
@end
