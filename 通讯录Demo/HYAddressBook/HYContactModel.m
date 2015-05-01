//
//  HYContactModel.m
//  通讯录Demo
//
//  Created by jimubox on 15/4/15.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "HYContactModel.h"

@implementation HYContactModel

/**
 *  根据ABRecordRef转换成HYContactModel
 */
+(HYContactModel *)contactModelWithABRecord:(ABRecordRef)record
{
    HYContactModel *model = [[HYContactModel alloc] init];
    if (model) {
        model.contactID = (NSInteger)ABRecordGetRecordID(record);
        model.firstName = [self getValueWithRecord:record Property:kABPersonFirstNameProperty];
        model.lastName = [self getValueWithRecord:record Property:kABPersonLastNameProperty];
        model.middleName = [self getValueWithRecord:record Property:kABPersonMiddleNameProperty];
        model.prefix = [self getValueWithRecord:record Property:kABPersonPrefixProperty];
        model.suffix = [self getValueWithRecord:record Property:kABPersonSuffixProperty];
        model.nickname = [self getValueWithRecord:record Property:kABPersonNicknameProperty];
        model.firstNamePhonetic = [self getValueWithRecord:record Property:kABPersonFirstNamePhoneticProperty];
        model.lastNamePhonetic = [self getValueWithRecord:record Property:kABPersonLastNamePhoneticProperty];
        model.middleNamePhonetic = [self getValueWithRecord:record Property:kABPersonMiddleNamePhoneticProperty];
        model.organization = [self getValueWithRecord:record Property:kABPersonOrganizationProperty];
        model.jobTitle = [self getValueWithRecord:record Property:kABPersonJobTitleProperty];
        model.department = [self getValueWithRecord:record Property:kABPersonDepartmentProperty];
        model.note = [self getValueWithRecord:record Property:kABPersonNoteProperty];
        
        //单独对phones做处理
        ABMultiValueRef phone =  ABRecordCopyValue(record, kABPersonPhoneProperty);
        NSArray* phones = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phone));
        model.phones = phones;
    }
    return model;
}

+(id)getValueWithRecord:(ABRecordRef)record Property:(ABPropertyID)property
{
    return CFBridgingRelease(ABRecordCopyValue(record, property));
}

@end
