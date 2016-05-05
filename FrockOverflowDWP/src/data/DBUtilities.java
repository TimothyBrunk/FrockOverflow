package data;

public class DBUtilities {
	public static String massageInputText(String s) {
		s = s.replaceAll("<", "&lt");
		s = s.replaceAll(">", "&gt");
		s = s.replaceAll("``~", "<pre class=\"snippet\"><code>");
		s = s.replaceAll("~``", "</code></pre>");
		return s;
	}
	

}
