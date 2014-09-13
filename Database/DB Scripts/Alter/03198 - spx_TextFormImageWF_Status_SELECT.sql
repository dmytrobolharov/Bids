IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TextFormImageWF_Status_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TextFormImageWF_Status_SELECT]
GO

CREATE PROCEDURE spx_TextFormImageWF_Status_SELECT
AS
CREATE TABLE  #Temp (   
Rec_Id int identity(1,1)  ,   
WorkflowStatusMinID  INT ,   
WorkflowStatusMin nvarchar (100) ,
WorkflowStatusMaxID  INT ,   
WorkflowStatusMax nvarchar (100), 
WorkflowStatusOKID  INT ,   
WorkflowStatusOK nvarchar (100) 
)  

INSERT  INTO #Temp ( WorkflowStatusMinID,  WorkflowStatusMin , WorkflowStatusMaxID,  WorkflowStatusMax ,WorkflowStatusOKID,  WorkflowStatusOK ) 
	SELECT '199' AS WorkflowStatusMinID, 'Image(s) missing' AS WorkflowStatusMin , '299' AS  WorkflowStatusMaxID,  'Extra Images' AS WorkflowStatusMax , '399' AS WorkflowStatusOKID, 'Number of Images OK' AS WorkflowStatusOK

SELECT  * FROM #Temp   
DROP TABLE #Temp 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03198', GetDate())

GO   

	