//
//  GTAddTeamViewController.m
//  Gametime
//
//  Created by Julian Weiss on 11/26/15.
//  Copyright © 2015 Julian Weiss. All rights reserved.
//

#import "GTAddTeamViewController.h"
#import "GTTeamObject.h"
#import "GTDefaultsManager.h"

@interface GTAddTeamViewController ()

@property (strong, nonatomic) UITextField *teamNameTextField, *teamAbbreviationTextField;

@property (strong, nonatomic) UIImage *teamImage;

@property (strong, nonatomic) NSArray *teamExistingAbbreviations;

@end

@implementation GTAddTeamViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Team";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBarButtonItemTapped:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveBarButtonItemTapped:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableArray *abbreviations = [NSMutableArray array];
    for (GTTeamObject *team in [GTDefaultsManager savedTeams]) {
        [abbreviations addObject:team.teamAbbreviation];
    }
    
    _teamExistingAbbreviations = abbreviations;
}

#pragma mark - actions

- (void)cancelBarButtonItemTapped:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)saveBarButtonItemTapped:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    if (!_teamNameTextField.text || [_teamNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        UIAlertController *needValidNameAlert = [UIAlertController alertControllerWithTitle:@"Bad Team Name" message:@"Please try using a valid team name and saving again! You are allowed to have duplicate names, but not duplicate abbreviations." preferredStyle:UIAlertControllerStyleAlert];
        needValidNameAlert.popoverPresentationController.barButtonItem = sender;
        [needValidNameAlert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];
        [self presentViewController:needValidNameAlert animated:YES completion:NULL];
    }
    
    else if (!_teamAbbreviationTextField.text || [_teamAbbreviationTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 || [_teamExistingAbbreviations containsObject:_teamAbbreviationTextField.text.uppercaseString]) {
        UIAlertController *needValidAbbreviationAlert = [UIAlertController alertControllerWithTitle:@"Bad Team Abbreviation" message:@"Please try using a different team abbreviation and saving again! You are not allowed to have duplicate abbreviations." preferredStyle:UIAlertControllerStyleAlert];
        needValidAbbreviationAlert.popoverPresentationController.barButtonItem = sender;
        [needValidAbbreviationAlert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:NULL]];
        [self presentViewController:needValidAbbreviationAlert animated:YES completion:NULL];
    }
    
    else {
        GTTeamObject *addTeamObject = [GTTeamObject teamWithName:_teamNameTextField.text abbreviation:_teamAbbreviationTextField.text image:_teamImage];
        [GTDefaultsManager saveTeams:<#(NSArray *)#>]
    }
    
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
