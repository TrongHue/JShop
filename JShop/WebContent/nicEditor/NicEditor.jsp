<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Insert title here</title>
	<script src="admin/nicEdit.js" type="text/javascript"></script>
		<script type="text/javascript">
		bkLib.onDomLoaded(function() {
			new nicEditor({ 
				fullPanel: true, 
				iconsPath : 'nicEditorIcons.gif', 
				uploadURI: '/EShopV20/NicEditor/upload' 
			}).panelInstance('content');
		});
		</script>
</head>
<body>
<form>
	<textarea id="content" rows="5" cols="50"></textarea>
	<br>
	<input type="submit" value="Save">
</form>
</body>
</html>