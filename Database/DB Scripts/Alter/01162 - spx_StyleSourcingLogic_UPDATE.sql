
ALTER PROCEDURE [dbo].[spx_StyleSourcingLogic_UPDATE]  (
@StyleSourcingID uniqueidentifier ,
@MDate datetime , 
@MUser nvarchar (200) 
)
AS 


SELECT 1

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01162', GetDate())
GO
