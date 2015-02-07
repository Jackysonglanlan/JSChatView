//
//  JSShortHand.h
//
//  Created by Lanlan Song on 12-3-1.
//  Copyright (c) 2012 Cybercom. All rights reserved.
//

#ifndef template_ios_project_JSShortHand_h
#define template_ios_project_JSShortHand_h

////////////////////////////////////////
/////// Common ////////
////////////////////////////////////////

// log
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent],\
__LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#define DLog( s, ... )
#else
#define DLog( s, ... )
#endif

#pragma mark - Common

#define JS_PrintBOOL(bool) NSLog((bool) ? @"YES" : @"NO")

#define JS_Regex_FullMatch(_regex_) [NSString stringWithFormat:@"(?m)^%@$",_regex_]

/*
 - (NSArray*)getVarObjects:(id)firstObject, ...{
 id eachObject;
 va_list argumentList;
 NSMutableArray *args = [NSMutableArray array];
 if (firstObject) // The first argument isn't part of the varargs list,
 {                                   // so we'll handle it separately.
 [args addObject: firstObject];
 va_start(argumentList, firstObject); // Start scanning for arguments after firstObject.
 while ((eachObject = va_arg(argumentList, id))) // As many times as we can get an argument of type "id"
 [args addObject: eachObject]; // that isn't nil, add it to self's contents.
 va_end(argumentList);
 }
 return args;
 }
 */
#define JS_ParseVarArgs(container_Var_Name,firstObject)\
[NSMutableArray array];\
id eachObject;\
va_list argumentList;\
if (firstObject){\
[((NSMutableArray*)container_Var_Name) addObject: firstObject];\
va_start(argumentList, firstObject);\
while ((eachObject = va_arg(argumentList, id))) \
[((NSMutableArray*)container_Var_Name) addObject: eachObject];\
va_end(argumentList);\
}

////////////////////////////////////////
/////// Definition ////////
////////////////////////////////////////

#pragma mark - Definition

#define JS_STUB_STANDARD_SETTER(attribute,setterParameter) \
{\
  id __jackysong_stub_standard_setter__tmp__ = setterParameter;\
  [__jackysong_stub_standard_setter__tmp__ retain]; \
  [attribute release]; \
  attribute = __jackysong_stub_standard_setter__tmp__;\
}

// #define ATTR(keyword) @property (nonatomic, keyword)

////////////////////////////////////////
/////// Primitive to Object ////////
////////////////////////////////////////

#pragma mark - Primitive to Object

#pragma mark number

/*
 + (NSNumber *)numberWithChar:(char)value;
 + (NSNumber *)numberWithUnsignedChar:(unsigned char)value;
 + (NSNumber *)numberWithShort:(short)value;
 + (NSNumber *)numberWithUnsignedShort:(unsigned short)value;
 + (NSNumber *)numberWithInt:(int)value;
 + (NSNumber *)numberWithUnsignedInt:(unsigned int)value;
 + (NSNumber *)numberWithLong:(long)value;
 + (NSNumber *)numberWithUnsignedLong:(unsigned long)value;
 + (NSNumber *)numberWithLongLong:(long long)value;
 + (NSNumber *)numberWithUnsignedLongLong:(unsigned long long)value;
 + (NSNumber *)numberWithFloat:(float)value;
 + (NSNumber *)numberWithDouble:(double)value;
 + (NSNumber *)numberWithBool:(BOOL)value;
 + (NSNumber *)numberWithInteger:(NSInteger)value NS_AVAILABLE(10_5, 2_0);
 + (NSNumber *)numberWithUnsignedInteger:(NSUInteger)value NS_AVAILABLE(10_5, 2_0);
 */
#define cObject(_n) [NSNumber numberWithChar:(_n)]
#define sObject(_n) [NSNumber numberWithShort:(_n)]
#define iObject(_n) [NSNumber numberWithInt:(_n)]
#define lObject(_n) [NSNumber numberWithLong:(_n)]
#define llObject(_n) [NSNumber numberWithLongLong:(_n)]
#define fObject(_n) [NSNumber numberWithFloat:(_n)]
#define dObject(_n) [NSNumber numberWithDouble:(_n)]
#define bObject(_n) [NSNumber numberWithBool:(_n)]
#define integerObject(_n) [NSNumber numberWithInteger:(_n)]

