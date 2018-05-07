package eshop.admin.action;

import org.apache.struts2.convention.annotation.Action;

import com.opensymphony.xwork2.ActionSupport;

import eshop.util.UploadFile;
import eshop.util.XResponse;

public class NicEditorController extends ActionSupport{
	
	@Action(value="/nic-editor/upload")
	public void nicEditorUpload() throws Exception {
String path = "images/nic-images/";		
		nicImage.renameTo(new File(path, nicImageFileName));
		String uri = "images/nic-images/" + nicImageFileName;
		XResponse.write("<script>top.nicUploadButton.statusCb({ done:1, width:'300', url:'" + uri + "'});</script>");
	}
	
	File nicImage;
	String nicImageFileName;
	String nicImageContentType
}
