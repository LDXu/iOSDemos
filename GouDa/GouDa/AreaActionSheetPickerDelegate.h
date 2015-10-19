//
//  AreaActionSheetPickerDelegate.h
//  GouDa
//
//  Created by 张威 on 15/9/24.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSheetCustomPickerDelegate.h"

@interface AreaActionSheetPickerDelegate : NSObject <ActionSheetCustomPickerDelegate>

typedef void(^AreaActionSheetPickerDoneBlock)(AbstractActionSheetPicker *areaActionSheetPicker,
                                              NSString *selectedProvince,
                                              NSString *selectedCity,
                                              NSString *selectedTown);
typedef void(^AreaActionSheetPickerCancelBlock)();

- (instancetype)initWithDoneBlock:(AreaActionSheetPickerDoneBlock)doneBlock
                      cancelBlock:(AreaActionSheetPickerCancelBlock)cancelBlock;

- (void)loadAreaData;

@property (nonatomic, strong, readonly) NSString *selectedProvinceName;
@property (nonatomic, strong, readonly) NSString *selectedCityName;
@property (nonatomic, strong, readonly) NSString *selectedTownName;

@property (nonatomic, strong) AreaActionSheetPickerDoneBlock doneBlock;
@property (nonatomic, strong) AreaActionSheetPickerCancelBlock cancelBlock;

@end
