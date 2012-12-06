#import "FlickrPhoto.h"

#import "FlickrPhotoItemMedia.h"

@implementation FlickrPhoto
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.author forKey:@"author"];
    [encoder encodeObject:self.authorId forKey:@"authorId"];
    [encoder encodeObject:self.dateTaken forKey:@"dateTaken"];
    [encoder encodeObject:self.descriptionText forKey:@"descriptionText"];
    [encoder encodeObject:self.link forKey:@"link"];
    [encoder encodeObject:self.media forKey:@"media"];
    [encoder encodeObject:self.published forKey:@"published"];
    [encoder encodeObject:self.tags forKey:@"tags"];
    [encoder encodeObject:self.title forKey:@"title"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.author = [decoder decodeObjectForKey:@"author"];
        self.authorId = [decoder decodeObjectForKey:@"authorId"];
        self.dateTaken = [decoder decodeObjectForKey:@"dateTaken"];
        self.descriptionText = [decoder decodeObjectForKey:@"descriptionText"];
        self.link = [decoder decodeObjectForKey:@"link"];
        self.media = [decoder decodeObjectForKey:@"media"];
        self.published = [decoder decodeObjectForKey:@"published"];
        self.tags = [decoder decodeObjectForKey:@"tags"];
        self.title = [decoder decodeObjectForKey:@"title"];
    }
    return self;
}

+ (FlickrPhoto *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    FlickrPhoto *instance = [[FlickrPhoto alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key
{

    if ([key isEqualToString:@"media"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.media = [FlickrPhotoItemMedia instanceFromDictionary:value];
        }
    } else if ([key isEqualToString:@"author"] ) {
        NSMutableString *mAuthor = [NSMutableString stringWithString:value];
        
        [mAuthor replaceOccurrencesOfString:@"nobody@flickr.com (" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [mAuthor length])];
        [mAuthor replaceCharactersInRange:NSMakeRange([mAuthor length] - 1, 1) withString:@""];
        
        self.author = mAuthor;
    } else if ([key isEqualToString:@"title"] ) {
        if ([value length]) {
            self.title = value;
        }
        else {
            self.title = NSLocalizedString(@"(No Title)", @"(No Title)");
        }
    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"author_id"]) {
        [self setValue:value forKey:@"authorId"];
    } else if ([key isEqualToString:@"date_taken"]) {
        [self setValue:value forKey:@"dateTaken"];
    } else if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descriptionText"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


- (NSDictionary *)dictionary
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.author) {
        [dictionary setObject:self.author forKey:@"author"];
    }

    if (self.authorId) {
        [dictionary setObject:self.authorId forKey:@"authorId"];
    }

    if (self.dateTaken) {
        [dictionary setObject:self.dateTaken forKey:@"dateTaken"];
    }

    if (self.descriptionText) {
        [dictionary setObject:self.descriptionText forKey:@"descriptionText"];
    }

    if (self.link) {
        [dictionary setObject:self.link forKey:@"link"];
    }

    if (self.media) {
        [dictionary setObject:self.media forKey:@"media"];
    }

    if (self.published) {
        [dictionary setObject:self.published forKey:@"published"];
    }

    if (self.tags) {
        [dictionary setObject:self.tags forKey:@"tags"];
    }

    if (self.title) {
        [dictionary setObject:self.title forKey:@"title"];
    }

    return dictionary;

}

- (NSURL *)publicURL
{
    return [NSURL URLWithString:_media.m];
}

@end
