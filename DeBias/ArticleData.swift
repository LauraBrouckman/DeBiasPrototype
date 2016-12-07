//
//  ArticleData.swift
//  DeBias
//
//  Copyright © 2016 Stanford University. All rights reserved.
//

// This file stores hard-coded article data
// Some ideological classifications come from: businessinsider.com/here-are-the-most-and-least-trusted-news-outlets-in-america-2014-10
// Others from: businessinsider.com/what-your-preferred-news-outlet-says-about-your-political-ideology-2014-10

// Article is a json-style dictionary with following key-value pairs:
// Primary Author, Title, Title of News Organization, Date, URL, Type, Type Explanation
// Based on MLA Citation style
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

let articleTypes = ["veryConservative", "conservative", "neutral", "liberal", "veryLiberal"]

var veryConservativeArticles = Array<Dictionary<String, String>>()
var conservativeArticles = Array<Dictionary<String, String>>()
var neutralArticles = Array<Dictionary<String, String>>()
var liberalArticles = Array<Dictionary<String, String>>()
var veryLiberalArticles = Array<Dictionary<String, String>>()

// MARK: - Very Conservative Articles
func addArticles() {
veryConservativeArticles.append([
    "author" : "Jon Street",
    "title" : "ISIS claims responsibility for Ohio State University attack",
    "source" : "The Blaze",
    "date" : "November 29, 2016",
    "url" : "theblaze.com/news/2016/11/29/isis-claims-responsibility-for-ohio-state-university-attack/",
    "type" : articleTypes[0],
    "typeExplanation" : "'The Blaze' is categorized as 'Very Conservative' by Business Insider's 2014 study.",
    "image": "vConsIsis.jpg"
    ])

veryConservativeArticles.append([
    "author" : "Ian Hanchett",
    "title" : "Gore: We Should Abolish Electoral College, Popular Vote Would 'Stimulate Public Participation'",
    "source" : "Breitbart",
    "date" : "November 29, 2016",
    "url" : "breitbart.com/video/2016/11/29/gore-we-should-abolish-electoral-college-popular-vote-would-stimulate-public-participation/",
    "type" : articleTypes[0],
    "typeExplanation" : "'Breitbart' is categorized as 'Very Conservative' by Business Insider's 2014 study.",
    "image": "vConsGore.png"
    ])

veryConservativeArticles.append([
    "author" : "Hannity.com Staff",
    "title" : "Ohio State Attacker: 'By Allah, I Am Willing To Kill A Billion Infidels'",
    "source" : "The Sean Hannity Show",
    "date" : "November 29, 2016",
    "url" : "hannity.com/articles/hanpr-election-493995/ohio-state-attacker-by-allah-i-15341588/",
    "type" : articleTypes[0],
    "typeExplanation" : "'The Sean Hannity Show' is categorized as 'Very Conservative' by Business Insider's 2014 study.",
    "image": "vConsInfidels.jpg"
    ])

veryConservativeArticles.append([
    "author" : "Rush Limbaugh",
    "title" : "Is Trump Toying with Romney?",
    "source" : "The Rush Limbaugh Show",
    "date" : "November 29, 2016",
    "url" : "rushlimbaugh.com/daily/2016/11/29/is_trump_toying_with_romney",
    "type" : articleTypes[0],
    "typeExplanation" : "'The Rush Limbaugh Show' is categorized as 'Very Conservative' by Business Insider's 2014 study.",
    "image": "vConsTrumpRomney.jpg"
    ])


// MARK: - Conservative Articles
conservativeArticles.append([
    "author" : "FoxNews.com",
    "title" : "Trump to nominate Steven Mnuchin for Treasury Secretary, sources say",
    "source" : "Fox News",
    "date" : "November 29, 2016",
    "url" : "foxnews.com/politics/2016/11/29/trump-to-nominate-steven-mnuchin-for-treasury-secretary-sources-say.html",
    "type" : articleTypes[1],
    "typeExplanation" : "'Fox News' is categorized as 'Conservative' by Business Insider's 2014 study.",
    "image": "consStevenMnuchin.jpg"
    ])

conservativeArticles.append([
    "author" : "FoxNews.com",
    "title" : "Trump nominates Elaine Chao to be Transportation Secretary",
    "source" : "Fox News",
    "date" : "November 29, 2016",
    "url" : "foxnews.com/politics/2016/11/29/trump-nominates-elaine-chao-to-be-transportation-secretary.html",
    "type" : articleTypes[1],
    "typeExplanation" : "'Fox News' is categorized as 'Conservative' by Business Insider's 2014 study.",
    "image": "consElaineChao.jpg"
    ])

conservativeArticles.append([
    "author" : "Jasper Hamill",
    "title" : "Gigantic underground oceans could be full of 'aliens'",
    "source" : "The New York Post",
    "date" : "November 29, 2016",
    "url" : "nypost.com/2016/11/29/gigantic-underground-oceans-could-be-full-of-aliens/",
    "type" : articleTypes[1],
    "typeExplanation" : "'The New York Post' is owned by 'News Corp', a historically 'Conservative' news organization.",
    "image": "consAliens.png"
    ])

conservativeArticles.append([
    "author" : "Travis Dorman",
    "title" : "Wildfires lead to evacuation of downtown Gatlinburg",
    "source" : "The Knoxville News Sentinel",
    "date" : "November 29, 2016",
    "url" : "knoxnews.com/story/news/local/tennessee/2016/11/28/rain-just-what-east-tennessee-firefighters-ordered/94535434/",
    "type" : articleTypes[1],
    "typeExplanation" : "This article was recommended by 'The Drudge Report', which is categorized as 'Conservative' by Business Insider's 2014 study.",
    "image": "consFires.JPG"
    ])

conservativeArticles.append([
    "author" : "Ben Leubsdorf",
    "title" : "Company Earnings Show Strength as U.S. Growth Picks Up",
    "source" : "The Wall Street Journal",
    "date" : "November 29, 2016",
    "url" : "wsj.com/articles/u-s-gdp-growth-revised-up-corporate-profits-rose-in-third-quarter-1480426301",
    "type" : articleTypes[1],
    "typeExplanation" : "'The Wall Street Journal' is categorized as 'Conservative' by Business Insider's 2014 study.",
    "image": "consWSJ.jpg"
    ])

// MARK: - Neutral Articles
neutralArticles.append([
    "author" : "Colin Campbell",
    "title" : "Delta CEO calls for 'civility on our planes' after video shows rowdy pro-Trump passenger",
    "source" : "Yahoo News",
    "date" : "November 28, 2016",
    "url" : "yahoo.com/news/delta-ceo-calls-for-civility-on-our-planes-after-video-shows-rowdy-pro-trump-passenger-181824872.html",
    "type" : articleTypes[2],
    "typeExplanation" : "'Yahoo News' is categorized as 'Neutral' by Business Insider's 2014 study.",
    "image": "neutralDelta.png"
    ])

neutralArticles.append([
    "author" : "CBS News",
    "title" : "Trump on flag burning: 'There must be consequences'",
    "source" : "CBS News",
    "date" : "November 29, 2016",
    "url" : "cbsnews.com/news/donald-trump-flag-burning-tweets-there-must-be-consequences/",
    "type" : articleTypes[2],
    "typeExplanation" : "'CBS News' is categorized as 'Neutral' by Business Insider's 2014 study.",
    "image": "neutralFlagBurning.jpg"
    ])

neutralArticles.append([
    "author" : "Phil Wahba",
    "title" : "Kellogg to Stop Advertising on Breitbart Over Values Difference",
    "source" : "Fortune",
    "date" : "November 29, 2016",
    "url" : "fortune.com/2016/11/29/kellogg-breitbart-trump/",
    "type" : articleTypes[2],
    "typeExplanation" : "This article was recommended by 'Google News', which is categorized as 'Neutral' by Business Insider's 2014 study.",
    "image": "neutralKellog.jpg"
    ])

neutralArticles.append([
    "author" : "Suzanne Russell",
    "title" : "Driver who struck Tracy Morgan's van pleads guilty",
    "source" : "USA Today",
    "date" : "November 29, 2016",
    "url" : "usatoday.com/story/life/people/2016/11/29/driver-who-struck-tracy-morgans-van-pleads-guilty/94628098/",
    "type" : articleTypes[2],
    "typeExplanation" : "'USA Today' is categorized as 'Neutral' by Business Insider's 2014 study.",
    "image": "neutralTracyMorgan.jpg"
    ])

neutralArticles.append([
    "author" : "Josh Wingrove",
    "title" : "Trudeau Backs Kinder Morgan, Enbridge Pipelines in Oil Boost",
    "source" : "Bloomberg",
    "date" : "November 29, 2016",
    "url" : "bloomberg.com/news/articles/2016-11-29/canada-s-trudeau-approves-kinder-morgan-s-trans-mountain-line",
    "type" : articleTypes[2],
    "typeExplanation" : "'Bloomberg' is categorized as 'Neutral' by Business Insider's 2014 study.",
    "image": "neutralTrudeau.jpeg"
    ])

neutralArticles.append([
    "author" : "Jeffrey Cook",
    "title" : "Early Evidence Points to Nightmare Scenario for Brazilian Soccer Team's Ill-Fated Flight",
    "source" : "ABC News",
    "date" : "November 29, 2016",
    "url" : "abcnews.go.com/International/early-evidence-points-nightmare-scenario-brazilian-soccer-teams/story",
    "type" : articleTypes[2],
    "typeExplanation" : "'ABC News' is categorized as 'Neutral' by Business Insider's 2014 study.",
    "image": "neutralPlane.png"
    ])

// MARK: - Liberal Articles
liberalArticles.append([
    "author" : "Leigh Ann Caldwell",
    "title" : "House Democrats to Vote on Leadership as Nancy Pelosi Faces Challenger",
    "source" : "NBC News",
    "date" : "November 29, 2016",
    "url" : "nbcnews.com/politics/congress/democrats-vote-house-leadership-nancy-pelosi-faces-challenger-n689856",
    "type" : articleTypes[3],
    "typeExplanation" : "'NBC News' is categorized as 'Liberal' by Business Insider's 2014 study.",
    "image": "liberalPelosi.jpg"
    ])

liberalArticles.append([
    "author" : "Nina Golgowski",
    "title" : "Argument Between Grandmas Ends In Shootout At Texas Walmart, Cops Say",
    "source" : "The Huffington Post",
    "date" : "November 29, 2016",
    "url" : "huffingtonpost.com/entry/grandma-shootout-at-walmart_us_583d828ce4b0860d611656ee",
    "type" : articleTypes[3],
    "typeExplanation" : "'The Huffington Post' is categorized as 'Liberal' by Business Insider's 2014 study.",
    "image": "liberalWalmart.jpeg"
    ])

liberalArticles.append([
    "author" : "Dana Milbank",
    "title" : "The election really was rigged",
    "source" : "The Washington Post",
    "date" : "November 29, 2016",
    "url" : "washingtonpost.com/opinions/the-election-really-was-rigged/2016/11/29/c2ed58d8-b666-11e6-a677-b608fbb3aaf6_story.html",
    "type" : articleTypes[3],
    "typeExplanation" : "'The Washington Post' is categorized as 'Liberal' by Business Insider's 2014 study.",
    "image": "liberalElection.jpg"
    ])

liberalArticles.append([
    "author" : "Eli Stokols",
    "title" : "Trump's Twitter addiction could reshape the presidency",
    "source" : "Politico",
    "date" : "November 29, 2016",
    "url" : "politico.com/story/2016/11/donald-trump-twitter-231959",
    "type" : articleTypes[3],
    "typeExplanation" : "'Politico' is categorized as 'Liberal' by Business Insider's 2014 study.",
    "image": "liberalTrumpTwitter.jpeg"
    ])

liberalArticles.append([
    "author" : "Nidhi Subbaraman",
    "title" : "The Tribe That's Suing The US Government To Keep Its Promises",
    "source" : "Buzzfeed News",
    "date" : "November 17, 2016",
    "url" : "buzzfeed.com/nidhisubbaraman/the-tribe-thats-suing-the-us-government-to-keep-its-promises",
    "type" : articleTypes[3],
    "typeExplanation" : "'Buzzfeed' is categorized as 'Liberal' by Business Insider's 2014 study.",
    "image": "liberalTribe.jpg"
    ])

// MARK: - Very Liberal Articles
veryLiberalArticles.append([
    "author" : "Hwaida Saad",
    "title" : "Thousands Flee Parts of Aleppo, Syria, as Assad’s Forces Gain Ground",
    "source" : "The New York Times",
    "date" : "November 29, 2016",
    "url" : "nytimes.com/2016/11/29/world/middleeast/thousands-flee-onslaught-in-aleppo-as-assads-forces-gain-ground.html",
    "type" : articleTypes[4],
    "typeExplanation" : "'The New York Times' is categorized as 'Very Liberal' by Business Insider's 2014 study.",
    "image": "veryLiberalSyria.jpg"
    ])

veryLiberalArticles.append([
    "author" : "Nathan Heller",
    "title" : "India Takes a Big Step Back from Cash",
    "source" : "The New Yorker",
    "date" : "November 29, 2016",
    "url" : "newyorker.com/business/currency/india-takes-a-big-step-back-from-cash",
    "type" : articleTypes[4],
    "typeExplanation" : "'The New Yorker' is categorized as 'Very Liberal' by Business Insider's 2014 study.",
    "image": "veryLiberalIndia.jpg"
    ])

veryLiberalArticles.append([
    "author" : "William Saletan",
    "title" : "How to Manipulate Donald Trump",
    "source" : "Slate",
    "date" : "November 29, 2016",
    "url" : "slate.com/articles/news_and_politics/politics/2016/11/how_to_manipulate_donald_trump.html",
    "type" : articleTypes[4],
    "typeExplanation" : "'Slate' is categorized as 'Very Liberal' by Business Insider's 2014 study.",
    "image": "veryLiberalManipulateTrump.jpg"
    ])

veryLiberalArticles.append([
    "author" : "Merrit Kennedy",
    "title" : "Pentagon Finds Human Errors Led To Strikes On Syrian Government-Aligned Troops",
    "source" : "NPR",
    "date" : "November 29, 2016",
    "url" : "npr.org/sections/thetwo-way/2016/11/29/503760817/pentagon-finds-human-errors-led-to-strikes-on-syrian-government-aligned-troops",
    "type" : articleTypes[4],
    "typeExplanation" : "'NPR' is categorized as 'Very Liberal' by Business Insider's 2014 study.",
    "image": "veryLiberalPentagon.jpg"
    ])
    return
}

func getVeryConservativeArticles() -> [Dictionary<String, String>] {
    return veryConservativeArticles
}

func getConservativeArticles() -> [Dictionary<String, String>] {
    return conservativeArticles
}

func getNeutralArticles() -> [Dictionary<String, String>] {
    return neutralArticles
}

func getLiberalArticles() -> [Dictionary<String, String>] {
    return liberalArticles
}

func getVeryLiberalArticles() -> [Dictionary<String, String>] {
    return veryLiberalArticles
}