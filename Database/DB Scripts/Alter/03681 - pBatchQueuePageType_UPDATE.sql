UPDATE [dbo].[pBatchQueuePageType]
SET BatchQueuepageXMLGridAlternating='BatchQ_Material_GroupItemImage_Default.xml',
	BatchQueueGridAlternatingName='Thumbnail',
	BatchQueueGridXMLThumbnail='BatchQ_Material_GroupItemImage_Thumbnail.xml'
WHERE BatchQueuePageTypeID='74495f03-d78b-e011-81e9-005056c00009'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03681', GetDate())
GO