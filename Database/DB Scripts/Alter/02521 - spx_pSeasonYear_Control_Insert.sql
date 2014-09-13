IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pSeasonYear_Control_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pSeasonYear_Control_Insert]
GO

create procedure [dbo].spx_pSeasonYear_Control_Insert(
@Year nvarchar(4), @CUser as nvarchar(50),@CDate as datetime ) as
Declare @Season nvarchar(20)

declare cur_SY cursor For
select distinct(Custom) from pSeason
open cur_SY;
Fetch next from cur_SY into @Season
WHILE @@FETCH_STATUS = 0
BEGIN
if (select count(YEAR) from pSeasonYear where Season = @Season and YEAR = @Year) = 0
insert into pSeasonYear (SeasonYearID,Season,Year,Active,CustomID,CUser,CDate) values(NEWID(),@Season,@Year,1,NEWID(),@CUser,@CDate)
Fetch next from cur_SY into @Season
END
close cur_SY;
Deallocate cur_SY;

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02521'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.2.0000', '02521', GetDate())
END
GO