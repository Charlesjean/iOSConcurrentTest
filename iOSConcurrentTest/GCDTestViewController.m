//
//  GCDTestViewController.m
//  iOSConcurrentTest
//
//  Created by Chen, Duanjin on 12/19/13.
//  Copyright (c) 2013 Microstrategy. All rights reserved.
//

#import "GCDTestViewController.h"

@interface GCDTestViewController ()
{
    void (^progress)(ColorLabel*);

}

@end

@implementation GCDTestViewController

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
    //init our block here
    progress = ^(ColorLabel* label){
        for (int i = 0; i < 100; ++i) {
            
            for (int j = 0; j < 10000000; ++j) {
                ;
            }
            label.progress++;
            dispatch_async(dispatch_get_main_queue(), ^{
                [label setNeedsDisplay];
            });
        }
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender
{
    [self.delegate testViewControllerDidClose:self];
}

-(IBAction)run:(id)sender
{
    //Serial Queue
    [self runSeiralTest];
    [self runConcurrentTest];
}

- (void)runSeiralTest
{
    self.SerialLabel1.progress = 0;
    self.SerialLabel1.fillColor = [UIColor greenColor];
    [self.SerialLabel1 setNeedsDisplay];
    
    self.SerialLabel2.progress = 0;
    self.SerialLabel2.fillColor = [UIColor redColor];
    [self.SerialLabel2 setNeedsDisplay];
    
    //create a serial dispatch queue
    dispatch_queue_t queue = dispatch_queue_create("serial Queue", NULL);
    dispatch_async(queue, ^{progress(self.SerialLabel1);});
    dispatch_async(queue, ^{progress(self.SerialLabel2);});
}

- (void)runConcurrentTest
{
    self.ConcurrentLabel1.progress = 0;
    self.ConcurrentLabel1.fillColor = [UIColor yellowColor];
    [self.ConcurrentLabel1 setNeedsDisplay];
    
    self.ConcurrentLabel2.progress = 0;
    self.ConcurrentLabel2.fillColor = [UIColor blueColor];
    [self.ConcurrentLabel2 setNeedsDisplay];
    
    //use global concurrent queue
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{progress(self.ConcurrentLabel1);});
    dispatch_async(queue, ^{progress(self.ConcurrentLabel2);});
}

@end
