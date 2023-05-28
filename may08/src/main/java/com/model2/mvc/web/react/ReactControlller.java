//package com.model2.mvc.web.react;
//
//import java.awt.Desktop;
//import java.io.BufferedReader;
//import java.io.BufferedWriter;
//import java.io.InputStreamReader;
//import java.io.OutputStreamWriter;
//import java.net.HttpURLConnection;
//import java.net.URI;
//import java.net.URL;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.CrossOrigin;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.client.RestTemplate;
//
//import com.google.gson.JsonObject;
//import com.google.gson.JsonParser;
//
//@RestController
//@RequestMapping("/react/*")
//public class ReactControlller {
//	
//	@RequestMapping( value="phone")
//	public JsonObject exampleController(@RequestParam(value = "phone1", required = true) String phone1, 
//            @RequestParam(value = "phone2", required = true) String phone2, 
//            @RequestParam(value = "phone3", required = true) String phone3) throws Exception{
//		
//		String phone = "{\"phone1\":\"" + phone1 + "\",\"phone2\":\"" + phone2 + "\",\"phone3\":\"" + phone3 + "\"}";
//		System.out.println(phone);
//		
//		JsonParser parser = new JsonParser();
//		JsonObject jsonObj = parser.parse(phone).getAsJsonObject();
//		
//		String reactUrl = "http://192.168.0.116:8080/react/phone";
//		
//		URL url = new URL(reactUrl);
//		
//		// Http ?곌껐 ?앹꽦
//		HttpURLConnection con = (HttpURLConnection) url.openConnection();
//		System.out.println("con : "+con);
//		// Http ?붿껌 ?곗씠???꾩넚
//		con.setRequestMethod("POST");
//		con.setRequestProperty("Content-Type", "application/json");
//        con.setRequestProperty("Accept", " application/json"); // api 由ы꽩媛믪쓣 json?쇰줈 諛쏆쓣 寃쎌슦!
//        con.setDoOutput(true);
//        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
//        bw.write(phone.toString());
//        bw.flush();
//        
//        
//        
////      URI uri = URI.create("javascript:window.open('http://localhost:3000', '?앹뾽李?, 'width=800,height=600');");
////      Desktop.getDesktop().browse(uri);
//		
//        
//        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//        
//        System.out.println("33333333"+br+"444444444");
//        
//        String result = "";
//        String line;
//        while ((line = br.readLine()) != null) {
//            result += line;
//        }
//        
//        System.out.println("111111111"+result+"222222222");
//		
//		/* 2. React濡??묒냽 */
//        
//        Desktop.getDesktop().browse(URI.create("http://127.0.0.1:3000"));
//           
//        bw.close();
//        return jsonObj;
//	}
//}
