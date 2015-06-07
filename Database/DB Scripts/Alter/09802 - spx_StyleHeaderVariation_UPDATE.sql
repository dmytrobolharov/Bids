IF OBJECT_ID(N'[dbo].[spx_StyleHeaderVariation_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleHeaderVariation_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleHeaderVariation_UPDATE]
(@StyleID uniqueidentifier)
AS 

DECLARE
    @StyleMasterID       	uniqueidentifier,
    @StyleType           	int,
    @WorkflowType        	uniqueidentifier,
    @CustomerNo          	nvarchar(50),
    @DevelopmentID       	uniqueidentifier,
    @DevelopmentNo       	nvarchar(50),
    @SpecNo              	nvarchar(50),
    @Description         	nvarchar(200),
    @StyleCategory       	uniqueidentifier,
    @StyleSet            	int,
    @DueDate             	datetime,
    @RecDate             	datetime,
    @Customer            	nvarchar,
    @Buyer               	nvarchar(200),
    @Designer            	nvarchar(200),
    @SampleMaker         	nvarchar(200),
    @PatternMaker        	nvarchar(200),
    @ProductionManager   	nvarchar(200),
    @TechnicalDesigner   	nvarchar(200),
    @StyleStatus         	nvarchar(200),
    @StyleLocation       	nvarchar(200),
    @WashType            	nvarchar(200),
    @Pitch               	int,
    @MaterialID          	uniqueidentifier,
    @MaterialImageID     	uniqueidentifier,
    @MaterialImageVersion	int,
    @MaterialNo          	nvarchar(200),
    @MaterialName        	nvarchar(200),
    @StyleMaterialID     	uniqueidentifier,
    @DesignSketchID      	uniqueidentifier,
    @TechSketchID        	uniqueidentifier,
    @ConceptSketchID     	uniqueidentifier,
    @ColorSketchID       	uniqueidentifier,
    @DesignSketchVersion 	int,
    @TechSketchVersion   	int,
    @ConceptSketchVersion	int,
    @ColorSketchVersion  	int,
    @DetailSketchID1     	uniqueidentifier,
    @DetailSketchID2     	uniqueidentifier,
    @DetailSketchID3     	uniqueidentifier,
    @DetailSketchID4     	uniqueidentifier,
    @DetailSketchVersion1	int,
    @DetailSketchVersion2	int,
    @DetailSketchVersion3	int,
    @DetailSketchVersion4	int,
    @SpecSketchID1       	uniqueidentifier,
    @SpecSketchID2       	uniqueidentifier,
    @SpecSketchID3       	uniqueidentifier,
    @SpecSketchID4       	uniqueidentifier,
    @SpecSketchVersion1  	int,
    @SpecSketchVersion2  	int,
    @SpecSketchVersion3  	int,
    @SpecSketchVersion4  	int,
   @Markup              	numeric,
    @TargetPrice         	money,
    @SellingPrice        	money,
    @CustomField1        	nvarchar(200),
    @CustomField2        	nvarchar(200),
    @CustomField3        	nvarchar(200),
    @CustomField4        	nvarchar(200),
    @CustomField5        	nvarchar(200),
    @CustomField6        	nvarchar(200),
    @CustomField7    		nvarchar(200),
    @CustomField8        	nvarchar(200),
    @CustomField9        	nvarchar(200),
    @CustomField10       	nvarchar(200),
    @CustomField11       	nvarchar(200),
    @CustomField12       	nvarchar(200),
    @CustomField13       	nvarchar(200),
    @CustomField14       	nvarchar(200),
    @CustomField15       	nvarchar(200),
    @Pc1                 	nvarchar(200),
    @Pc2                 	nvarchar(200),
    @Pc3                 	nvarchar(200),
    @Pc4                 	nvarchar(200),
    @MUser               	nvarchar(200),
    @MDate               	datetime,
    @Change              	int
    --@StyleDetail         	ntext

DECLARE	@CustomField16	nvarchar(200),
		@CustomField17	nvarchar(200),
		@CustomField18	nvarchar(200),
		@CustomField19       	nvarchar(200),
		@CustomField20	nvarchar(200),
		@CustomField21	nvarchar(200),
		@CustomField22       	nvarchar(200),
		@CustomField23	nvarchar(200),
		@CustomField24	nvarchar(200),
		@CustomField25       	nvarchar(200),
		@CustomField26	nvarchar(200),
		@CustomField27	nvarchar(200),
		@CustomField28       	nvarchar(200),
		@CustomField29	nvarchar(200),
		@CustomField30	nvarchar(200)


SELECT     
    @StyleMasterID			= StyleMasterID,
    @StyleType				= StyleType,
    @WorkflowType			= WorkflowType,
    @CustomerNo				= CustomerNo,
    @DevelopmentID			= DevelopmentID,
    @DevelopmentNo			= DevelopmentNo,
    @SpecNo					= SpecNo,
    @Description         	= Description,
    @StyleCategory       	= StyleCategory,
    @StyleSet            	= StyleSet,
    @DueDate             	= DueDate,
    @RecDate             	= RecDate,
    @Customer            	= Customer,
    @Buyer               	= Buyer,
    @Designer            	= Designer,
    @SampleMaker         	= SampleMaker,
    @PatternMaker        	= PatternMaker,
    @ProductionManager   	= ProductionManager,
    @TechnicalDesigner   	= TechnicalDesigner,
    @StyleStatus         	= StyleStatus,
    @StyleLocation       	= StyleLocation,
    @WashType            	= WashType,
    @Pitch               	= Pitch,
    @MaterialID          	= MaterialID,
    @MaterialImageID     	= MaterialImageID,
    @MaterialImageVersion	= MaterialImageVersion,
    @MaterialNo          	= MaterialNo,
    @MaterialName        	= MaterialName,
    @StyleMaterialID     	= StyleMaterialID,
    @DesignSketchID      	= DesignSketchID,
    @TechSketchID        	= TechSketchID,
    @ConceptSketchID     	= ConceptSketchID,
    @ColorSketchID       	= ColorSketchID,
    @DesignSketchVersion 	= DesignSketchVersion,
    @TechSketchVersion   	= TechSketchVersion,
    @ConceptSketchVersion	= ConceptSketchVersion,
    @ColorSketchVersion  	= ColorSketchVersion,
    @DetailSketchID1     	= DetailSketchID1,
    @DetailSketchID2     	= DetailSketchID2,
    @DetailSketchID3     	= DetailSketchID3,
    @DetailSketchID4     	= DetailSketchID4,
    @DetailSketchVersion1	= DetailSketchVersion1,
    @DetailSketchVersion2	= DetailSketchVersion2,
    @DetailSketchVersion3	= DetailSketchVersion3,
    @DetailSketchVersion4	= DetailSketchVersion4,
    @SpecSketchID1       	= SpecSketchID1,
    @SpecSketchID2       	= SpecSketchID2,
    @SpecSketchID3       	= SpecSketchID3,
    @SpecSketchID4       	= SpecSketchID4,
    @SpecSketchVersion1  	= SpecSketchVersion1,
    @SpecSketchVersion2  	= SpecSketchVersion2,
    @SpecSketchVersion3  	= SpecSketchVersion3,
    @SpecSketchVersion4  	= SpecSketchVersion4,
    @Markup              	= Markup,
    @TargetPrice         	= TargetPrice,
    @SellingPrice        	= SellingPrice,
    @CustomField1        	= CustomField1,
    @CustomField2        	= CustomField2,
    @CustomField3        	= CustomField3,
    @CustomField4        	= CustomField4,
    @CustomField5        	= CustomField5,
    @CustomField6        	= CustomField6,
    @CustomField7    		= CustomField7,
	@CustomField8        	= CustomField8,
    @CustomField9        	= CustomField9,
    @CustomField10       	= CustomField10,
    @CustomField11       	= CustomField11,
    @CustomField12       	= CustomField12,
    @CustomField13       	= CustomField13,
    @CustomField14       	= CustomField14,
    @CustomField15       	= CustomField15,
    @Pc1      				= Pc1,
    @Pc2               		= Pc2,
    @Pc3                 	= Pc3,
    @Pc4                 	= Pc4,
    @MUser               	= MUser,
    @MDate               	= MDate,
    @Change              	= Change,

    @CustomField16       	= CustomField16,
    @CustomField17       	= CustomField17,
    @CustomField18       	= CustomField18,
    @CustomField19       	= CustomField19,
    @CustomField20       	= CustomField20,
    @CustomField21       	= CustomField21,
    @CustomField22       	= CustomField22,
    @CustomField23       	= CustomField23,
    @CustomField24       	= CustomField24,
    @CustomField25       	= CustomField25,
    @CustomField26       	= CustomField26,
    @CustomField27       	= CustomField27,
    @CustomField28       	= CustomField28,
    @CustomField29       	= CustomField29,
    @CustomField30       	= CustomField30
FROM  pStyleHeader WITH (NOLOCK)
WHERE (StyleID = @StyleID)


CREATE TABLE #tempStyleDevelopmentItem ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDevelopmentID]    	uniqueidentifier NULL,
	[StyleID]               	uniqueidentifier NULL,
	[SizeRange]             	nvarchar(200) NULL,
	[Variation]             	int NULL,
	[CUser]                 	nvarchar(200) NULL,
	[CDate]                 	datetime NULL,
	[MUser]                 	nvarchar(200) NULL,
	[MDate]                 	datetime NULL,
)

