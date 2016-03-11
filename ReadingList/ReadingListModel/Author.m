#import "Author.h"

@implementation Author

NSString * const FirstNameKey = @"firstName";
NSString * const LastNameKey = @"lastName";

+ (NSArray *)keys
{
    return @[FirstNameKey, LastNameKey];
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
}

- (NSString *)description
{
    return self.fullName;
}

@end
