package jshop.utils;

import javax.servlet.http.HttpServletRequest;

import net.tanesha.recaptcha.ReCaptcha;
import net.tanesha.recaptcha.ReCaptchaFactory;
import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

public class XCaptcha {
	// �?ăng ký key tại đây: https://www.google.com/recaptcha/admin/create
	public static String publicKey = "6LcWJ-wSAAAAAPwUVEj2uAR_xtji6vOSSwV8h8AH";
	public static String privateKey = "6LcWJ-wSAAAAAASWwBIJ7nLU3H6Ngy2lEtzkx1DU";
	
	public static String render(){
		ReCaptcha c = ReCaptchaFactory.newReCaptcha(publicKey, privateKey, false);
		return c.createRecaptchaHtml(null, null);
	}
	
	public static boolean isValid(HttpServletRequest req){
        ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
        reCaptcha.setPrivateKey(privateKey);

        String remoteAddr = req.getRemoteAddr();
        String challenge = req.getParameter("recaptcha_challenge_field");
        String uresponse = req.getParameter("recaptcha_response_field");
        ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);

        return reCaptchaResponse.isValid();
	}
}
