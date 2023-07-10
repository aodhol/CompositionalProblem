import Foundation

public enum Genre: String {
    case easyListening
    case jazz
    case rock
    case pop
    case danceMusic
    case gospel
    case metal
}

public struct Album: Hashable {
    public let title: String
    public let description: String
}

public struct Shelf: Hashable {
    public let genre: Genre
    public let albums: [Album]
}

public let easyListeningShelf = Shelf(genre: .easyListening, albums: [
    Album(title: "Moon River", description: "Classical melodies"),
    Album(title: "Soft Echoes", description: "Calm and relaxing"),
    Album(title: "Smooth Sailing", description: "Easy tunes"),
    Album(title: "Gentle Whispers", description: "Harmonious notes"),
    Album(title: "Twilight Melodies", description: "End your day with a beautiful soundtrack"),
    Album(title: "Calm Ocean", description: "Soothing sounds of nature"),
    Album(title: "Serene Sunsets", description: "Unwind with this relaxing playlist"),
    Album(title: "Quiet Harmony", description: "Songs for peace and quiet")
])

public let jazzShelf = Shelf(genre: .jazz, albums: [
    Album(title: "Blue Moods", description: "Classic jazz tunes"),
    Album(title: "Rhythm and Blues", description: "Moving tracks"),
    Album(title: "Late Night Swing", description: "Perfect"),
    Album(title: "Downtown Jazz", description: "Catchy beats"),
    Album(title: "Cool Jazz", description: "Chilled jazz notes for any time of day"),
    Album(title: "Jazz Cafe", description: "Music that'll transport you to a jazz cafe"),
    Album(title: "Brassy Notes", description: "Songs with a strong brass presence"),
    Album(title: "Melody in Motion", description: "Fast-paced tunes for a lively evening")
])

public let rockShelf = Shelf(genre: .rock, albums: [
    Album(title: "High Voltage", description: "Electric tracks"),
    Album(title: "Rolling Thunder", description: "Heavy guitars"),
    Album(title: "Stone Rebels", description: "Songs from the heart"),
    Album(title: "Rock Revolution", description: "A mix of classics"),
    Album(title: "Dusty Roads", description: "A blend of rock and country and stuff"),
    Album(title: "Rock Titans", description: "Tracks from the biggest names in rock"),
    Album(title: "Sound Wave", description: "Songs that'll get you headbanging"),
    Album(title: "Loud Echoes", description: "Rock that resonates")
])

public let popShelf = Shelf(genre: .pop, albums: [
    Album(title: "Summer Vibes", description: "Upbeat tracks"),
    Album(title: "Starstruck", description: "Hits"),
    Album(title: "Pop Culture", description: "Songs"),
    Album(title: "Chart Toppers", description: "Number one hits"),
    Album(title: "Sweet Melodies", description: "Cute and catchy pop songs from the one two three"),
    Album(title: "Dance Fever", description: "Tracks that will get you dancing"),
    Album(title: "Golden Pop", description: "The best songs from the golden era of pop"),
    Album(title: "Rising Stars", description: "Fresh tracks from newcomers")
])

public let danceMusicShelf = Shelf(genre: .danceMusic, albums: [
    Album(title: "Club Nights", description: "Dancing all night"),
    Album(title: "Bass Drops", description: "Epic bass drops"),
    Album(title: "Electro House", description: "Electronic and house music"),
    Album(title: "Dance Floor Fillers", description: "Fill the dance floor"),
    Album(title: "Techno Beats", description: "The best in techno music one two three four five six seven"),
    Album(title: "Rave On", description: "Tracks perfect for a rave one two three four five six seven"),
    Album(title: "EDM Anthems", description: "The biggest EDM anthems one two three four five six seven"),
    Album(title: "Trance Waves", description: "The best in trance music one two three four five six seven")
])

public let gospelShelf = Shelf(genre: .gospel, albums: [
    Album(title: "Praise and Worship", description: "Praise and worship"),
    Album(title: "Heavenly Harmonies", description: "Beautiful choral pieces"),
    Album(title: "Gospel Gold", description: "The best of gospel music"),
    Album(title: "Faithful Melodies", description: "Songs of faith and hope"),
    Album(title: "Grace Notes", description: "Moving spiritual songs one two three four five six seven"),
    Album(title: "Sacred Songs", description: "Traditional and contemporary spiritual music"),
    Album(title: "Divine Choruses", description: "Inspirational choir music one two three four five six seven"),
    Album(title: "Testament Tunes", description: "Songs that tell biblical stories one two three four five six seven")
])

public let metalShelf = Shelf(genre: .metal, albums: [
    Album(title: "Iron Roar", description: "Headbanging tunes"),
    Album(title: "Steel Symphony", description: "Symphonic twist"),
    Album(title: "Hardcore Havoc", description: "Tracks for a mosh pit"),
    Album(title: "Blackened Beats", description: "The best of black metal"),
    Album(title: "Power Chords", description: "Energetic power metal tunes one two three four five six seven"),
    Album(title: "Death Metal Mayhem", description: "The rawest death metal tracks one two three four five six seven"),
    Album(title: "Thrash Titans", description: "Fast and furious thrash metal one two three four five six seven"),
    Album(title: "Doom and Gloom", description: "Slow and heavy doom metal one two three four five six seven")
])
