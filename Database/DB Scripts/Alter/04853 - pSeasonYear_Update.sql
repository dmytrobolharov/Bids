declare @icnt int
declare @seasonYearid uniqueidentifier
SELECT @icnt=COUNT(*) FROM pSeasonYear WHERE CurrentSeason = 1
if @icnt<=0
begin
	select top 1 @seasonYearid=seasonyearid from pSeasonYear where Active=1	
	update pSeasonYear set CurrentSeason=1 where seasonyearid=@seasonYearid
end

go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04853', GetDate())
GO