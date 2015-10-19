//
//  AreaActionSheetPickerDelegate.m
//  GouDa
//
//  Created by 张威 on 15/9/24.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "AreaActionSheetPickerDelegate.h"
#import "AbstractActionSheetPicker.h"

@interface AreaActionSheetPickerDelegate ()

@property (nonatomic, copy) NSDictionary *areaDictionary;
@property (nonatomic, copy) NSArray *provinceNamesArray;
@property (nonatomic, copy) NSArray *cityNamesArray;
@property (nonatomic, copy) NSArray *townNamesArray;

@property (nonatomic, strong) NSString *selectedProvinceName;
@property (nonatomic, strong) NSString *selectedCityName;
@property (nonatomic, strong) NSString *selectedTownName;


@end


@implementation AreaActionSheetPickerDelegate

- (instancetype)initWithDoneBlock:(AreaActionSheetPickerDoneBlock)doneBlock
                      cancelBlock:(AreaActionSheetPickerCancelBlock)cancelBlock {
    self = [super init];
    if (self) {
        _doneBlock   = [doneBlock copy];
        _cancelBlock = [cancelBlock copy];
    }
    return self;
}

- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker
      configurePickerView:(UIPickerView *)pickerView {
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = NO;
}

- (void)loadAreaData {
    NSString *path          = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.areaDictionary     = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // province names array
    self.provinceNamesArray = [self.areaDictionary allKeys];

    // city names array
    NSArray *temp = [self.areaDictionary objectForKey:[self.provinceNamesArray firstObject]];
    self.cityNamesArray = [[temp firstObject] allKeys];
    
    // town names array
    self.townNamesArray = [[temp firstObject] objectForKey:[self.cityNamesArray firstObject]];
    
    self.selectedProvinceName = self.provinceNamesArray.firstObject;
    self.selectedCityName     = self.cityNamesArray.firstObject;
    self.selectedTownName     = self.townNamesArray.firstObject;
}

/**
 Success callback
 
 \param actionSheetPicker   .pickerView property accesses the picker.  Requires a cast to UIView subclass for the picker
 \param origin              The entity which launched the ActionSheetPicker
 */
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker
                             origin:(id)origin {
    DLog(@"确定");
    if (self.doneBlock) {
        self.doneBlock(actionSheetPicker, self.selectedProvinceName, self.selectedCityName, self.selectedTownName);
    }
}

/** Cancel callback.  See actionSheetPickerDidSuccess:origin: */
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker
                            origin:(id)origin {
    DLog(@"取消");
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - UIPickerViewDelegate
/*
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 0.f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 0.f;
}
 */

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceNamesArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityNamesArray objectAtIndex:row];
    } else {
        return [self.townNamesArray objectAtIndex:row];
    }
}

/*
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return nil;
}
 */

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, floorf(mainScreenWidth / 3), 20.f)];
        label.textColor                 = [UIColor appDataPickerTitleColor];
        label.minimumScaleFactor        = 0.5;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment             = NSTextAlignmentCenter;
        label.font                      = [UIFont appDataPickerTitleFont];
    }
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSAssert(row < self.provinceNamesArray.count, @"pickerView wrong 1");
        self.selectedProvinceName = [self.provinceNamesArray objectAtIndex:row];
        
        // update city names array
        NSArray *temp = [self.areaDictionary objectForKey:self.selectedProvinceName];
        self.cityNamesArray = [[temp firstObject] allKeys];
        [pickerView reloadComponent:1];
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        self.selectedCityName = [self.cityNamesArray firstObject];
        
        // update town names array
        NSDictionary *province = [[self.areaDictionary objectForKey:self.selectedProvinceName] firstObject];
        self.townNamesArray = [province objectForKey:self.selectedCityName];
        [pickerView reloadComponent:2];
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
        self.selectedTownName = [self.townNamesArray firstObject];
        
    } else if (component == 1) {
        NSAssert(row < self.cityNamesArray.count, @"pickerView wrong 2");
        self.selectedCityName = [self.cityNamesArray objectAtIndex:row];
        
        // update town names array
        NSDictionary *province = [[self.areaDictionary objectForKey:self.selectedProvinceName] firstObject];
        self.townNamesArray = [province objectForKey:self.selectedCityName];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        self.selectedTownName = [self.townNamesArray firstObject];
    } else if (component == 2) {
        NSAssert(row < self.townNamesArray.count, @"pickerView wrong 3");
        self.selectedTownName = [self.townNamesArray objectAtIndex:row];
    }
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceNamesArray.count;
    } else if (component == 1) {
        return self.cityNamesArray.count;
    } else if (component == 2) {
        return self.townNamesArray.count;
    }
    return 0;
}

@end
