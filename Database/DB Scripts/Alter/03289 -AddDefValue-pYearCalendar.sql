/****** Object:  Table [dbo].[pYearCalendar]    Script Date: 04/02/2012 15:57:09 ******/
IF (select count(*) from pYearCalendar)=0
begin
	INSERT INTO [dbo].[pYearCalendar]
           ([YearMonth1]
           ,[YearMonth2]
           ,[YearMonth3]
           ,[YearMonth4]
           ,[YearMonth5]
           ,[YearMonth6]
           ,[YearMonth7]
           ,[YearMonth8]
           ,[YearMonth9]
           ,[YearMonth10]
           ,[YearMonth11]
           ,[YearMonth12]
           )
     VALUES
           (0
           ,0
           ,1
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
          )
 end
 
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03289'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03289', GetDate())

END

GO