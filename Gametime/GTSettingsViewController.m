//
//  GTSettingsViewController.m
//  Gametime
//
//  Created by Julian Weiss on 12/7/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTSettingsViewController.h"
#import "GTTeamObject.h"
#import "GTPlayerObject.h"

@interface GTSettingsViewController ()

@end

@implementation GTSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Settings";
    
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBarButtonItemTapped)];
}

#pragma mark - actions

- (void)doneBarButtonItemTapped {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kGametimeSettingsResetCellIdentifier = @"GametimeSettingsResetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGametimeSettingsResetCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kGametimeSettingsResetCellIdentifier];
        cell.textLabel.textColor = [UIColor colorWithRed:0.864 green:0.148 blue:0.157 alpha:1.00];
        cell.textLabel.text = @"Reset Gametime Data";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [GTTeamObject deleteAll];
    [GTPlayerObject deleteAll];
}

@end
