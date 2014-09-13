/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItem_INSERT]    Script Date: 03/22/2013 10:27:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItem_INSERT]    Script Date: 03/22/2013 10:27:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_StyleQuoteItem_INSERT]
(
@QuoteItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@StyleID uniqueidentifier,
@IsShared int,
@CUser nvarchar(200),
@CDate datetime,
@CostingTypeID INT = 0
)
AS 

BEGIN
DECLARE 
@DevelopmentID uniqueidentifier,
@StyleSeasonYearID	uniqueidentifier,
@SeasonYearID	uniqueidentifier

SELECT @DevelopmentID = DevelopmentID from pStyleHeader WITH (NOLOCK) where StyleID = @StyleID

SELECT @SeasonYearID = SeasonYearID from pSourcingHeader WITH (NOLOCK) where SourcingHeaderID = @SourcingHeaderID
SELECT @StyleSeasonYearID = StyleSeasonYearID from pStyleSeasonYear WITH (NOLOCK) where StyleID = @StyleID and SeasonYearID=@SeasonYearID

INSERT INTO pStyleQuoteItem 
           (StyleQuoteItemID 
           ,StyleQuoteItemShare
           ,StyleQuoteItemStatusId
           ,StyleDevelopmentID
           ,StyleID
           ,StyleColorID
           ,StyleSourcingID
           ,StyleCostingType
           ,StyleSeasonYearID
           ,SourcingHeaderID 
           ,CUser
           ,CDate)  
           values 
           (
           @QuoteItemID
           ,@IsShared
           ,0
           ,@DevelopmentID
           ,@StyleID
           ,'00000000-0000-0000-0000-000000000000'
           ,@SourcingStyleID
           ,@CostingTypeID
           ,@StyleSeasonYearID 
           ,@SourcingHeaderID
           ,@CUser
           ,@CDate
           )   

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05382', GetDate())
GO


