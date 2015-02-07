//
//  ImagePickerViewController.m
//  ActiveRecordDemo
//
//  Created by Song Lanlan on 21/6/14.
//  Copyright (c) 2014 Song Lanlan. All rights reserved.
//

#import "ImagePicker.h"

#import "JSShortHand.h"

#define Device_IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

@interface ImagePicker ()
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIPopoverControllerDelegate
>
{
    UIPopoverController *popController;
}

@end

@implementation ImagePicker

- (void)dealloc{
    self.didFinishPickingImage = nil;
    self.didFinishPickingMediaWithInfo = nil;
    self.didCancel = nil;
    JS_releaseSafely(popController);
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        if (!Device_IS_IPHONE) {
            popController = [[UIPopoverController alloc] initWithContentViewController:[[[UIViewController alloc] init] autorelease]];
        }
    }
    return self;
}

- (BOOL)shouldUseLowQualityImage {
    // TODO: when device is iPhone 4/4s, or iPad 2 / mini, maybe use low quanlity is better
    return NO;
}

#pragma mark public

-(void)showPickerWithType:(UIImagePickerControllerSourceType)type allowsEditing:(BOOL)allowsEditing{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = type;
    picker.allowsEditing = allowsEditing;
    picker.delegate = self;
    
    if ([self shouldUseLowQualityImage]) {
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    }
    
    [[[UIApplication sharedApplication].delegate window] addSubview:picker.view];
}

-(void)showPickerWithType:(UIImagePickerControllerSourceType)type allowsEditing:(BOOL)allowsEditing onViewController:(UIViewController *)VC popoverFromRect:(CGRect)rect{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = type;
    picker.allowsEditing = allowsEditing;
    picker.delegate = self;
    
    if ([self shouldUseLowQualityImage]) {
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    }
    
    popController.contentViewController =  picker;
    
    popController.popoverContentSize = CGSizeMake(600,480);
    popController.delegate = self;
//    CGRect rect = CGRectMake(0,600,2,2);
    
    [popController presentPopoverFromRect:rect
                                   inView:VC.view
                 permittedArrowDirections:UIPopoverArrowDirectionDown
                                 animated:YES];
}

#pragma mark delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (self.didFinishPickingMediaWithInfo) self.didFinishPickingMediaWithInfo(info);
    [picker.view removeFromSuperview];
    [picker autorelease];
    [popController dismissPopoverAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    if (self.didFinishPickingImage) self.didFinishPickingImage(image, editingInfo);
    [picker.view removeFromSuperview];
    [picker autorelease];
    [popController dismissPopoverAnimated:YES];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker.view removeFromSuperview];
    if (self.didCancel) self.didCancel();
    [picker autorelease];
}

#pragma mark - UIPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
}
@end
