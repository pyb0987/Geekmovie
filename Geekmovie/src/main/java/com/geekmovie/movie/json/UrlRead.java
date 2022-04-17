package com.geekmovie.movie.json;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONException;
import org.json.JSONObject;
 
public class UrlRead {
	private static String jsonReadAll(Reader reader) throws IOException {
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = reader.read()) != -1) {
			sb.append((char) cp);
		}
		return sb.toString();
	}

    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
    		InputStream is = new URL(url).openStream();
    		try {
    		BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
    			String jsonText = jsonReadAll(rd);
    			JSONObject json = new JSONObject(jsonText);
    			return json;
    		} finally {
    			is.close();
    		}
    }
    
    public static String readStringFromUrl(String url) throws IOException, JSONException {
		InputStream is = new URL(url).openStream();
		try {
		BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = jsonReadAll(rd);
			return jsonText;
		} finally {
			is.close();
		}
}

}