DECLARE @RowStyleLoop 			int
DECLARE @RowStyleCount 			int
DECLARE @tmpStyleID				uniqueidentifier
DECLARE @tmpStyleVariation		int

DECLARE @StyleDevelopmentId uniqueidentifier
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

BEGIN
	INSERT INTO #tempStyleDevelopmentItem (StyleDevelopmentID, StyleID, SizeRange, Variation)
	SELECT StyleDevelopmentID, StyleID, SizeRange, Variation FROM pStyleDevelopmentItem WITH (NOLOCK) 
	WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
END

SELECT * FROM #tempStyleDevelopmentItem

SET @RowStyleLoop = 1
SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

WHILE @RowStyleLoop <= @RowStyleCount 

	BEGIN

		SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

			BEGIN	
			
				UPDATE pStyleHeader
				SET StyleMasterID = @StyleMasterID, StyleType = @StyleType, WorkflowType = @WorkflowType, DevelopmentID = @DevelopmentID, 
					DevelopmentNo = @DevelopmentNo, SpecNo = @SpecNo, Description = @Description, StyleCategory = @StyleCategory, StyleSet = @StyleSet, 
					DueDate = @DueDate, RecDate = @RecDate, Customer = @Customer, Buyer = @Buyer, Designer = @Designer, SampleMaker = @SampleMaker, 
					PatternMaker = @PatternMaker, ProductionManager = @ProductionManager, TechnicalDesigner = @TechnicalDesigner, StyleStatus = @StyleStatus, 
					StyleLocation = @StyleLocation, WashType = @WashType, Pitch = @Pitch, MaterialID = @MaterialID, MaterialImageID = @MaterialImageID, 
					MaterialImageVersion = @MaterialImageVersion, MaterialNo = @MaterialNo, MaterialName = @MaterialName, StyleMaterialID = @StyleMaterialID, 
					DesignSketchID = @DesignSketchID, TechSketchID = @TechSketchID, ConceptSketchID = @ConceptSketchID, ColorSketchID = @ColorSketchID, 
					DesignSketchVersion = DesignSketchVersion, TechSketchVersion = @TechSketchVersion, ConceptSketchVersion = @ConceptSketchVersion, 
					ColorSketchVersion = @ColorSketchVersion, DetailSketchID1 = @DetailSketchID1, DetailSketchID2 = @DetailSketchID2, 
					DetailSketchID3 = @DetailSketchID3, DetailSketchID4 = @DetailSketchID4, DetailSketchVersion1 = @DetailSketchVersion1, 
					DetailSketchVersion2 = @DetailSketchVersion2, DetailSketchVersion3 = @DetailSketchVersion3, DetailSketchVersion4 = @DetailSketchVersion4, 
					SpecSketchID1 = @SpecSketchID1, SpecSketchID2 = @SpecSketchID2, SpecSketchID3 = @SpecSketchID3, SpecSketchID4 = @SpecSketchID4, 
					SpecSketchVersion1 = @SpecSketchVersion1, SpecSketchVersion2 = @SpecSketchVersion2, SpecSketchVersion3 = @SpecSketchVersion3, 
					SpecSketchVersion4 = @SpecSketchVersion4, Markup = @Markup, TargetPrice = @TargetPrice, SellingPrice = @SellingPrice, 
					CustomField1 = @CustomField1, CustomField2 = @CustomField2, CustomField3 = @CustomField3, CustomField4 = @CustomField4, 
					CustomField5 = @CustomField5, CustomField6 = @CustomField6, CustomField7 = @CustomField7, CustomField8 = @CustomField8, 
					CustomField9 = @CustomField9, CustomField10 = @CustomField10, CustomField11 = @CustomField11, CustomField12 = @CustomField12, 
					CustomField13 = @CustomField13, CustomField14 = @CustomField14, CustomField15 = @CustomField15, Change = @Change, MUser = @Muser, 
					MDate = @MDate,
					CustomField16 = @CustomField16,  CustomField17 = @CustomField17,  CustomField18 = @CustomField18,  CustomField19 = @CustomField19, 
					CustomField20 = @CustomField20, CustomField21 = @CustomField21,  CustomField22 = @CustomField22,  CustomField23 = @CustomField23, 
					CustomField24 = @CustomField24,  CustomField25 = @CustomField25,  CustomField26 = @CustomField26,  CustomField27 = @CustomField27, 
					CustomField28 = @CustomField28,  CustomField29 = @CustomField29,  CustomField30 = @CustomField30 
				WHERE StyleID = @tmpStyleID

			END	

		SET @RowStyleLoop = @RowStyleLoop + 1
		
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09802', GetDate())
GO
