//
//  HYAddressBook.m
//
//  Created by huangyong on 15/4/15.
//  Copyright (c) 2015年 huangyong. All rights reserved.
//

#import "HYAddressBookHandle.h"
#import "HYContactModel.h"

/**
 *  获取授权的block
 */
typedef void(^AuthorizationResult)(BOOL accessGranted);

@implementation HYAddressBookHandle

/**
 *  获取授权
 */
+(BOOL)getAuthorizationWithBlock:(AuthorizationResult)result
{
    CFErrorRef *errorRef = NULL;
    __block BOOL accessGranted = NO;
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, errorRef);
    //创建一个信号量
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
        accessGranted = granted;
        //发送信号量
        dispatch_semaphore_signal(sema);
    });
    //等待信号量
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    if (result) {
        result(accessGranted);
    }
    return accessGranted;
}

/**
 *  获取所有联系人
 */
+(void)getAllPeopleWithFinishBlock:(FinishGetAllPeopleBlock)finishBlock
{
    __block NSMutableArray *allPeople = nil;
    ABAuthorizationStatus authrizationStatus = ABAddressBookGetAuthorizationStatus();
    switch (authrizationStatus) {
            //1.如果授权成功
        case kABAuthorizationStatusAuthorized:
        {
            //先初始化allPeople
            allPeople = [NSMutableArray array];
            
            //直接获取用户信息
            CFErrorRef *error = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
            if (!error) {
                NSArray *allRecordPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
                NSInteger recordCount = allRecordPeople.count;
                for (NSInteger index = 0; index < recordCount; ++index) {
                    ABRecordRef record = (__bridge ABRecordRef)allRecordPeople[index];
                    HYContactModel *model = [HYContactModel contactModelWithABRecord:record];
                    [allPeople addObject:model];
                }
            }
        }
            break;
            
            //2.如果授权失败
        case kABAuthorizationStatusDenied:
            //设置->隐私->通讯录中开启授权
            break;
            
            //3.如果还没有授权
        case kABAuthorizationStatusNotDetermined:
            //跳转到授权界面
            [self getAuthorizationWithBlock:^(BOOL accessGranted) {
                if (accessGranted) {
                    //如果获取成功，获取用户信息
                    [self getAllPeopleWithFinishBlock:^(NSArray *blockAllPeople) {
                        allPeople = [NSMutableArray arrayWithArray:blockAllPeople];
                    }];
                }
            }];
            break;
        default:
            NSAssert(false, @"通讯录授权错误!");
            break;
    }
    if (finishBlock) {
        finishBlock(allPeople);
    }
}


@end
