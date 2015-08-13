//
//  ViewController.h
//  textFieldSearch
//
//  Created by i_feyuwu on 2015/7/30.
//  Copyright (c) 2015年 fet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseQueue.h"
#import "taxIdCheck.h"

@interface ViewController : UIViewController <UITextFieldDelegate>{
    NSMutableArray *dummyArray;
    NSMutableArray *searchArray;
    NSString *searchTextString;
    NSString *nameTextString;
    NSString *companyTextString;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

- (void) setupData;
@end

