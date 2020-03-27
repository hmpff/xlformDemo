//
//  xlFromViewController.m
//  xlformTest
//
//  Created by administrator on 17/7/21.
//  Copyright © 2017年 JMA. All rights reserved.
//
#define KRATE (kScreenWidth/320.0)
#define NavH 64
#define tabBarH 49
//屏幕尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import <Masonry/Masonry.h>
#import "xlFromViewController.h"
#import "JMAXFormSaveBtnCell.h"
#import "ARCHIEXFormPickerDataCell.h"

@interface xlFromViewController ()

@end

@implementation xlFromViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    // 监听通知
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(saveClick) name:@"updataalterPswNotification" object:nil];
}

- (void)dealloc
{
    
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeForm];
    }
    return self;
}
-(void)setUp{
    __weak typeof (self) weakSelf = self;
    
    [weakSelf.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-tabBarH);
    }];
}

// 初始化表单
- (void)initializeForm{
    NSString *birthday = @"1970-1-01";
    // 表单对象
    XLFormDescriptor *form;
    
    // 表单Section对象
    XLFormSectionDescriptor *section;
    
    // 表单Row对象
    XLFormRowDescriptor *row;
    
    // 初始化form 顺便带个title
    form = [XLFormDescriptor formDescriptorWithTitle:@"XLFORM表单"];
    
    // 第一个Section 没有参数的
    section = [XLFormSectionDescriptor formSection];
    
    //禁止输入
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ItemType" rowType:XLFormRowDescriptorTypeText title:@"禁止输入:"];
    row.required = YES;
    row.disabled = @YES;
    row.value = @"我的天啊";
    // font
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:16] forKey:@"textLabel.font"];
    // font
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:16] forKey:@"textField.font"];
    // alignment
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    
    //密码
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ModuleCode" rowType:XLFormRowDescriptorTypePassword title:@"密码:"];
    row.required = YES;
    // font
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:16] forKey:@"textLabel.font"];
    // font
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:16] forKey:@"textField.font"];
    // alignment
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    
    //字典描述
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ItemDesc" rowType:XLFormRowDescriptorTypeText title:@"字典描述:"];
    row.required = YES;
    // font
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:16] forKey:@"textLabel.font"];
    // font
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:16] forKey:@"textField.font"];
    // alignment
    [row.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    //生日
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"birthday" rowType:XLFormRowDescriptorTypePickerDataCell title:@"生日:"];
    row.disabled = @NO;
    row.value = @{@"data":birthday};
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    //一键操作
    [form addFormSection:section];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"insert" rowType:XLFormRowDescriptorTypeButton title:@"保存"];
    row.action.formSelector = @selector(insertBtnClick);
    [section addFormRow:row];
    
    //自定义保存
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"saveBtn" rowType:XLFormRowDescriptorTypeSaveBtnCell title:@"保存"];
    row.disabled = @NO;
    row.value = @{@"btnTag":@"alterPsw"};
    [section addFormRow:row];

    
    section = [XLFormSectionDescriptor formSection];
    self.form = form;
    
    
}
-(void)saveClick{
    NSDictionary *allDict = [self formValues];
    NSDictionary *birthdayDict = allDict[@"birthday"];
    NSDictionary *dict = [NSDictionary dictionary];
    dict = @{
             @"birthday":birthdayDict[@"data"]
             };
    
}
-(void)insertBtnClick{
    NSLog(@"insertBtnClick---");
}
// 每个cell内部的参数属性更改了就会调用这个方法，我们再次更新的话就会调用cell里面update的方法进行重绘
- (void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue
{
    // 咱们这里统一调用更新
    [super formRowDescriptorValueHasChanged:formRow oldValue:oldValue newValue:newValue];
    [self updateFormRow:formRow];
    
}
#pragma mark- 键盘收起
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
}


@end
