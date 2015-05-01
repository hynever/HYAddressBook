//
//  HYAddressBook.h
//
//  Created by huangyong on 15/4/15.
//  Copyright (c) 2015年 huangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

/**
 *  完成获取所有通讯录的block
 */
typedef void(^FinishGetAllPeopleBlock)(NSArray *allPeople);


@interface HYAddressBookHandle : NSObject

/**
 *  获取所有联系人
 */
+(void)getAllPeopleWithFinishBlock:(FinishGetAllPeopleBlock)finishBlock;

@end
