#import "Person.h"

static const NSUInteger MaxRanking = 5;


@implementation Person

- (void)dealloc
{
    [_firstName release];
    [_lastName release];
    
    [super dealloc];
}

- (id)initWithFirstName:(NSString *)firstName
               lastName:(NSString *)lastName
                    age:(int)age
{
    self = [super init];
    if (!self) return nil;
    
    _firstName = [firstName copy];
    _lastName = [lastName copy];
    _age = age;
    
    return self;
}

+ (instancetype)personWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(int)age
{
    return [[[self alloc] initWithFirstName:firstName lastName:lastName age:age] autorelease];
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", [self firstName], [self lastName]];
}

- (NSString *)favoritesRankingStars
{
    if ([self favoritesRanking] == 0)  return @"-";
    return [@"*****" substringToIndex:[self favoritesRanking]];
}

- (void)display
{
    printf("%s\n", [[self description] UTF8String]);
}

- (NSString *)description
{
    NSString *stars = [self favoritesRankingStars];
    stars = [stars stringByPaddingToLength:MaxRanking
                                withString:@" "
                           startingAtIndex:0];
    
    return [NSString stringWithFormat:@"%@  %@", stars, [self fullName]];
}

@end
