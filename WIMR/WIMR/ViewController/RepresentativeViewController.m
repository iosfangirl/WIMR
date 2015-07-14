//
//  RepresentativeViewController.m
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import "RepresentativeViewController.h"
#import "Member.h"
#import "MemberTableViewCell.h"

@interface RepresentativeViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

@property(nonatomic, weak)IBOutlet UISegmentedControl *segmentControl;
@property(nonatomic, weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet  UISearchBar *searchBar;
@property(nonatomic, strong)NSArray *members;

@end

@implementation RepresentativeViewController

#pragma mark - GET Represenative
-(void)getRepByName:(NSString *)name{
    Member *member = [[Member alloc]init];
    [member getAllRepresentativeByName:name completion:^(NSArray *representatives) {
        self.members = representatives;
        [self.tableView reloadData];
    }];
}


-(void)getRepByState:(NSString *)state{
    Member *member = [[Member alloc]init];
    [member getAllRepresentativeByState:state completion:^(NSArray *representatives) {
        self.members = representatives;
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
    
    static NSString *cellIdentifier = @"CellIdentifierRep";
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
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [self getRepByName:self.searchBar.text];
    }
    else{
        [self getRepByState:self.searchBar.text];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}
@end
