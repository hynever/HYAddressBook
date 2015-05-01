//
//  HYContactModel.h
//  通讯录Demo
//
//  Created by jimubox on 15/4/15.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface HYContactModel : NSObject

//联系人唯一id
@property(nonatomic,assign) NSInteger contactID;

//kABPersonPhoneProperty
@property(nonatomic,strong) NSArray *phones;

//kABPersonFirstNameProperty
@property(nonatomic,copy) NSString *firstName;

//kABPersonLastNameProperty
@property(nonatomic,copy) NSString *lastName;

//kABPersonMiddleNameProperty，中间名
@property(nonatomic,copy) NSString *middleName;

//kABPersonPrefixProperty，前缀
@property(nonatomic,copy) NSString *prefix;

//kABPersonSuffixProperty，后缀
@property(nonatomic,copy) NSString *suffix;

//kABPersonNicknameProperty，昵称
@property(nonatomic,copy) NSString *nickname;

//kABPersonFirstNamePhoneticProperty，名字汉语拼音或音标
@property(nonatomic,copy) NSString *firstNamePhonetic;

//kABPersonLastNamePhoneticProperty，姓氏汉语拼音或音标
@property(nonatomic,copy) NSString *lastNamePhonetic;

//q kABPersonMiddleNamePhoneticProperty，中间名汉语拼音或音标
@property(nonatomic,copy) NSString *middleNamePhonetic;

//kABPersonOrganizationProperty，组织名
@property(nonatomic,copy) NSString *organization;

//kABPersonJobTitleProperty，头衔
@property(nonatomic,copy) NSString *jobTitle;

//kABPersonDepartmentProperty，部门
@property(nonatomic,copy) NSString *department;

//kABPersonNoteProperty，备注
@property(nonatomic,copy) NSString *note;

/**
 *  根据ABRecordRef转换成HYContactModel
 */
+(HYContactModel *)contactModelWithABRecord:(ABRecordRef)record;
@end
