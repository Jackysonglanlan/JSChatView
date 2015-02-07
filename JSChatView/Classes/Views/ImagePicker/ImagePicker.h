//
//  ImagePickerViewController.h
//  ActiveRecordDemo
//
//  Created by Song Lanlan on 21/6/14.
//  Copyright (c) 2014 Song Lanlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePicker : NSObject

@property(nonatomic,copy) void(^didFinishPickingMediaWithInfo)(NSDictionary *info);

@property(nonatomic,copy) void(^didFinishPickingImage)(UIImage *image, NSDictionary *editingInfo);

@property(nonatomic,copy) void(^didCancel)(void);

-(void)showPickerWithType:(UIImagePickerControllerSourceType)type allowsEditing:(BOOL)allowsEditing;

-(void)showPickerWithType:(UIImagePickerControllerSourceType)type allowsEditing:(BOOL)allowsEditing
         onViewController:(UIViewController *)VC popoverFromRect:(CGRect)rect;

@end
