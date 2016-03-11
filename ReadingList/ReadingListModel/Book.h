#import <Foundation/Foundation.h>
#import "ModelObject.h"

extern NSString * const BookTitleKey;
extern NSString * const YearKey;
extern NSString * const AuthorKey;

@class Author;

@interface Book : ModelObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;

@property (nonatomic, retain) Author *author;

@end
