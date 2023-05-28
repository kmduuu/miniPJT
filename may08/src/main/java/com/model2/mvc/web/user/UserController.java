package com.model2.mvc.web.user;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Map;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.client.ClientProtocolException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.KakaoService;
import com.model2.mvc.service.user.NaverService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Autowired
	private KakaoService kakaoService;
	@Autowired
	private NaverService naverService;
	
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {
		
		System.out.println("/user/addUser : POST");
		//Business Logic
		System.out.println("/user/addUser : " + user);
		System.out.println(user.getAddr());
		System.out.println(user.getUserId());
		userService.addUser(user);
		
		System.out.println("phone : "+user.getPhone());
		
		return "redirect:/user/loginView.jsp";
	}
	

	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	

	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}

	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		System.out.println(user+"홍길동");
		return "redirect:/index.jsp";
	}
		
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	
	@SuppressWarnings("removal")
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model 과 View 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}

	
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
	@RequestMapping( value="kakao" , method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println("######" + code);
		
		// 카카오에서 인가 받은 코드를 이용하여 엑세스 토큰 발급 요청
		String access_Token = kakaoService.getAccessToken(code);
		System.out.println("여기는 컨트롤러."+access_Token);
		
		// 발급받은 엑세스 토큰을 이용하여 카카오 사용자 정보 요청
		Map<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
		System.out.println("login Controller : " + userInfo);
		
		// 가져온 사용자 정보를 세션에 저장
		
		User user = new User();
		String id = (String) userInfo.get("id");
		System.out.println(id);
		user.setUserId(id);
		session = request.getSession();
		session.setAttribute("user", user);
		
		System.out.println(user);
		System.out.println(user.getUserId()+"즐라탄");
		
		// 로그인 후 메인 페이지로 이동
		return "redirect:/index.jsp";
		
	}
	
	@RequestMapping(value = "naver", method=RequestMethod.GET)
	public String naverLogin(@RequestParam(value = "code", required = false) String code, HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println("####" + code+"ronaldo");
		// 네이버에서 인가받은 코드를 사용하여 엑세스 토큰 발급 요청
		String access_Token = "";
	    access_Token = naverService.getAccessToken(code);
		System.out.println("여기는 컨트롤러 " + access_Token);
		
		// 토큰으로 userInfo 요청
		Map<String, Object> userInfo = naverService.getUserInfo(access_Token);
		System.out.println("login Controller : " + userInfo);
		
		// 세션에 내 정보 저장
		User user = new User(); // 인스턴스 생성
		String id = (String) userInfo.get("id");
		System.out.println(id+"최성락호날두");
		user.setUserId(id);
		//session = request.getSession();
		session.setAttribute("user", user);
		session = request.getSession();
		System.out.println(user);
		System.out.println(user.getUserId()+"즐라탄");
		
		return "redirect:/index.jsp";
		
	}
	
	//@PostMapping(value = "check")
	@RequestMapping(value = "check", method=RequestMethod.POST)
	public String phoneCheck(@RequestParam("phone") String phone, @RequestParam("rnd") String rnd, HttpServletRequest request) throws ClientProtocolException, IOException, URISyntaxException {
		
		System.out.println("welcome~~");
		System.out.println(phone);
		
		String hostNameUrl = "https://sens.apigw.ntruss.com"; // 도메인
		String requestUrl = "/sms/v2/services/";
		String requestUrlType = "/messages";
		String accessKey = "QJBLE3FkYnN44nDIiFfZ";
		String secretKey = "f8JTJ44m4cFQwO188ImbioHA16VvQIJP2FNp8BUU";
		String serviceId = "ncp:sms:kr:305152260305:phone0501";
		String method = "POST";
		String time = Long.toString(System.currentTimeMillis());
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;
		
		// Header 생성
		System.out.println("11111111111111111111111111");
		JsonObject bodyJson = new JsonObject();
		JsonObject toJson = new JsonObject();
		JsonArray toArr = new JsonArray();
		
        System.out.println("22222222222222222222222222");
        // 난수와 함께 전송
        
        toJson.addProperty("content", "Going 본인인증 ["+rnd+"]");
        toJson.addProperty("to", phone);
        toArr.add(toJson);
	    System.out.println("33333333333333333333333333");
        System.out.println("toArr : "+toArr);
        
        // 메시지 Type (sms | lms)
        bodyJson.addProperty("type", "sms");
        bodyJson.addProperty("contentType","COMM");
		bodyJson.addProperty("content","1234");
        bodyJson.addProperty("countryCode","82");
        bodyJson.addProperty("from","01098669138");
        bodyJson.add("messages", toArr);	
        
        String body = bodyJson.toString();
        System.out.println("body : "+body);
        
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", time);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, time, method, accessKey, secretKey));
            con.setRequestMethod(method);
            
            System.out.println("con : "+con);
            
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(body.getBytes());
            wr.flush();
            
            int responseCode = con.getResponseCode();
            BufferedReader br;
            System.out.println("responseCode" +" " + responseCode);
            if(responseCode==202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            wr.close();
            br.close();
            
            System.out.println("wr : "+wr);
            System.out.println("br : "+br);
            System.out.println(response.toString());
            
        } catch (Exception e) {
            System.out.println(e);
        }
      //이 함수 return 없었는데 View에 아무것도 리턴 없으면 자기 컨트롤러/자기 함수 로 들어가는듯
        // 그래서 아무 페이지나 리턴시켜줬더니 200나옴아하... 감사합니다 
        return "forward:/user/phonecheck.jsp";
	}
	
	public static String makeSignature(
	        String url, 
	        String time, 
	        String method, 
	        String accessKey, 
	        String secretKey
	    ) throws NoSuchAlgorithmException, InvalidKeyException {
	        
		    String space = " "; 
		    String newLine = "\n"; 
		    
		    String message = new StringBuilder()
		        .append(method)
		        .append(space)
		        .append(url)
		        .append(newLine)
		        .append(time)
		        .append(newLine)
		        .append(accessKey)
		        .toString();

		    SecretKeySpec signingKey;
		    String encodeBase64String;
			try {
				signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
				Mac mac = Mac.getInstance("HmacSHA256");
				mac.init(signingKey);
				byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
				encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
			} catch (UnsupportedEncodingException e) {
				encodeBase64String = e.toString();
			}
		    
		System.out.println("encode Base 64 String : "+encodeBase64String);
		System.out.println("message(String) : "+message);
		  return encodeBase64String;
		}
}
