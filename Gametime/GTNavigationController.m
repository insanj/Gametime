//
//  GTNavigationController.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTNavigationController.h"

@interface GTNavigationController ()

@end

@implementation GTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.182f green:0.613f blue:0.312f alpha:1.00f];
    self.view.tintColor = [UIColor colorWithRed:0.182f green:0.613f blue:0.312f alpha:1.00f];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:18]}];
}

@end
