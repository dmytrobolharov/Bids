<%@ WebHandler Language="C#" Class="SketchExport" %>

using System;
using System.Web;

public class SketchExport : IHttpHandler 
{
    private string fileName = string.Empty;
    private string fileType = string.Empty;
	private string fileData = string.Empty;
    
    public void ProcessRequest (HttpContext context) 
    {
        try
        {
            fileName = context.Request.Form["name"];
            fileType = context.Request.Form["type"];
			fileData = context.Request.Form["imageData"];
          
            context.Response.AddHeader("Content-Type", "image/png");
			context.Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName + "." + fileType);
            	
			byte[] data = Convert.FromBase64String(fileData);
            context.Response.OutputStream.Write(data, 0, data.Length);
            context.Response.End();
        }
        catch (Exception ex)
        {
            //context.Response.Write(ex.Message);
        }
    }
 
    public bool IsReusable 
    {
        get 
        {
            return false;
        }
    }

}