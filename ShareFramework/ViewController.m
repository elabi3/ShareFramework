//
//  ViewController.m
//  ShareFramework
//
//  Created by elabi3 on 03/07/13.
//  Copyright (c) 2013 elabi3. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Examples
    [[ShareOpen getInstance] openChromeURLFromString:@"www.google.com"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
