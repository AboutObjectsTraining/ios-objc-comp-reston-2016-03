#import <Foundation/Foundation.h>

NSString *RELPathForDocument(NSString *name, NSString *type);

@class ReadingList;

@interface ReadingListStore : NSObject

+ (instancetype)storeWithName:(NSString *)storeName;
- (instancetype)initWithStoreName:(NSString *)storeName;

- (ReadingList *)fetchedReadingList;
- (void)saveReadingList:(ReadingList *)readingList;

@end
