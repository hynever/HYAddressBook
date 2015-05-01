//
//  ViewController.m
//  通讯录Demo
//
//  Created by jimubox on 15/4/15.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "ViewController.h"
#import "HYAddressBook.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [HYAddressBookHandle getAllPeopleWithFinishBlock:^(NSArray *allPeople) {
        if (allPeople) {
            for (HYContactModel *model in allPeople) {
                NSLog(@"firstName:%@",model.firstName);
                NSLog(@"lastName:%@",model.lastName);
                NSLog(@"contactID:%ld",model.contactID);
                NSLog(@"phones:%@",model.phones);
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
