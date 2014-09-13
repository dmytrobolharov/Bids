SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_pGRSizeRange_SELECT') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_pGRSizeRange_SELECT
GO


CREATE  PROCEDURE [dbo].[spx_pGRSizeRange_SELECT]
(@cols NVARCHAR(2000),
@Where NVARCHAR(2000))
AS 


--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)
if len(@Where) > 0
	begin
		SET @query = N'SELECT sizerangeid, sizerange, '  + @cols + ', MUser, MDate
		FROM 
		(SELECT  pgrsizerangedetail.sizerangeid, sizerange, sizecount, SizeName, MUser, MDate      
		FROM   pgrsizerangedetail, pgrsizerange  where pgrsizerangedetail.sizerangeid = pgrsizerange.sizerangeGuidid
		 AND ' + @Where + ' ) p
		PIVOT
		(
		MAX([SizeName])
		FOR sizecount IN
		('+ @cols +' )
		) AS pvt
		Order by sizerange;'
	end
else
	begin
		SET @query = N'SELECT sizerangeid, sizerange, '  + @cols + ', MUser, MDate
		FROM 
		(SELECT  pgrsizerangedetail.sizerangeid, sizerange, sizecount, SizeName, MUser, MDate      
		FROM   pgrsizerangedetail, pgrsizerange  where pgrsizerangedetail.sizerangeid = pgrsizerange.sizerangeGuidid
		) p
		PIVOT
		(
		MAX([SizeName])
		FOR sizecount IN
		('+ @cols +' )
		) AS pvt
		Order by sizerange;'
	end


Execute(@query)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '579', GetDate())
GO

