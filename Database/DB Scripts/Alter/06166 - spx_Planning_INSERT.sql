IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_INSERT]
(
@PlanningID uniqueidentifier,
@CreatedDate datetime,
@CreatedBy nvarchar(200)
)
AS 

INSERT INTO pPlanning  (PlanningID, CUser, CDate, MUser, MDate)  
VALUES  (@PlanningID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06166', GetDate())
GO
