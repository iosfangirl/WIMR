//
//  MemberTableViewCell.h
//  WIMR
//
//  Created by Maddy Patel on 7/13/15.
//  Copyright (c) 2015 Maddy Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberTableViewCell : UITableViewCell

@property(nonatomic, strong)IBOutlet UILabel *lblName;
@property(nonatomic, strong)IBOutlet UITextView *txtViewAddress;

@end
