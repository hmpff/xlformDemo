//表单代码解读http://www.2cto.com/kf/201609/547090.html
#import "XLFormBaseCell.h"

extern NSString * const XLFormRowDescriptorTypePickerDataCell;

@interface ARCHIEXFormPickerDataCell : XLFormBaseCell
@property(nonatomic ,strong) UIButton *pickerBtn;
@property(nonatomic ,strong) UILabel *dataLabel;
@end
