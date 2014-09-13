alter table psourcingHeader
add seasonYearId uniqueidentifier NULL

GO

update pSourcingHeader set pSourcingHeader.seasonyearID =  pSeasonYear.SeasonYearID from
pSourcingHeader inner join pSeasonYear on (pSeasonYear.Season = pSourcingHeader.Season and pSeasonYear.Year = pSourcingHeader.Year)
where pSourcingHeader.seasonyearID is null

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04314', GetDate())
GO