#pragma mark struct

/*
 + (NSValue *)valueWithRange:(NSRange)range;
 + (NSValue *)valueWithPointer:(const void *)pointer;
 + (NSValue *)valueWithCATransform3D:(CATransform3D)t;
 + (NSValue *)valueWithCGPoint:(CGPoint)point;
 + (NSValue *)valueWithCGSize:(CGSize)size;
 + (NSValue *)valueWithCGRect:(CGRect)rect;
 + (NSValue *)valueWithCGAffineTransform:(CGAffineTransform)transform;
 + (NSValue *)valueWithUIEdgeInsets:(UIEdgeInsets)insets;
 + (NSValue *)valueWithUIOffset:(UIOffset)insets __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);
 */
#define rangeObject(_n) [NSValue valueWithRange:(_n)]
#define pointerObject(_n) [NSValue valueWithPointer:(_n)]
#define transform3DObject(_n) [NSValue valueWithCATransform3D:(_n)]
#define pointObject(_point) [NSValue valueWithCGPoint:(_point)]
#define sizeObject(_size) [NSValue valueWithCGSize:(_size)]
#define rectObject(_rect) [NSValue valueWithCGRect:(_rect)]
#define transformObject(_n) [NSValue valueWithCGAffineTransform:(_n)]
#define insetsObject(_n) [NSValue valueWithUIEdgeInsets:(_n)]
#define offsetObject(_n) [NSValue valueWithUIOffset:(_n)]

////////////////////////////////////////
/////// Object to Primitive ////////
////////////////////////////////////////

#pragma mark - Object to Primitive

#pragma mark number

/*
 - (char)charValue;
 - (unsigned char)unsignedCharValue;
 - (short)shortValue;
 - (unsigned short)unsignedShortValue;
 - (int)intValue;
 - (unsigned int)unsignedIntValue;
 - (long)longValue;
 - (unsigned long)unsignedLongValue;
 - (long long)longLongValue;
 - (unsigned long long)unsignedLongLongValue;
 - (float)floatValue;
 - (double)doubleValue;
 - (BOOL)boolValue;
 - (NSInteger)integerValue NS_AVAILABLE(10_5, 2_0);
 - (NSUInteger)unsignedIntegerValue NS_AVAILABLE(10_5, 2_0);
 */
#define charValue(_n) [((NSNumber*)(_n)) charValue]
#define unsignedCharValue(_n) [((NSNumber*)(_n)) unsignedCharValue]
#define shortValue(_n) [((NSNumber*)(_n)) shortValue]
#define unsignedShortValue(_n) [((NSNumber*)(_n)) unsignedShortValue]
#define intValue(_n) [((NSNumber*)(_n)) intValue]
#define unsignedIntValue(_n) [((NSNumber*)(_n)) unsignedIntValue]
#define longValue(_n) [((NSNumber*)(_n)) longValue]
#define unsignedLongValue(_n) [((NSNumber*)(_n)) unsignedLongValue]
#define longLongValue(_n) [((NSNumber*)(_n)) longLongValue]
#define unsignedLongLongValue(_n) [((NSNumber*)(_n)) unsignedLongLongValue]
#define floatValue(_n) [((NSNumber*)(_n)) floatValue]
#define doubleValue(_n) [((NSNumber*)(_n)) doubleValue]
#define boolValue(_n) [((NSNumber*)(_n)) boolValue]
#define integerValue(_n) [((NSNumber*)(_n)) integerValue]
#define unsignedIntegerValue(_n) [((NSNumber*)(_n)) unsignedIntegerValue]

#pragma mark struct

