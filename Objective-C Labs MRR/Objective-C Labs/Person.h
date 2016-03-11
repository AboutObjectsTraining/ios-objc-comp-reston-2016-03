#import <Foundation/Foundation.h>

@interface Person : NSObject

- initWithFirstName:(NSString *)firstName
           lastName:(NSString *)lastName
                age:(int)age;

+ (instancetype)personWithFirstName:(NSString *)firstName
                           lastName:(NSString *)lastName
                                age:(int)age;

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (readonly, nonatomic) NSString *fullName;

@property (assign, nonatomic) int age;

@property (assign, nonatomic) NSUInteger favoritesRanking;
@property (readonly, nonatomic) NSString *favoritesRankingStars;

- (void)display;

@end

