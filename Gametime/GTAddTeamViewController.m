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
#import "CompactConstraint.h"

@interface GTAddTeamViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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
    
    _teamNameTextField = [[UITextField alloc] init];
    _teamNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _teamNameTextField.delegate = self;
    _teamNameTextField.placeholder = @"New Team Name";
    
    _teamAbbreviationTextField = [[UITextField alloc] init];
    _teamAbbreviationTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _teamAbbreviationTextField.delegate = self;
    _teamAbbreviationTextField.placeholder = @"New Team Abbreviation";
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
        [GTDefaultsManager addSavedTeam:addTeamObject];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _teamNameTextField) {
        [_teamAbbreviationTextField becomeFirstResponder];
    }
    
    else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 && _teamImage) {
        return 2;
    }
    
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        default:
            return nil;
        case 0:
            return @"Name";
        case 1:
            return @"Abbreviation (Unique)";
        case 2:
            return @"Image";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) { // image button
        if (indexPath.row == 0) {
            static NSString *addImageCellIdentifier = @"AddTeamGametimeAddImageIdentifier";
            UITableViewCell *addImageCell = [tableView dequeueReusableCellWithIdentifier:addImageCellIdentifier];
            if (!addImageCell) {
                addImageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addImageCellIdentifier];
                addImageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            addImageCell.textLabel.text = _teamImage ? @"Change Team Image" : @"Choose Team Image";

            return addImageCell;
        }
        
        else {
            static NSString *imageCellIdentifier = @"AddTeamGametimeImageIdentifier";
            UITableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
            if (!imageCell) {
                imageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCellIdentifier];
                imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            imageCell.imageView.image = _teamImage;
            
            return imageCell;
        }
    }
    
    else if (indexPath.section == 0) {
        static NSString *textFieldNameCellIdentifier = @"AddTeamNameGametimeTextFieldIdentifier";
        UITableViewCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:textFieldNameCellIdentifier];
        if (!textFieldCell) {
            textFieldCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldNameCellIdentifier];
            textFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [textFieldCell.contentView addSubview:_teamNameTextField];
            [textFieldCell.contentView addCompactConstraints:@[@"control.left = super.left + 15",
                                                               @"control.right = super.right - 5",
                                                               @"control.top = super.top + 5",
                                                               @"control.bottom = super.bottom - 5"]
                                                     metrics:nil
                                                        views:@{@"control" : _teamNameTextField}];
        }

        return textFieldCell;
    }
    
    else {
        static NSString *textFieldAbbreviationCellIdentifier = @"AddTeamAbbreviationGametimeTextFieldIdentifier";
        UITableViewCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:textFieldAbbreviationCellIdentifier];
        if (!textFieldCell) {
            textFieldCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldAbbreviationCellIdentifier];
            textFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [textFieldCell.contentView addSubview:_teamAbbreviationTextField];
            [textFieldCell.contentView addCompactConstraints:@[@"control.left = super.left + 15",
                                                               @"control.right = super.right - 5",
                                                               @"control.top = super.top + 5",
                                                               @"control.bottom = super.bottom - 5"]
                                                               metrics:nil
                                                               views:@{@"control" : _teamAbbreviationTextField}];
        }

        return textFieldCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        UIImagePickerController *pickerViewController = [[UIImagePickerController alloc] init];
        pickerViewController.delegate = self;
        pickerViewController.allowsEditing = YES;
        pickerViewController.popoverPresentationController.sourceView = [tableView cellForRowAtIndexPath:indexPath];
        pickerViewController.popoverPresentationController.sourceRect = CGRectMake(tableView.center.x, 35.0, 1.0, 1.0);
        [self presentViewController:pickerViewController animated:YES completion:NULL];
    }
}

#pragma mark - image picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _teamImage = chosenImage;
    [self.tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
