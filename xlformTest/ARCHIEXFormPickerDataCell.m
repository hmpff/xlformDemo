
#define KRATE (kScreenWidth/320.0)
#define NavH 64
#define tabBarH 49
//屏幕尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#import "ARCHIEXFormPickerDataCell.h"
#import "UIView+XLFormAdditions.h"
#import <Masonry/Masonry.h>
#import "NSObject+XLFormAdditions.h"
#import "WSDatePickerView.h"


NSString * const XLFormRowDescriptorTypePickerDataCell = @"XLFormRowDescriptorTypePickerDataCell";

@interface ARCHIEXFormPickerDataCell ()
@end

@implementation ARCHIEXFormPickerDataCell



+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[ARCHIEXFormPickerDataCell class] forKey:XLFormRowDescriptorTypePickerDataCell];
}

#pragma mark - XLFormDescriptorCell

-(void)configure
{
    [super configure];
    
    __weak typeof (self) weakSelf = self;
    
    //label
    UILabel *birthDayLabel = [[UILabel alloc]init];
    birthDayLabel.text = @"生日:";
    birthDayLabel.textColor = [UIColor blackColor];
    
    [weakSelf.contentView addSubview:birthDayLabel];
    [birthDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(15*KRATE);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    //data
    UILabel *dataLabel = [[UILabel alloc]init];
    dataLabel.textColor = [UIColor blackColor];
    [weakSelf.contentView addSubview:dataLabel];
    [dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-10*KRATE);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    _dataLabel = dataLabel;
    
    //btn
    UIButton *pickerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pickerBtn.backgroundColor = [UIColor clearColor];
    
    [weakSelf.contentView addSubview:pickerBtn];
    [pickerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView);
    }];
    [pickerBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)saveClick{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd "];
        NSDictionary *dict = [NSDictionary dictionary];
        dict = @{
                 @"data":date,
                 };

            _dataLabel.text = date;
        self.rowDescriptor.value = @{@"data":date};
        
    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDay;
    datepicker.minLimitDate = [NSDate date:@"1970-1-01 " WithFormat:@"yyyy-MM-dd "];
    datepicker.maxLimitDate = [NSDate date:@"2049-12-31 " WithFormat:@"yyyy-MM-dd "];
    [datepicker show];
    
    
    
}
-(void)update{
    [super update];
    NSDictionary *value = self.rowDescriptor.value;
    
    _dataLabel.text =  [value objectForKey:@"data"];
    
}
+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 35*KRATE;
}

@end