/*
 - (NSRange)rangeValue;
 - (CGPoint)CGPointValue;
 - (CGSize)CGSizeValue;
 - (CGRect)CGRectValue;
 - (CGAffineTransform)CGAffineTransformValue;
 - (UIEdgeInsets)UIEdgeInsetsValue;
 - (UIOffset)UIOffsetValue __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);
 */
#define rangeValue(_n) [((NSValue*)(_n)) rangeValue]
#define pointValue(_n) [((NSValue*)(_n)) CGPointValue]
#define sizeValue(_n) [((NSValue*)(_n)) CGSizeValue]
#define rectValue(_n) [((NSValue*)(_n)) CGRectValue]
#define transformValue(_n) [((NSValue*)(_n)) CGAffineTransformValue]
#define insetsValue(_n) [((NSValue*)(_n)) UIEdgeInsetsValue]
#define offsetValue(_n) [((NSValue*)(_n)) UIOffsetValue]


////////////////////////////////////////
/////// Calculation ////////
////////////////////////////////////////

#pragma mark - Calculation

#define JS_MakeSureValueBetween(VALUE, MIN, MAX) ({ \
__typeof__(VALUE) LTK__value = (VALUE); \
__typeof__(MIN) LTK__min = (MIN); \
__typeof__(MAX) LTK__max = (MAX); \
NSCAssert((LTK__min < LTK__max), @"JS_MakeSureValueBetween: MIN must be less than MAX."); \
(LTK__min > LTK__value ? LTK__min : (LTK__value < LTK__max ? LTK__value : LTK__max)); \
})


////////////////////////////////////////
/////// Memory Management ////////
////////////////////////////////////////

#pragma mark - Memory Management

#define JS_weakReferBlock(__type) __typeof (__type) __block

// usage: JS_weakRef(Foo, weakSelf) = self;
#define JS_weakRef(_TypeName_, _ParamName_) __block _TypeName_ *_ParamName_

#define JS_weakSelf(_refer_) __typeof(&*self) __block _refer_ = self

#define JS_releaseSafely(__POINTER) {\
[__POINTER release]; \
__POINTER = nil;\
}

#define JS_autoReleaseSafely(__POINTER) {\
[__POINTER autorelease];\
__POINTER = nil; \
}

#define JS_releaseAllSafely(_collection_) {\
for (id obj in _collection_) {\
JS_releaseSafely(obj);\
}\
}

#define JS_releaseTimer(__TIMER) {\
[__TIMER invalidate];\
__TIMER = nil; \
}


////////////////////////////////////////
/////// UI ////////
////////////////////////////////////////

#pragma mark - UI

#define JS_RectSetX(rect, x) CGRectMake(x, CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect))
#define JS_RectSetY(rect, y) CGRectMake(CGRectGetMinX(rect), y, CGRectGetWidth(rect), CGRectGetHeight(rect))
#define JS_RectSetW(rect, w) CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), w, CGRectGetHeight(rect))
#define JS_RectSetH(rect, h) CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), h)

#define JS_ViewX(view) CGRectGetMinX(view.frame)
#define JS_ViewY(view) CGRectGetMinY(view.frame)
#define JS_ViewW(view) CGRectGetWidth(view.frame)
#define JS_ViewH(view) CGRectGetHeight(view.frame)

#define JS_ViewSetX(view, x) (view.frame = JS_RectSetX(view.frame, x))
#define JS_ViewSetY(view, y) (view.frame = JS_RectSetY(view.frame, y))
#define JS_ViewSetW(view, w) (view.frame = JS_RectSetW(view.frame, w))
#define JS_ViewSetH(view, h) (view.frame = JS_RectSetH(view.frame, h))

#define JS_Point_ViewCenter(view) ( CGPointMake(JS_ViewW(view)/2, JS_ViewH(view)/2) )

#define JS_Color_RGB(_r,_g,_b) ([UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:1])
#define JS_Color_RGBA(_r,_g,_b,_a) ([UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:(_a)/255.0])
#define JS_Color_Clear [UIColor clearColor]

#define JS_Math_Radians(degrees) (degrees * M_PI/180)

#endif


