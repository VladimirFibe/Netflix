import Foundation

struct Movie: Codable, Hashable {
    let id: Int
    var adult: Bool = false
    var backdropPath: String = ""
    var genreIds: [Int] = []
    var originalLanguage: String = ""
    var originalTitle: String = ""
    let overview: String
    var popularity: Double = 0.0
    let posterPath: String
    let releaseDate: String
    let title: String
    var video: Bool = true
    var voteAverage: Double = 0.0
    var voteCount: Int = 0
    var posterUrl: String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
}

#if DEBUG
extension Movie {
    static let sampleData: [Movie] = [
        .init(id: 278,
              overview: "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
              posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
              releaseDate: "1994-09-23",
              title: "The Shawshank Redemption"
             ),
        .init(id: 238,
              overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
              posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
              releaseDate: "1972-03-14",
              title: "The Godfather"
             ),
        .init(id: 240,
              overview: "In the continuing saga of the Corleone crime family, a young Vito Corleone grows up in Sicily and in 1910s New York. In the 1950s, Michael Corleone attempts to expand the family business into Las Vegas, Hollywood and Cuba.",
              posterPath: "/hek3koDUyRQk7FIhPXsa6mT2Zc3.jpg",
              releaseDate: "1974-12-20",
              title: "The Godfather Part II"
             ),
        .init(id: 424,
              overview: "The true story of how businessman Oskar Schindler saved over a thousand Jewish lives from the Nazis while they worked as slaves in his factory during World War II.",
              posterPath: "/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg",
              releaseDate: "1993-12-15",
              title: "Schindler's List"
             ),
        .init(id: 389,
              overview: "The defense and the prosecution have rested and the jury is filing into the jury room to decide if a young Spanish-American is guilty or innocent of murdering his father. What begins as an open and shut case soon becomes a mini-drama of each of the jurors' prejudices and preconceptions about the trial, the accused, and each other.",
              posterPath: "/ow3wq89wM8qd5X7hWKxiRfsFf9C.jpg",
              releaseDate: "1957-04-10",
              title: "12 Angry Men"
             ),
        .init(id: 129,
              overview: "A young girl, Chihiro, becomes trapped in a strange new world of spirits. When her parents undergo a mysterious transformation, she must call upon the courage she never knew she had to free her family.",
              posterPath: "/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg",
              releaseDate: "2001-07-20",
              title: "Spirited Away"
             ),
        .init(id: 19404,
              overview: "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",
              posterPath: "/lfRkUr7DYdHldAqi3PwdQGBRBPM.jpg",
              releaseDate: "1995-10-20",
              title: "Dilwale Dulhania Le Jayenge"
             ),
        .init(id: 155,
              overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.",
              posterPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
              releaseDate: "2008-07-16",
              title: "The Dark Knight"
             ),
        .init(id: 496243,
              overview: "All unemployed, Ki-taek's family takes peculiar interest in the wealthy and glamorous Parks for their livelihood until they get entangled in an unexpected incident.",
              posterPath: "/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
              releaseDate: "2019-05-30",
              title: "Parasite"
             ),
        .init(id: 497,
              overview: "A supernatural tale set on death row in a Southern prison, where gentle giant John Coffey possesses the mysterious power to heal people's ailments. When the cell block's head guard, Paul Edgecomb, recognizes Coffey's miraculous gift, he tries desperately to help stave off the condemned man's execution.",
              posterPath: "/8VG8fDNiy50H4FedGwdSVUPoaJe.jpg",
              releaseDate: "1999-12-10",
              title: "The Green Mile"
             ),
        .init(id: 372058,
              overview: "High schoolers Mitsuha and Taki are complete strangers living separate lives. But one night, they suddenly switch places. Mitsuha wakes up in Taki’s body, and he in hers. This bizarre occurrence continues to happen randomly, and the two must adjust their lives around each other.",
              posterPath: "/q719jXXEzOoYaps6babgKnONONX.jpg",
              releaseDate: "2016-08-26",
              title: "Your Name."
             ),
        .init(id: 680,
              overview: "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.",
              posterPath: "/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg",
              releaseDate: "1994-09-10",
              title: "Pulp Fiction"
             ),
        .init(id: 122,
              overview: "Aragorn is revealed as the heir to the ancient kings as he, Gandalf and the other members of the broken fellowship struggle to save Gondor from Sauron's forces. Meanwhile, Frodo and Sam take the ring closer to the heart of Mordor, the dark lord's realm.",
              posterPath: "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg",
              releaseDate: "2003-12-01",
              title: "The Lord of the Rings: The Return of the King"
             ),
        .init(id: 13,
              overview: "A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.",
              posterPath: "/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg",
              releaseDate: "1994-06-23",
              title: "Forrest Gump"
             ),
        .init(id: 429,
              overview: "While the Civil War rages on between the Union and the Confederacy, three men – a quiet loner, a ruthless hitman, and a Mexican bandit – comb the American Southwest in search of a strongbox containing $200,000 in stolen gold.",
              posterPath: "/bX2xnavhMYjWDoZp1VM6VnU1xwe.jpg",
              releaseDate: "1966-12-22",
              title: "The Good, the Bad and the Ugly"
             ),
        .init(id: 769,
              overview: "The true story of Henry Hill, a half-Irish, half-Sicilian Brooklyn kid who is adopted by neighbourhood gangsters at an early age and climbs the ranks of a Mafia family under the guidance of Jimmy Conway.",
              posterPath: "/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg",
              releaseDate: "1990-09-12",
              title: "GoodFellas"
             ),
        .init(id: 12477,
              overview: "In the final months of World War II, 14-year-old Seita and his sister Setsuko are orphaned when their mother is killed during an air raid in Kobe, Japan. After a falling out with their aunt, they move into an abandoned bomb shelter. With no surviving relatives and their emergency rations depleted, Seita and Setsuko struggle to survive.",
              posterPath: "/k9tv1rXZbOhH7eiCk378x61kNQ1.jpg",
              releaseDate: "1988-04-16",
              title: "Grave of the Fireflies"
             ),
        .init(id: 11216,
              overview: "A filmmaker recalls his childhood, when he fell in love with the movies at his village's theater and formed a deep friendship with the theater's projectionist.",
              posterPath: "/8SRUfRUi6x4O68n0VCbDNRa6iGL.jpg",
              releaseDate: "1988-11-17",
              title: "Cinema Paradiso"
             ),
        .init(id: 346,
              overview: "A samurai answers a village's request for protection after he falls on hard times. The town needs protection from bandits, so the samurai gathers six others to help him teach the people how to defend themselves, and the villagers provide the soldiers with food.",
              posterPath: "/8OKmBV5BUFzmozIC3pPWKHy17kx.jpg",
              releaseDate: "1954-04-26",
              title: "Seven Samurai"
             ),
        .init(id: 637,
              overview: "A touching story of an Italian book seller of Jewish ancestry who lives in his own little fairy tale. His creative and happy life would come to an abrupt halt when his entire family is deported to a concentration camp during World War II. While locked up he tries to convince his son that the whole thing is just a game.",
              posterPath: "/74hLDKjD5aGYOotO6esUVaeISa2.jpg",
              releaseDate: "1997-12-20",
              title: "Life Is Beautiful"
             )
    ]
}
#endif
