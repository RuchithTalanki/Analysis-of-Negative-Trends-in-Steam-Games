USE SteamGames;

SELECT 
     FSG.AppID,
	 FSG.Name,
	 cast(FSG.Relesed_Date as date) AS Relesed_Date,
	 FSG.Estimated_Owners,
	 FSG.Price as Price,
	 FSG.DLC_count,
	 FSG.Positive,
	 FSG.Negative,
	 FSG.Publishers,
	 FSG.Developers,
	 OS.Mac,
	 OS.Windows,
	 OS.Linux,
	 DC.Category_1 AS Categories,
	 DG.Genre_1 AS  Genres
FROM Fact_Steam_Games as FSG
JOIN Dim_OS as OS on FSG.AppID = OS.AppID
JOIN Dim_Category AS DC ON DC.AppID = FSG.AppID
JOIN Dim_Genres AS DG ON DG.AppID = FSG.AppID;

-- Highest priced Games
SELECT * FROM STEAM_GAMES_DATA
where price = (select max(price) from steam_games_data);

-- Lowest Priced Game.
SELECT * FROM STEAM_GAMES_DATA
where price = (select min(price) from steam_games_data
where price <> 0);

-- Which Developer Company made the highest number of games ?
select Developers,sum(estimated_owners) as Users from steam_games_data
group by developers 
order by 2 DESC;
-- Game with most users.
select * from steam_games_data
where Estimated_owners = ( select max(estimated_owners) from steam_games_data);

-- Which Publishers published games are more popular ?
select top 5 Publisher,sum(Estimated_Owners) as Users from steam_games_data
group by Publisher
order by 2 DESC;

-- Top Most Popular Genres
SELECT top 5
    Genres, 
    SUM(CAST(Estimated_Owners AS bigint)) AS Users 
FROM 
    steam_games_data 
GROUP BY 
    Genres 
ORDER BY 
    Users DESC;

--Top Most least Popular Genres
SELECT top 5
    Genres, 
    SUM(CAST(Estimated_Owners AS bigint)) AS Users 
FROM 
    steam_games_data 
GROUP BY 
    Genres 
ORDER BY 
    Users asc;
