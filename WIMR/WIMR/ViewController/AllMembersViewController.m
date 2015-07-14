//
//  ViewController.m
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import "AllMembersViewController.h"
#import "Member.h"
#import "MemberTableViewCell.h"

@interface AllMembersViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

@property(nonatomic, weak)IBOutlet UITableView *tableView;
@property(nonatomic, weak)IBOutlet  UISearchBar *searchBar;
@property(nonatomic, strong)NSArray *members;

@end

@implementation AllMembersViewController

#pragma mark - ViewLifeCycle
- (void)viewDidLoad {
    
    //Make default call using random zipcode.
    [self getAllMembers:@"31023"];
    
    //Add done button to number keypad.
    [self addToolbarToKeyboard];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark GET Members
-(void)getAllMembers:(NSString *)zipcode{
    Member *member = [[Member alloc]init];
    [member getAllMember:zipcode completion:^(NSArray *members) {
        self.members = members;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table View Data source and delegates
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentifierAll";
    MemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Member *member = [self.members objectAtIndex:[indexPath row]];
    cell.lblName.text = member.name;
    cell.txtViewAddress.text = [NSString stringWithFormat:@"%@\n%@\n%@",member.office,member.state,member.phone];
    return cell;
}

#pragma mark - SearchBar Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self getAllMembers:self.searchBar.text];
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([searchBar.text length] >= 5) {
        return NO;
    }
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Keyboard
-(void)addToolbarToKeyboard{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.searchBar.inputAccessoryView = keyboardDoneButtonView;
}

#pragma mark - Private method
-(void)doneClicked:(id)sender{
    [self.searchBar resignFirstResponder];
    [self getAllMembers:self.searchBar.text];
}

@end
