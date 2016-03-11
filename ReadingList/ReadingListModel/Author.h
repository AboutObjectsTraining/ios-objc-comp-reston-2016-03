#import <Foundation/Foundation.h>
#import "ModelObject.h"

extern NSString * const FirstNameKey;
extern NSString * const LastNameKey;

@interface Author : ModelObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, readonly) NSString *fullName;

@end
