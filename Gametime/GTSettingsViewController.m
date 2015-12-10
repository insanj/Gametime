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
#import "CWStatusBarNotification.h"
#import "SDWebImageManager.h"
#import "GTMainViewController.h"

@interface GTSettingsViewController ()

@end

@implementation GTSettingsViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Settings";
    
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBarButtonItemTapped)];
}

#pragma mark - actions

- (void)doneBarButtonItemTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:kGametimeRefreshTeamNotificationName object:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = indexPath.row == 0 ? @"Reset Gametime Data" : @"Reset Image Cache";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CWStatusBarNotification *successNotification = [[CWStatusBarNotification alloc] init];
    successNotification.notificationLabelBackgroundColor = [UIColor colorWithRed:0.182f green:0.613f blue:0.312f alpha:1.00f];
    successNotification.notificationLabelTextColor = [UIColor whiteColor];

    if (indexPath.row == 0) {
        [GTTeamObject deleteAll];
        [GTPlayerObject deleteAll];
        [successNotification displayNotificationWithMessage:@"✓ Reset Gametime Data" forDuration:1.5];
    }
    
    else {
        [[SDWebImageManager sharedManager] cancelAll];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [successNotification displayNotificationWithMessage:@"✓ Reset Image Cache" forDuration:1.5];
        }];
    }
}

@end
