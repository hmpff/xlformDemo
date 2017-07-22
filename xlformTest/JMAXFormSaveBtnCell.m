//
//  ARCHIEXFormSaveBtnCell.m
//  ARCHIE
//
//  Created by administrator on 17/7/17.
//  Copyright © 2017年 ARCHIE. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "JMAXFormSaveBtnCell.h"
NSString * const XLFormRowDescriptorTypeSaveBtnCell = @"XLFormRowDescriptorTypeSaveBtnCell";

@interface JMAXFormSaveBtnCell ()
@property(nonatomic,strong) NSString *btnTag;
@end

@implementation JMAXFormSaveBtnCell
+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[JMAXFormSaveBtnCell class] forKey:XLFormRowDescriptorTypeSaveBtnCell];
}

#pragma mark - XLFormDescriptorCell

-(void)configure
{
    [super configure];
    
    __weak typeof (self) weakSelf = self;
    
    //btn
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = [UIColor clearColor];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"btn_green_normal"] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    
    [weakSelf.contentView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.centerX.equalTo(weakSelf.contentView);
        make.width.equalTo(weakSelf.contentView).multipliedBy(0.8);
        make.height.equalTo(weakSelf.contentView).multipliedBy(0.8);
    }];
    
    
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)saveBtnClick{

        [[NSNotificationCenter defaultCenter] postNotificationName:@"updataalterPswNotification" object:self];
   }

-(void)update{
    [super update];
    
    NSDictionary *value = self.rowDescriptor.value;
    NSString *btnTag =  [value objectForKey:@"btnTag"];
    _btnTag = btnTag;
}
+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 50;
}

@end
