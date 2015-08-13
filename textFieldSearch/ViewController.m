//
//  ViewController.m
//  textFieldSearch
//
//  Created by i_feyuwu on 2015/7/30.
//  Copyright (c) 2015年 fet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set the selector to the text field in order to change its value when edited
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //here you set up the methods to search array and reloading the tableview
    [self setupData];
    [self updateSearchArray];
    [self.contentTableView reloadData];
}

//setting up the data source for the mutable array
- (void) setupData {
    dummyArray = [[NSMutableArray alloc] init];
    
    NSError *error;
    
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Supplier_list.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:sourcePath];
    if ([database open]) {
        FMResultSet *resultSet = [database executeQuery:@"select * from companyID"];
        
        while ([resultSet next])
        {
            NSString *newCompany = [resultSet stringForColumn:@"vendorName"];
            NSString *newtaxID =[resultSet stringForColumn:@"taxID"];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:newCompany,@"company",newtaxID,@"taxID", nil];
            
            [dummyArray addObject:dic];
        }
    }
    else{
        NSLog(@"DB Error: %@", error);
    }
    [database close];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if( cell == nil ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = [NSString stringWithFormat:@"訪客公司:%@",[[searchArray objectAtIndex:indexPath.row] objectForKey:@"company"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"統一編號:%@",[[searchArray objectAtIndex:indexPath.row] objectForKey:@"taxID"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    companyTextString = [[searchArray valueForKey:@"company"] objectAtIndex:indexPath.row];
    searchTextString = [[searchArray valueForKey:@"taxID"] objectAtIndex:indexPath.row];

    _companyTextField.text = companyTextString;
    _searchTextField.text = searchTextString;
}

-(void)taxIDCheck:(NSString *)idStr{
    int x = [idStr intValue];
    taxIdCheck *check = [taxIdCheck new];

    if ([check taxIdCheck:x]) {
        NSLog(@"統一編號正確");
    }else{
        NSLog(@"統一編號錯誤");
    }
}

-(IBAction)checkBtn:(id)sender{
    [self taxIDCheck:searchTextString];
}

#pragma mark - Search Methods

-(void)textFieldDidChange:(UITextField*)textField
{
    searchTextString = textField.text;
    [self updateSearchArray];
}

//update seach method where the textfield acts as seach bar
-(void)updateSearchArray
{
    if (searchTextString.length != 0) {
        searchArray = [NSMutableArray array];
        for ( NSDictionary* item in dummyArray ) {
            if ([[[item objectForKey:@"taxID"] lowercaseString] rangeOfString:[searchTextString lowercaseString]].location != NSNotFound) {
                [searchArray addObject:item];
            }
        }
    } else {
        searchArray = dummyArray;
    }
    
    [self.contentTableView reloadData];
}

#pragma mark - Table view delegate

- (void)viewDidUnload {
    [self setSearchTextField:nil];
    [self setContentTableView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
